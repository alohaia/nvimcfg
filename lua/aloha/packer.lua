local packer = {}

local utils = aloha.utils

local api = vim.api
local fn = vim.fn
local join = table.concat
local split = vim.split
local info = utils.info
local warn = utils.warn
local err = utils.err

local base_path = '' -- initialized in packer:init()
local added_plugins = {} -- opt plugins that have been added and whose configs have been loaded

-- only support cwd for system command
local function exec(cmd, cwd, cmd_type)
    local rt = true -- return value

    -- if 'cmd_type' is provided, use it to determine type of 'cmd'
    if not cmd_type then goto check end

    if cmd_type == 'function' then
        cmd()
    elseif cmd_type == 'vim' then
        vim.cmd(cmd)
    elseif cmd_type == 'cmd' then
        if cwd then
            print(vim.fn.system(string.format('cd %s && %s', cwd, cmd)))
        else
            print(vim.fn.system(cmd))
        end
    elseif cmd_type == 'lua' then
        local func,mes = load(cmd)
        if func then
            func()
        else
            err('%s failed: %s', cmd, mes)
            rt = false
        end
    end
    goto finish

    ::check::
    if type(cmd) == 'function' then
        cmd()
    elseif type(cmd) == 'string' then
        local first = cmd:sub(1, 1)
        if first == ':' then
            vim.cmd(cmd:sub(2))
        elseif first == '!' then
            if cwd then
                print(vim.fn.system(string.format('cd %s && %s', cwd, cmd:sub(2))))
            else
                print(vim.fn.system(cmd:sub(2)))
            end
        else
            local func,mes = load(cmd)
            if func then
                func()
            else
                err('%s failed: %s', cmd, mes)
                rt = false
            end
        end
    end

    ::finish::
    -- for function and vim.cmd, rt is always true
    return rt
end

local function is_opt(settings)
    if settings.opt or settings.ft or settings.cmd or settings.enable ~= nil then
        return true
    else
        return false
    end
end

local function is_installed(name)
    if fn.glob(base_path .. (is_opt(packer.plugins[name]) and '/opt/' or '/start/')
        .. split(name, '/')[2]) ~= '' then
        return true
    else
        return false
    end
end

local function plugin_path(name)
    if is_opt(packer.plugins[name]) then
        return base_path .. '/opt/' .. split(name, '/')[2]
    else
        return base_path .. '/start/' .. split(name, '/')[2]
    end
end

local function fullname(name)
    for plugin_name,_ in pairs(packer.plugins) do
        local bare_plugin_name = split(plugin_name, '/')[2]
        if name == bare_plugin_name then
            return plugin_name
        end
    end
    return nil
end

function packer.ensure(name)
    name = fullname(name)
    if name == nil then
        return 1        -- not found in config
    elseif not is_installed(name) then
        return 2        -- not installed
    elseif is_opt(packer.plugins[name]) and not added_plugins[name] then
        return 3        -- opt not added
    end
    return 0
end


function packer:init(configs)
    --{{1 initialization
    -- default arguments
    self.plugins = (type(configs.plugins) == 'table') and configs.plugins or {}
    self.plugin_configs = type(configs.plugin_configs) == 'table' and configs.plugin_configs or {}
    self.config = vim.tbl_deep_extend('keep', configs.config, {
        pack_root = fn.stdpath('data') .. '/site/pack',
        pack_name = 'packer',
        git = 'git',
        rm = 'rm -rf',
    })

    -- others vars
    base_path = self.config.pack_root .. '/' .. self.config.pack_name
    --}}1 initialization

    self:loadConfig() -- must be called before self:prepareOptPlugins()
    self:prepareOptPlugins()

    self.plugin_list = {}
    for name,_ in pairs(self.plugins) do
        local _,bare_name = name:match([[^([^/]*)/([^/]*)$]])
        table.insert(self.plugin_list, bare_name)
    end

    return self
end

function packer.plugin_complete()
    return join(packer.plugin_list, '\n')
end

local function onread(error, data)
    if error then
        print('ERROR: ' .. error)
    end
    if data then
        local vals = vim.split(data, '\n')
        for _, d in pairs(vals) do
            if d == '' then goto continue end
            print('INFO: ' .. d)
            ::continue::
        end
    end
end

