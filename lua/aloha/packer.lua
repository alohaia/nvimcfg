local packer = {}

local api = vim.api
local fn = vim.fn
local join = table.concat
local split = vim.split
local printf = function (s, ...)
    print(string.format(s, ...))
end

local base_path = '' -- initialized in packer:init()
local added_plugins = {} -- opt plugins that have been added and whose configs have been loaded

local function exec(cmd, cwd, cmd_type)
    local rt = true -- return value

    local save_cwd
    if cwd then
        save_cwd = fn.getcwd()
        fn.chdir(cwd)
    end

    -- if 'cmd_type' is provided, use it to determine type of 'cmd'
    if cmd_type then goto direct else goto check end

    ::direct::
    if cmd_type == 'function' then
        cmd()
    elseif cmd_type == 'vim' then
        vim.cmd(cmd)
    elseif cmd_type == 'cmd' then
        local cmd_splits = split(cmd, ' ')
        local handle = 0
        handle = vim.loop.spawn(cmd_splits[1], {
                cwd = cwd,
                args = vim.list_slice(cmd_splits, 2, #cmd_splits),
            },
            vim.schedule_wrap(function(code, signal)
                if code ~= 0 then
                    printf('"%s" failed with code %d, signal %d', cmd, code, signal)
                    rt = nil
                end
                handle:close()
            end)
        )
    elseif cmd_type == 'lua' then
        local func,err = load(cmd)
        if func then
            func()
        else
            rt = nil
            vim.notify(cmd .. ' failed: ' .. err, 'error')
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
            local cmd_splits = split(cmd:sub(2), ' ')
            local handle = 0
            handle = vim.loop.spawn(cmd_splits[1], {
                    cwd = cwd,
                    args = vim.list_slice(cmd_splits, 2, #cmd_splits),
                },
                vim.schedule_wrap(function(code, signal)
                    if code ~= 0 then
                        printf('"%s" failed with code %d, signal %d', cmd, code, signal)
                        rt = nil
                    end
                    handle:close()
                end)
            )
        else
            local func,err = load(cmd)
            if func then
                func()
            else
                rt = nil
                vim.notify(err, 'error')
            end
        end
    end

    ::finish::

    if cwd then
        fn.chdir(save_cwd)
    end
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

function packer:init(settings)
    --{{1 initialization
    -- default arguments
    self.plugins = (type(settings.plugins) == 'table') and settings.plugins or {}
    self.plugin_configs = type(settings.plugin_configs) == 'table' and settings.plugin_configs or {}
    self.packer_config = vim.tbl_extend('keep', settings.packer_config, {
        pack_root = fn.stdpath('data') .. '/site/pack',
        pack_name = 'packer',
        git = 'git',
        rm = 'rm -rf',
    })

    -- others vars
    base_path = self.packer_config.pack_root .. '/' .. self.packer_config.pack_name
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
    return join(packer.plugin_list, "\n")
end

local handle, handle1
local failed_count = 0
local function _install(i, git_cmd, plugins)
    i = i or 1
    local total = #plugins
    printf('[%d/%d] downloading %s ...', i, total, plugins[i])
    local branch = packer.plugins[plugins[i]].branch
    local _args = {}
    if branch then
        _args = {'clone', '--recurse-submodules', '-b', branch, 'https://github.com/'..plugins[i], plugin_path(plugins[i])}
    else
        _args = {'clone', '--recurse-submodules', 'https://github.com/'..plugins[i], plugin_path(plugins[i])}
    end
    handle = vim.loop.spawn(git_cmd.path, {
            args = vim.list_extend(vim.deepcopy(git_cmd.args), _args),
        },
        vim.schedule_wrap(function(code, signal)
            if code == 0 then
                local run = packer.plugins[plugins[i]].run
                if run then
                    exec(run, plugin_path(plugins[i]))
                end
            else
                print('['..i..'/'..total..'] failed to download', plugins[i], 'with code', code, 'and signal', signal)
                failed_count = failed_count + 1
                -- remove incompleted plugins
                if is_installed(plugins[i]) then
                    exec(packer.packer_config.rm .. ' ', plugin_path(plugins[i]))
                end
            end
            handle:close()
            if i < total then
                _install(i+1, git_cmd, plugins)
            else
                if failed_count == 0 then
                    print('['..i..'/'..total..'] downloading completed')
                else
                    print('['..i..'/'..total..'] downloading completed,', failed_count, 'failed')
                    failed_count = 0
                end
            end
        end)
    )
end
local function _update(i, git_cmd, plugins)
    i = i or 1
    local total = #plugins
    if not is_installed(plugins[i]) then
        printf('[%d/%d] downloading %s ...', i, total, plugins[i])
        local branch = packer.plugins[plugins[i]].branch
        local _args = {}
        if branch then
            _args = {'clone', '--recurse-submodules', '-b', branch, 'https://github.com/'..plugins[i], plugin_path(plugins[i])}
        else
            _args = {'clone', '--recurse-submodules', 'https://github.com/'..plugins[i], plugin_path(plugins[i])}
        end
        handle = vim.loop.spawn(git_cmd.path, {
                args = vim.list_extend(vim.deepcopy(git_cmd.args), _args),
            },
            vim.schedule_wrap(function(code, signal)
                if code == 0 then
                    local run = packer.plugins[plugins[i]].run
                    if run then
                        exec(run, plugin_path(plugins[i]))
                    end
                else
                    printf('[%d/%d] failed to download %s with code %d and signal %d', i, total, plugins[i], code, signal)
                    failed_count = failed_count + 1
                    -- remove incompleted plugins
                    if is_installed(plugins[i]) then
                        exec(packer.packer_config.rm .. ' ', plugin_path(plugins[i]))
                    end
                end
                handle:close()
                if i < total then
                    _update(i+1, git_cmd, plugins)
                else
                    if failed_count == 0 then
                        printf('[%d/%d] updating completed', i, total)
                    else
                        printf('[%d/%d] updating completed, %d failed', i, total, failed_count)
                        failed_count = 0
                    end
                end
            end)
        )
    else
        printf('[%d/%d] updating %s ...', i, total, plugins[i])
        local update_submodules_failed = false
        handle = vim.loop.spawn(git_cmd.path, {
                cwd = plugin_path(plugins[i]),
                args = vim.list_extend(vim.deepcopy(git_cmd.args), {'pull', 'https://github.com/'..plugins[i]}),
            },
            vim.schedule_wrap(function(code, signal)
                if code ~= 0 then
                    printf('[%d/%d] failed to update %s with code %d and signal %d', i, total, plugins[i], code, signal)
                end
                -- update submodules
                handle1 = vim.loop.spawn(git_cmd.path, {
                        cwd = plugin_path(plugins[i]),
                        args = vim.list_extend(vim.deepcopy(git_cmd.args), {'submodule', 'update', '--init', '--recursive'}),
                    },
                    vim.schedule_wrap(function(_code, _signal)
                        if _code ~= 0 then
                            printf('[%d/%d] failed to update submodules of %s with code %d and signal %d', i, total, plugins[i], _code, _signal)
                            update_submodules_failed = true
                        end
                        handle1:close()

                        handle:close()
                        if update_submodules_failed or code ~= 0 then
                            failed_count = failed_count + 1
                        end
                        if i < total then
                            _update(i+1, git_cmd, plugins)
                        else
                            if failed_count == 0 then
                                printf('[%d/%d] updating completed', i, total)
                            else
                                printf('[%d/%d] updating completed, %d failed', i, total, failed_count)
                                failed_count = 0
                            end
                        end
                    end)
                )
            end)
        )
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
        args = {}
    }
    local packer_git_split = split(self.packer_config.git, ' ')
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
    if name ~= nil and name ~= "" then
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
            print('All plugins have been installed')
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
        local path = fn.globpath(vim.o.rtp, 'pack/*/opt/'..name)
        if path ~= '' then
            vim.cmd('packadd ' .. name)
            self:loadConfig(plugin_name)
            added_plugins[plugin_name] = true
        else
            print(plugin_name .. " is required")
        end
    elseif not plugin_name then
        print("can not find " .. name)
    end
end

local function load_dependencies(name)
    local deps = packer.plugins[name].dependency
    if type(deps) == 'string' then
        packer:add(split(deps, '/')[2], deps)
    elseif type(deps) == 'table' then
        for _,dep in ipairs(deps) do
            packer:add(split(dep, '/')[2], dep)
        end
    end
end

-- load dependencies and configs of all start plugins or one specific plugin
function packer:loadConfig(plugin_name)
    if plugin_name and not self.plugins[plugin_name].disable then
        load_dependencies(plugin_name)
        local config = self.plugins[plugin_name].config
        if self.plugin_configs[plugin_name] then
            self.plugin_configs[plugin_name]()
        end
        if config then
            exec(config)
        end
        return
    end

    for name,settings in pairs(self.plugins) do
        if settings.disable or not is_installed(name) then -- disabled or not installed
            goto continue
        elseif not is_opt(settings) then -- start plugins
            load_dependencies(name)
            if type(settings.config) then
                exec(settings.config)
            end
            if self.plugin_configs[name] then
                self.plugin_configs[name]()
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
        if name ~= nil and name ~= "" then  -- `name` is specified
            if plugin_name == name then
                if exec('!' .. self.packer_config.rm .. ' ' .. path) then
                    print(path .. ' deleted')
                else
                    print('failed to delete ' .. plugin_name)
                end
            end
        elseif (not plugins[plugin_name]) or plugins[plugin_name].cate ~= cate then
            if exec('!' .. self.packer_config.rm .. ' ' .. path) then
                print(path .. ' deleted')
            else
                print('failed to delete ' .. plugin_name)
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
            if type(settings.enable) == "boolean" then
                if_on = settings.enable
            elseif type(settings.enable == "function") then
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
            if type(settings.cmd) == "table" then
                on_cmds = settings.cmd
            elseif type(settings.cmd) == "string" then
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

        ::continue::
    end
end

return packer
