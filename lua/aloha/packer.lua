local packer = {}

local base_path = '' -- initialized in packer:init()

local function exec(cmd, cwd)
    local rt = true -- return value
    if type(cmd) == 'function' then
        cmd()
    elseif type(cmd) == 'string' then
        local first = string.sub(cmd, 1, 1)
        if first == ':' then
            vim.cmd(string.sub(cmd, 2))
        elseif first == '!' then
            local cmd_splits = vim.split(string.sub(cmd, 2), ' ')
            local handle = 0
            handle = vim.loop.spawn(cmd_splits[1], {
                    cwd = cwd,
                    args = vim.list_slice(cmd_splits, 2, #cmd_splits),
                },
                vim.schedule_wrap(function(code, signal)
                    if code ~= 0 then
                        print(cmd .. ' failed with code ' .. code)
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

function packer:init(plugins, plugin_configs, packer_config)
    --{{1 initialization
    -- default arguments
    self.plugins = plugins or {}
    self.plugin_configs = plugin_configs or {}
    self.packer_config = vim.tbl_extend('keep', packer_config, {
        pack_root = vim.fn.stdpath('data') .. '/site/pack',
        pack_name = 'packer',
        git = 'git',
        rm = 'rm -rf',
    })

    -- initialize members
    local plugins = self.plugins
    local plugin_configs = self.plugin_configs
    local packer_config = self.packer_config

    -- others vars
    base_path = self.packer_config.pack_root .. '/' .. self.packer_config.pack_name
    --}}1 initialization

    self:loadConfig() -- must be called before self:prepareOptPlugins()
    self:prepareOptPlugins()

    return self
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
    end

    -- install and/or update
    local handle = 0
    local total = #plugins
    if behaviour == 'install' then
        local function _download(i)
            i = i or 1
            print('['..i..'/'..total..'] downloading', plugins[i], '...')
            handle = vim.loop.spawn(git_cmd.path, {
                    args = vim.list_extend(vim.deepcopy(git_cmd.args),
                        {'clone', 'https://github.com/'..plugins[i], plugin_path(plugins[i])}),
                },
                vim.schedule_wrap(function(code, signal)
                    if code == 0 then
                        local run = self.plugins[plugins[i]].run
                        if run then
                            exec(run, plugin_path(plugins[i]))
                        end
                    else
                        print('['..i..'/'..total..'] failed to download', plugins[i])
                    end
                    handle:close()
                    if i < total then
                        _download(i+1)
                    else
                        print('['..i..'/'..total..'] downloading completed')
                    end
                end)
            )
        end
        _download()
    elseif behaviour == 'update' then
        local function _update(i)
            i = i or 1
            if not is_installed(plugins[i]) then
                print('['..i..'/'..total..'] downloading', plugins[i], '...')
                handle = vim.loop.spawn(git_cmd.path, {
                        args = vim.list_extend(vim.deepcopy(git_cmd.args),
                            {'clone', 'https://github.com/'..plugins[i], plugin_path(plugins[i])}),
                    },
                    vim.schedule_wrap(function(code, signal)
                        if code == 0 then
                            local run = self.plugins[plugins[i]].run
                            if run then
                                exec(run, plugin_path(plugins[i]))
                            end
                        else
                            print('['..i..'/'..total..'] failed to download', plugins[i])
                        end
                        handle:close()
                        if i < total then
                            _update(i+1)
                        else
                            print('['..i..'/'..total..'] updating completed')
                        end
                    end)
                )
            else
                print('['..i..'/'..total..'] updating', plugins[i], '...')
                handle = vim.loop.spawn(git_cmd.path, {
                        cwd = plugin_path(plugins[i]),
                        args = vim.list_extend(vim.deepcopy(git_cmd.args), {'pull', 'https://github.com/'..plugins[i]}),
                    },
                    vim.schedule_wrap(function(code, signal)
                        if code ~= 0 then
                            print('['..i..'/'..total..'] failed to update', plugins[i])
                        end
                        handle:close()
                        if i < total then
                            _update(i+1)
                        else
                            print('['..i..'/'..total..'] updating completed')
                        end
                    end)
                )
            end
        end
        _update()
    end
end

function packer:loadConfig()
    for name,settings in pairs(self.plugins) do
        -- to load configuration here, a plugin must be enabled and installed

        if settings.disable then
            goto continue
        -- opt plugins
        elseif vim.fn.glob(base_path .. '/opt/' .. vim.split(name, '/')[2]) ~= '' then
            local cmd = ''
            if settings.config then
            -- config in settings
                self.opt_configs = {}
                if type(settings.config) == 'function' then
                    cmd = 'lua aloha.packer.plugin_configs[\'' .. name .. '\']()'
                end
                if type(settings.config) == 'string' then
                    if settings.config[1] == ':' then
                        cmd = string.sub(settings.config, 2)
                    elseif settings.config[1] == '!' then
                        cmd = settings.config
                    else
                        cmd = 'lua ' .. settings.config
                    end
                end
            elseif self.plugin_configs[name] and type(self.plugin_configs[name]) == 'function' then
            -- config in plugin_configs
                if cmd ~= '' then
                    cmd = cmd .. ' | ' .. 'lua aloha.packer.plugin_configs[\'' .. name .. '\']()'
                else
                    cmd = 'lua aloha.packer.plugin_configs[\'' .. name .. '\']()'
                end
            end
            local pack_path = base_path .. '/opt/' .. vim.split(name, '/')[2]
            if cmd ~= '' then
                vim.cmd('au SourcePre ' .. pack_path .. '/**/* ' .. cmd)
            end
        -- start plugins
        elseif vim.fn.glob(base_path .. '/start/' .. vim.split(name, '/')[2]) ~= '' then
            if self.plugin_configs[name] then
                exec(self.plugin_configs[name])
            end
            if type(settings.config) == 'function' then
                settings.config()
            end
            if type(settings.config) == 'string' then
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
    for _,plugin in ipairs(installed_plugins) do
        cate,name = string.match(plugin, '([^/]*)/([^/]*)$')
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
        local filetypes
        if type(settings.ft) == 'table' and #settings.ft > 0 then
            filetypes = settings.ft[1]
            for i = 2,#settings.ft do -- skip if #settings = 1
                -- filetypes
                filetypes = filetypes .. ',' .. settings.ft[i]
            end
        elseif type(settings.ft) == 'string' then
            filetypes = settings.ft
        end

        if filetypes then
            vim.cmd('au FileType ' .. filetypes .. ' nested packadd ' .. vim.split(name, '/')[2])
        end
    end
end

return packer