local handle, handle1
local failed_count = 0
local function _install(i, git_cmd, plugins)
    if is_installed(plugins[i]) then
        info("%s exists and is not empty, remove and reinstall", plugin_path(plugins[i]))
        exec(packer.config.rm .. ' ' .. plugin_path(plugins[i]), nil, 'cmd')
    end

    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    i = i or 1
    local total = #plugins
    info('[%d/%d] downloading %s...', i, total, plugins[i])
    local _args = {
        'clone', '--depth=1',
        '--recurse-submodules',
        packer.plugins[plugins[i]].branch and ('--branch=' .. packer.plugins[plugins[i]].branch) or nil,
        git_cmd.config.shallow_submodules and '--shallow-submodules' or nil,
        git_cmd.config.base_url..'/'..plugins[i],
        plugin_path(plugins[i])
    }
    handle = vim.loop.spawn(git_cmd.path,
        {
            args = vim.list_extend(vim.deepcopy(git_cmd.args), _args),
            stdio = { nil, stdout, stderr }
        },
        vim.schedule_wrap(function(code, signal)
            if code == 0 then
                local run = packer.plugins[plugins[i]].run
                if run then
                    exec(run, plugin_path(plugins[i]))
                end
            else
                err('[%d/%d] failed to download %s with code %d and signal %d', i, total, plugins[i], code, signal)
                failed_count = failed_count + 1
                -- remove incompleted plugins
                if is_installed(plugins[i]) then
                    exec(packer.config.rm .. ' ' .. plugin_path(plugins[i]), nil, 'cmd')
                end
            end
            stdout:read_stop()
            stderr:read_stop()
            stdout:close()
            stderr:close()
            handle:close()
            if i < total then
                _install(i+1, git_cmd, plugins)
            else
                if failed_count == 0 then
                    info('[%d/%d] downloading completed', i, total)
                else
                    warn('[%d/%d] downloading completed, %d failed', i, total, failed_count)
                    failed_count = 0
                end
            end
        end)
    )
    vim.loop.read_start(stdout, onread)
    vim.loop.read_start(stderr, onread)
end
local function _update(i, git_cmd, plugins)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    i = i or 1
    local total = #plugins
    if not is_installed(plugins[i]) then
        info('[%d/%d] downloading %s...', i, total, plugins[i])
        local _args = {
            'clone', '--depth=1',
            '--recurse-submodules',
            packer.plugins[plugins[i]].branch and ('--branch=' .. packer.plugins[plugins[i]].branch) or nil,
            git_cmd.config.shallow_submodules and '--shallow-submodules' or nil,
            git_cmd.config.base_url..'/'..plugins[i],
            plugin_path(plugins[i])
        }
        handle = vim.loop.spawn(git_cmd.path,
            {
                args = vim.list_extend(vim.deepcopy(git_cmd.args), _args),
                stdio = { nil, stdout, stderr }
            },
            vim.schedule_wrap(function(code, signal)
                if code == 0 then
                    local run = packer.plugins[plugins[i]].run
                    if run then
                        exec(run, plugin_path(plugins[i]))
                    end
                else
                    err('[%d/%d] failed to download %s with code %d and signal %d', i, total, plugins[i], code, signal)
                    failed_count = failed_count + 1
                    -- remove incompleted plugins
                    if is_installed(plugins[i]) then
                        exec(packer.config.rm .. ' ' .. plugin_path(plugins[i]), nil, 'cmd')
                    end
                end
                stdout:read_stop()
                stderr:read_stop()
                stdout:close()
                stderr:close()
                handle:close()
                if i < total then
                    _update(i+1, git_cmd, plugins)
                else
                    if failed_count == 0 then
                        info('[%d/%d] updating completed', i, total)
                    else
                        warn('[%d/%d] updating completed, %d failed', i, total, failed_count)
                        failed_count = 0
                    end
                end
            end)
        )
        vim.loop.read_start(stdout, onread)
        vim.loop.read_start(stderr, onread)
    else
        info('[%d/%d] updating %s...', i, total, plugins[i])
        local update_submodules_failed = false
        local _args = {
            'pull',
            '--ff-only',
            git_cmd.config.base_url..'/'..plugins[i]
        }
        handle = vim.loop.spawn(git_cmd.path,
            {
                cwd = plugin_path(plugins[i]),
                args = vim.list_extend(vim.deepcopy(git_cmd.args), _args),
                stdio = { nil, stdout, stderr }
            },
            vim.schedule_wrap(function(code, signal)
                if code ~= 0 then
                    err('[%d/%d] failed to update %s with code %d and signal %d', i, total, plugins[i], code, signal)
                else
                    local run = packer.plugins[plugins[i]].run
                    if run then
                        exec(run, plugin_path(plugins[i]))
                        info('[%d/%d] run %s', i, total, run)
                    end
                end
                local submod_args = {
                    'submodule', 'update',
                    '--init', '--recursive',
                    git_cmd.config.shallow_submodules and '--depth=1' or nil,
                }
                -- update submodules
                local stdout1 = vim.loop.new_pipe(false)
                local stderr1 = vim.loop.new_pipe(false)
                handle1 = vim.loop.spawn(git_cmd.path,
                    {
                        cwd = plugin_path(plugins[i]),
                        args = vim.list_extend(vim.deepcopy(git_cmd.args), submod_args),
                        stdio = { nil, stdout1, stderr1 }
                    },
                    vim.schedule_wrap(function(_code, _signal)
                        if _code ~= 0 then
                            err('[%d/%d] failed to update submodules of %s with code %d and signal %d', i, total, plugins[i], _code, _signal)
                            update_submodules_failed = true
                        end

                        stdout1:read_stop()
                        stderr1:read_stop()
                        stdout1:close()
                        stderr1:close()
                        handle1:close()

                        stdout:read_stop()
                        stderr:read_stop()
                        stdout:close()
                        stderr:close()
                        handle:close()
                        if update_submodules_failed or code ~= 0 then
                            failed_count = failed_count + 1
                        end
                        if i < total then
                            _update(i+1, git_cmd, plugins)
                        else
                            if failed_count == 0 then
                                info('[%d/%d] updating completed', i, total)
                            else
                                warn('[%d/%d] updating completed, %d failed', i, total, failed_count)
                                failed_count = 0
                            end
                        end
                    end)
                )
                vim.loop.read_start(stdout1, onread)
                vim.loop.read_start(stderr1, onread)
            end)
        )
        vim.loop.read_start(stdout, onread)
        vim.loop.read_start(stderr, onread)
    end
