local packer = {}

local function cmd_silent(command)
    return command .. ' >/dev/null 2>&1'
end

function packer:init(plugins, plugin_config, packer_config)
    --{{1 initialization
    -- default arguments
    self.plugins = plugins or {}
    self.plugin_config = plugin_config or {}
    self.packer_config = vim.tbl_extend('keep', packer_config, {
        pack_root = vim.fn.stdpath('data') .. '/site/pack',
        pack_name = 'packer',
        -- retry = 3,
        -- max_jobs = 3,
        git = 'git',
        rm = 'rm -rf',
    })
    local plugins = self.plugins
    local plugin_config = self.plugin_config
    local packer_config = self.packer_config
    --}}1 initialization

    self:loadConfig() -- must be called before self:prepareOptPlugins()
    self:prepareOptPlugins()

    return self
end

function packer:download(behaviour)
    local base_path = self.packer_config.pack_root .. '/' .. self.packer_config.pack_name
    for name,settings in pairs(self.plugins) do
        if not settings.disable then
            local plugin_dir = ''
            if settings.ft or settings.opt then
                plugin_dir = base_path .. '/opt/' .. string.match(name, '[^/]*$')
            else
                plugin_dir = base_path .. '/start/' .. string.match(name, '[^/]*$')
            end

            -- downad and/or update
            if vim.fn.glob(plugin_dir) ~= '' then
                if behaviour == 'update' then
                    local result = os.execute(cmd_silent(self.packer_config.git .. ' --git-dir=' .. plugin_dir .. '/.git --work-tree=' .. plugin_dir .. ' pull'))
                    if result then
                        print(name .. ' updated')
                    else
                        print('failed to update ' .. name)
                    end
                end
                goto continue
            else
                local result = os.execute(cmd_silent(self.packer_config.git .. ' clone https://github.com/' .. name .. ' ' .. plugin_dir))
                if result then
                    print(name .. ' installed')
                    if settings.run then
                        self:exec(run)
                    end
                else
                    print('failed to install ' .. name)
                end
            end
        end
        ::continue::
    end
end

function packer:exec(exec, ret)
    if not ret then
        if type(exec) == 'function' then
            exec()
        elseif type(exec) == 'string' then
            local first = string.sub(exec, 1, 1)
            if first == ':' then
                vim.cmd(string.sub(exec, 2))
            elseif first == '!' then
                os.execute(cmd_silent(string.sub(exec, 2)))
            else
                load(exec)()
            end
        end
    elseif ret == 'function' then
        if type(exec) == 'function' then
            return function() exec() end
        elseif type(exec) == 'string' then
            local first = string.sub(exec, 1, 1)
            if first == ':' then
                return function() vim.cmd(string.sub(exec, 2)) end
            elseif first == '!' then
                return function() os.execute(cmd_silent(string.sub(exec, 2))) end
            else
                return function() load(exec)() end
            end
        end
    end
end

function packer:loadConfig()
    local base_path = self.packer_config.pack_root .. '/' .. self.packer_config.pack_name
    for name,settings in pairs(self.plugins) do
        -- to load configuration here, a plugin must be enabled and installed

        if settings.disable then
            goto continue
        -- opt packs
        elseif vim.fn.glob(base_path .. '/opt/' .. string.match(name, '[^/]*$')) ~= '' then
            local cmd = ''
            if settings.config then
            -- config in settings
                self.opt_configs = {}
                if type(settings.config) == 'function' then
                    cmd = 'lua aloha.packer.plugin_config[\'' .. name .. '\']()'
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
            elseif self.plugin_config[name] and type(self.plugin_config[name]) == 'function' then
            -- config in plugin_config
                if cmd ~= '' then
                    cmd = cmd .. ' | ' .. 'lua aloha.packer.plugin_config[\'' .. name .. '\']()'
                else
                    cmd = 'lua aloha.packer.plugin_config[\'' .. name .. '\']()'
                end
            end
            local pack_path = base_path .. '/opt/' .. string.match(name, '[^/]*$')
            if cmd ~= '' then
                -- TODO auto load config before loading through :packadd
                -- vim.cmd('au SourcePre ' .. pack_path .. '/**/* ' .. cmd)
                -- SourcePre events are only triggered by :source commamd
                vim.cmd('au VimEnter * ' .. cmd)
            end
        -- start packs
        elseif vim.fn.glob(base_path .. '/start/' .. string.match(name, '[^/]*$')) ~= '' then
            if self.plugin_config[name] then
                self:exec(self.plugin_config[name])
            end
            if type(settings.config) == 'function' then
                settings.config()
            end
            if type(settings.config) == 'string' then
                local first = string.sub(settings.config, 1, 1)
                if first == ':' then
                    vim.cmd(string.sub(settings.config, 2))
                elseif first == '!' then
                    os.execute(cmd_silent(string.sub(settings.config, 2)))
                else
                    load(settings.config)()
                end
            end
        end

        ::continue::
    end
end

function packer:clean()
    local base_path = self.packer_config.pack_root .. '/' .. self.packer_config.pack_name

    -- installed plugins
    installed_plugins = vim.list_extend(vim.fn.split(vim.fn.glob(base_path .. '/start/*'), '\n'),
        vim.fn.split(vim.fn.glob(base_path .. '/opt/*'), '\n'))

    -- format self.plugins
    local plugins = {}
    for name,settings in pairs(self.plugins) do
        if not settings.disable then
            if plugins[string.match(name, '[^/]*$')] then
                print('duplicate plugin ' .. plugin)
            end
            plugins[string.match(name, '[^/]*$')] = {
                author = string.match(name, '^[^/]*'),
                opt = (settings.opt or settings.ft) and 'opt' or 'start'
            }
        end
    end

    -- remove undesired plugins
    for _,plugin in ipairs(installed_plugins) do
        opt,name = string.match(plugin, '([^/]*)/([^/]*)$')
        if (not plugins[name]) or plugins[name].opt ~= opt then
            if not os.execute(cmd_silent(self.packer_config.rm .. ' ' .. plugin)) then
                print('failed to install ' .. name)
            else
                print(plugin .. ' deleted')
            end
        end
    end
end

function packer:prepareOptPlugins()
    for name,settings in pairs(self.plugins) do
        local filetypes
        if type(settings.ft) == 'table' and #settings.ft > 0 then
            filetypes = '*.' .. settings.ft[1]
            for i = 2,#settings.ft do -- skip if #settings = 1
                -- filetypes
                filetypes = filetypes .. ',*.' .. settings.ft[i]
            end
        elseif type(settings.ft) == 'string' then
            filetypes = string.gsub(settings.ft, '%w+', '*.%0')
        end

        if filetypes then
            vim.cmd('au BufReadPre ' .. filetypes .. ' packadd ' .. string.match(name, '([^/]*)$'))
        end
    end
end

return packer
