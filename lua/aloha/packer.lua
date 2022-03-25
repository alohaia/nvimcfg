local packer = {}

local join = table.concat

local base_path = '' -- initialized in packer:init()

local function exec(cmd, cwd, cmd_type)
    local rt = true -- return value

    -- if 'cmd_type' is provided, use it to determine type of 'cmd'
    if cmd_type then goto direct else goto check end

    ::direct::
    if cmd_type == 'function' then
        cmd()
    elseif cmd_type == 'vim' then
        vim.cmd(cmd)
    elseif cmd_type == 'cmd' then
        local cmd_splits = vim.split(cmd, ' ')
        local handle = 0
        handle = vim.loop.spawn(cmd_splits[1], {
                cwd = cwd,
                args = vim.list_slice(cmd_splits, 2, #cmd_splits),
            },
            vim.schedule_wrap(function(code, signal)
                if code ~= 0 then
                    print(cmd .. ' failed with code', code, ', signal', signal)
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
            local cmd_splits = vim.split(cmd:sub(2), ' ')
            local handle = 0
            handle = vim.loop.spawn(cmd_splits[1], {
                    cwd = cwd,
                    args = vim.list_slice(cmd_splits, 2, #cmd_splits),
                },
                vim.schedule_wrap(function(code, signal)
                    if code ~= 0 then
                        print(cmd .. ' failed with code', code, ', signal', signal)
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
    -- goto finish

    ::finish::
    -- for function and vim.cmd, rt is always true
    return rt
end

local function is_opt(settings)
    if settings.opt or settings.ft then
        return true
    else
        return false
    end
end

local function is_installed(name)
    if vim.fn.glob(base_path .. (is_opt(packer.plugins[name]) and '/opt/' or '/start/')
        .. vim.split(name, '/')[2]) ~= '' then
        return true
    else
        return false
    end
end

local function plugin_path(name)
    if is_opt(packer.plugins[name]) then
        return base_path .. '/opt/' .. vim.split(name, '/')[2]
    else
        return base_path .. '/start/' .. vim.split(name, '/')[2]
    end
end

function packer:init(settings)
    --{{1 initialization
    -- default arguments
    self.plugins = (type(settings.plugins) == 'table') and settings.plugins or {}
    self.plugin_configs = type(settings.plugin_configs) == 'table' and settings.plugin_configs or {}
    self.packer_config = vim.tbl_extend('keep', settings.packer_config, {
        pack_root = vim.fn.stdpath('data') .. '/site/pack',
        pack_name = 'packer',
        git = 'git',
        rm = 'rm -rf',
    })

    -- others vars
    base_path = self.packer_config.pack_root .. '/' .. self.packer_config.pack_name
    --}}1 initialization

    self:loadConfig() -- must be called before self:prepareOptPlugins()
    self:prepareOptPlugins()

    return self
end

local handle, handle1
local failed_count = 0
local function _download(i, total, git_cmd, plugins)
    i = i or 1
    print('['..i..'/'..total..'] downloading', plugins[i], '...')
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
                _download(i+1, total, git_cmd, plugins)
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
local function _update(i, total, git_cmd, plugins)
    i = i or 1
    if not is_installed(plugins[i]) then
        print('['..i..'/'..total..'] downloading', plugins[i], '...')
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
                    _update(i+1, total, git_cmd, plugins)
                else
                    if failed_count == 0 then
                        print('['..i..'/'..total..'] updating completed')
                    else
                        print('['..i..'/'..total..'] updating completed,', failed_count, 'failed')
                        failed_count = 0
                    end
                end
            end)
        )
    else
        print('['..i..'/'..total..'] updating', plugins[i], '...')
        local update_submodules_failed = false
        handle = vim.loop.spawn(git_cmd.path, {
                cwd = plugin_path(plugins[i]),
                args = vim.list_extend(vim.deepcopy(git_cmd.args), {'pull', 'https://github.com/'..plugins[i]}),
            },
            vim.schedule_wrap(function(code, signal)
                if code ~= 0 then
                    print('['..i..'/'..total..'] failed to update', plugins[i], 'with code', code, 'and signal', signal)
                end
                -- update submodules
                handle1 = vim.loop.spawn(git_cmd.path, {
                        cwd = plugin_path(plugins[i]),
                        args = vim.list_extend(vim.deepcopy(git_cmd.args), {'submodule', 'update', '--init', '--recursive'}),
                    },
                    vim.schedule_wrap(function(_code, _signal)
                        if _code ~= 0 then
                            print('['..i..'/'..total..'] failed to update submodules of', plugins[i], 'with code', _code, 'and signal', _signal)
                            update_submodules_failed = true
                        end
                        handle1:close()

                        handle:close()
                        if update_submodules_failed or code ~= 0 then
                            failed_count = failed_count + 1
                        end
                        if i < total then
                            _update(i+1, total, git_cmd, plugins)
                        else
                            if failed_count == 0 then
                                print('['..i..'/'..total..'] updating completed')
                            else
                                print('['..i..'/'..total..'] updating completed,', failed_count, 'failed')
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
--      - 'update': install and update installed plugins
function packer:download(behaviour)
    -- default arguments
    behaviour = behaviour or 'install'

    -- git command
    local git_cmd = {
        path = 'git',
        args = {}
    }
    local packer_git_split = vim.split(self.packer_config.git, ' ')
    local split_len = #packer_git_split
    if split_len == 1 then
        git_cmd.path = packer_git_split[1]
    elseif split_len > 1 then
        git_cmd.path = packer_git_split[1]
        git_cmd.args = vim.list_slice(packer_git_split, 2, split_len)
    end

    -- plugins to download or update
    local plugins = {}
    if behaviour == 'update' then
        for name,settings in pairs(self.plugins) do
            if not settings.disable then
                table.insert(plugins, name)
            end
        end
    elseif behaviour == 'install' then
        for name,settings in pairs(self.plugins) do
            if not settings.disable and not is_installed(name) then
                table.insert(plugins, name)
            end
        end
        if plugins[1] == nil then
            print('All plugins have been installed')
            return
        end
    end

    -- install and/or update
    local total = #plugins
    if behaviour == 'install' then
        _download(1, total, git_cmd, plugins)
    elseif behaviour == 'update' then
        _update(1, total, git_cmd, plugins)
    end
end

function packer:loadConfig()
    for name,settings in pairs(self.plugins) do
        -- to load configuration here, a plugin must be enabled and installed

        -- disabled or not installed
        if settings.disable or not is_installed(name) then
            goto continue
        -- opt plugins
        elseif is_opt(settings) then
            local cmd = ''
            -- `config` option in settings
            if settings.config then
                self.opt_configs = {}
                if type(settings.config) == 'function' then
                    cmd = 'lua aloha.packer.plugin_configs[\'' .. name .. '\']()'
                elseif type(settings.config) == 'string' then
                    if settings.config[1] == ':' then
                        cmd = settings.config:sub(2)
                    elseif settings.config[1] == '!' then
                        cmd = settings.config
                    else
                        cmd = 'lua ' .. settings.config
                    end
                end
            end
            -- `config` in plugin_configs
            if self.plugin_configs[name] and type(self.plugin_configs[name]) == 'function' then
                if cmd ~= '' then
                    cmd = cmd .. ' | ' .. 'lua aloha.packer.plugin_configs[\'' .. name .. '\']()'
                else
                    cmd = 'lua aloha.packer.plugin_configs[\'' .. name .. '\']()'
                end
            end
            -- run cmd above
            if cmd ~= '' then
                vim.cmd(join({'au SourcePre', plugin_path(name)..'/*', '++once', cmd}, ' '))
            end

            -- `on` option in settings
            if settings.on then
                local on_cmds = {}
                if type(settings.on) == "table" then
                    on_cmds = settings.on
                elseif type(settings.on) == "string" then
                    on_cmds = {settings.on}
                end
                for _,cmd in ipairs(on_cmds) do
                    vim.cmd(join({'command', cmd, 'packadd', vim.split(name, '/')[2], '|', cmd}, ' '))
                    vim.cmd(join({'au SourcePre', plugin_path(name)..'/*', '++once', 'delcommand', cmd}, ' '))
                end
            end
        -- start plugins
        else
            if self.plugin_configs[name] then
                exec(self.plugin_configs[name])
            end
            if type(settings.config) then
                exec(settings.config)
            end
        end

        ::continue::
    end
end

function packer:clean()
    -- installed plugins
    local installed_plugins = {}
    local opt_plugins = vim.fn.glob(base_path .. '/opt/*')
    local start_plugins = vim.fn.glob(base_path .. '/start/*')
    if opt_plugins ~= '' then
        installed_plugins = vim.split(opt_plugins, '\n')
    end
    if start_plugins ~= '' then
        vim.list_extend(installed_plugins, vim.split(start_plugins, '\n'))
    end

    -- format self.plugins
    local plugins = {}
    for name,settings in pairs(self.plugins) do
        if not settings.disable then
            plugins[vim.split(name, '/')[2]] = {
                author = vim.split(name, '/')[2],
                cate = is_opt(settings) and 'opt' or 'start'
            }
        end
    end

    -- remove undesired plugins from installed plugins
    local cate,name
    for _,plugin in ipairs(installed_plugins) do
        cate,name = plugin:match('([^/]*)/([^/]*)$')
        if (not plugins[name]) or plugins[name].cate ~= cate then
            -- if not os.execute(cmd_silent(self.packer_config.rm .. ' ' .. plugin)) then
            if exec('!' .. self.packer_config.rm .. ' ' .. plugin) then
                print(plugin .. ' deleted')
            else
                print('failed to delete ' .. name)
            end
        end
    end
end

function packer:prepareOptPlugins()
    for name,settings in pairs(self.plugins) do
        if settings.disable then goto continue end

        local filetypes
        if type(settings.ft) == 'table' and #settings.ft > 0 then
            filetypes = settings.ft[1]
            for i = 2,#settings.ft do -- skip if #settings == 1
                -- filetypes
                filetypes = filetypes .. ',' .. settings.ft[i]
            end
        elseif type(settings.ft) == 'string' then
            filetypes = settings.ft
        end

        if filetypes then
            vim.cmd('au FileType ' .. filetypes .. ' ++once ++nested packadd ' .. vim.split(name, '/')[2])
        end

        ::continue::
    end
end

return packer