end
-- behaviour(string):
--      - 'install': install plugins
--      - 'update': install plugins and update installed plugins
function packer:download(behaviour, name)
    -- default arguments
    behaviour = behaviour or 'install'
    -- git command
    local git_cmd = {
        path = 'git',
        args = {},
        config = self.config.git
    }
    local packer_git_split = split(self.config.git.cmd, ' ')
    local split_len = #packer_git_split
    if split_len == 1 then
        git_cmd.path = packer_git_split[1]
    elseif split_len > 1 then
        git_cmd.path = packer_git_split[1]
        git_cmd.args = vim.list_slice(packer_git_split, 2, split_len)
    end

    -- plugins to download or update
    local plugins = {}
    -- single plugin
    if name ~= nil and name ~= '' then
        plugins = { fullname(name) }
        goto single_jmp
    end
    -- `name` not specified
    if behaviour == 'update' then
        for plugin_name,settings in pairs(self.plugins) do
            if not settings.disable then
                table.insert(plugins, plugin_name)
            end
        end
    elseif behaviour == 'install' then
        for plugin_name,settings in pairs(self.plugins) do
            if not settings.disable and not is_installed(plugin_name) then
                table.insert(plugins, plugin_name)
            end
        end
        if plugins[1] == nil then
            info('All plugins have been installed')
            return
        end
    end

    ::single_jmp::

    -- install and/or update
    if behaviour == 'install' then
        _install(1, git_cmd, plugins)
    elseif behaviour == 'update' then
        _update(1, git_cmd, plugins)
    end
end

-- name: bare name
-- _plugin_name: fullname to avoid calling fullname()
function packer:add(name, _plugin_name)
    local plugin_name = _plugin_name or fullname(name)
    if plugin_name and not added_plugins[plugin_name] then
        if fn.globpath(vim.o.rtp, 'pack/*/opt/'..name) ~= '' then
            vim.cmd('packadd ' .. name)
            self:loadConfig(plugin_name)
            added_plugins[plugin_name] = true
        else
            warn(plugin_name .. ' not installed or it\'s not an opt plugin')
            return false
        end
    elseif not plugin_name then
        warn('no plugin named %d' .. name)
        return false
    end

    return true
end

local function load_dependencies(name)
    local is_success = true

    if not packer.plugins[name] then
        warn('cant not find %s in configs', name)
        is_success = false
    else
        local deps = packer.plugins[name].dependency
        if type(deps) == 'string' then
            if not packer:add(split(deps, '/')[2], deps) then
                warn('failed to load dependency %s for %s', deps, name)
                is_success = false
            end
        elseif type(deps) == 'table' then
            for _,dep in ipairs(deps) do
                if not packer:add(split(dep, '/')[2], dep) then
                    warn('failed to load dependency %s for %s', dep, name)
                    is_success = false
                end
            end
        end
    end

    return is_success
end

-- load dependencies and configs of all start plugins or one specific plugin
function packer:loadConfig(plugin_name)
    if plugin_name then
        if load_dependencies(plugin_name) or not self.config.strict_deps then
            local config = self.plugins[plugin_name].config
            if self.plugin_configs[plugin_name] then
                self.plugin_configs[plugin_name]()
            end
            if config then
                exec(config)
            end
        end
        return
    end

    -- with no plugin_name provided
    for name,settings in pairs(self.plugins) do
        if settings.disable or not is_installed(name) then -- disabled or not installed
            goto continue
        -- start plugins
        -- dependencies must be opt plugins
        elseif not is_opt(settings) then
            if load_dependencies(name) or not self.config.strict_deps then
                if settings.config then
                    exec(settings.config)
                end
                if self.plugin_configs[name] then
                    self.plugin_configs[name]()
                end
            end
        end
        ::continue::
    end
end

function packer:uninstall(name)
    -- installed plugins
    local installed_plugins = {}
    local opt_plugins = fn.glob(base_path .. '/opt/*')
    local start_plugins = fn.glob(base_path .. '/start/*')
    if opt_plugins ~= '' then
        installed_plugins = split(opt_plugins, '\n')
    end
    if start_plugins ~= '' then
        vim.list_extend(installed_plugins, split(start_plugins, '\n'))
    end

    -- format self.plugins
    local plugins = {}
    for plugin_name,settings in pairs(self.plugins) do
        if not settings.disable then
            plugins[split(plugin_name, '/')[2]] = {
                -- author = split(plugin_name, '/')[1],
                cate = is_opt(settings) and 'opt' or 'start'
            }
        end
    end

    -- remove undesired plugins from installed plugins
    local cate,plugin_name
    for _,path in ipairs(installed_plugins) do
        cate,plugin_name = path:match('([^/]*)/([^/]*)$')
        if name ~= nil and name ~= '' then  -- `name` is specified
            if plugin_name == name then
                if exec('!' .. self.config.rm .. ' ' .. path, nil, 'cmd') then
                    info('%s deleted', path)
                else
                    err('failed to delete %s', plugin_name)
                end
            end
        elseif (not plugins[plugin_name]) or plugins[plugin_name].cate ~= cate then
            if exec('!' .. self.config.rm .. ' ' .. path, nil, 'cmd') then
                info('%s deleted', path)
            else
                err('failed to delete %s', plugin_name)
            end
        end
    end
end

function packer.load_map(mode, lhs, name)
    api.nvim_del_keymap(mode, lhs)
    packer:add(split(name, '/')[2], name)
    local expr = '"' .. lhs:gsub('"', '\\"') .. '"'
    local keys = api.nvim_eval(api.nvim_replace_termcodes(expr, true, false, true))
    fn.feedkeys(keys) -- notice: this would be interrupted by outputs
end

function packer:prepareOptPlugins()
    for name,settings in pairs(self.plugins) do
        if settings.disable or not is_opt(settings) then goto continue end

        -- 'enable' opt plugins
        if settings.enable then
            local if_on
            if type(settings.enable) == 'boolean' then
                if_on = settings.enable
            elseif type(settings.enable == 'function') then
                if_on = settings.enable(aloha)
            end
            if if_on then
                self:add(split(name, '/')[2], name)
                goto continue -- don't process cmd, ft...
            end
        end

        -- cmd opt plugins
        if settings.cmd then
            local on_cmds = {}
            if type(settings.cmd) == 'table' then
                on_cmds = settings.cmd
            elseif type(settings.cmd) == 'string' then
                on_cmds = {settings.cmd}
            end
            for _,cmd in ipairs(on_cmds) do
                api.nvim_create_user_command(cmd,
                    function (args)
                        self:add(split(name, '/')[2], name)
                        vim.cmd(string.format('%s%s%s %s',
                            (args.line1 ~= args.line2) and (args.line1..','..args.line2) or '',
                            cmd,
                            args.bang and '!' or '',
                            join(args.fargs, ' ')
                        ))
                    end,
                    {
                        force = true,
                        complete = 'file',
                        nargs = '*',
                        bang = true,
                        range = true
                    }
                )
            end
        end

        -- ft opt plugins
        local filetypes = settings.ft
        if type(settings.ft) == 'string' then
            filetypes = split(settings.ft, ',')
        end
        if filetypes then
            api.nvim_create_autocmd('FileType', {
                pattern = filetypes,
                once = true,
                nested = true,
                callback = function ()
                    self:add(split(name, '/')[2], name)
                end
            })
        end

        -- map opt plugins
        if settings.map then
            for _,mapping in ipairs(settings.map) do
                api.nvim_set_keymap(mapping.mode, mapping.lhs,
                    string.format([[<Cmd>lua aloha.packer.load_map('%s', '%s', '%s')<CR>]],
                        mapping.mode, mapping.lhs:gsub('<', '<lt>'), name),
                    {noremap = true, silent = true}
                )
            end
        end

        -- event opt plugins
        if settings.event then
            api.nvim_create_autocmd(settings.event, {
                pattern = '*',
                callback = function ()
                    self:add(split(name, '/')[2], name)
                end
            })
        end

        ::continue::
    end
end

return packer
