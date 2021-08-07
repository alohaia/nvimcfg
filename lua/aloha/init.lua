return function(options)
    local options = vim.tbl_extend('keep', options, {
        -- disable unnecessary operations
        minimal = true,
        -- minimal is overrided by the options below
        create_dirs = true,
        install_plugins = false,
        sync_plugins = false,
    })

    local settings = {}
    if vim.fn.glob('./settings/init.lua') or vim.fn.glob('./settings.lua') then
        settings = require('aloha.settings')
    end

    _G.aloha = {
        au = {
            add = function(event, file, command)
                vim.cmd('autocmd'..event..' '..file..' '..command)
            end
        },
        map = {
            list = settings.mappings or {},
            leader = ' ',
            default_args = setmetatable({
                silent = true,
                noremap = true
            }, {
                __add = function(tbl_o, tbl_n)
                    local new_table = vim.deepcopy(tbl_o)
                    if tbl_n ~= nil then
                        vim.validate{
                            tbl_n = {tbl_n, 't'}
                        }
                        for k,v in pairs(tbl_n) do
                            new_table[k] = v
                        end
                    end
                    return new_table
                end
            }),
        },
        options = settings.options or {g={}, w={}, b={}},
        plugins = settings.plugins or {}
    }

    function aloha.map:add_map(...)
        vim.list_extend(self.list, {...})
    end
    function aloha.map:add_maps(...)
        vim.list_extend(self.list, {...})
    end
    function aloha.map:setup()
        vim.g.mapleader = self.leader
        for _,map in pairs(self.list) do
            vim.api.nvim_set_keymap(map[1], map[2], map[3], self.default_args + map[4])
        end
    end

    function aloha.options:setup()
        for o,v in pairs(self.g) do
            vim.o[o] = v
        end
        for o,v in pairs(self.w) do
            vim.wo[o] = v
        end
        for o,v in pairs(self.b) do
            vim.bo[o] = v
            vim.o[o] = v
        end
    end

    aloha.map:setup()
    aloha.options:setup()

    aloha.packer = require('aloha.packer'):init(
        aloha.plugins,                  -- plugin list
        require('aloha.settings.plugin_configs'), -- plugin config
        {                             -- packer config
            git = 'proxychains -q git',
            rm = 'gio trash',
        }
    )

    -- preparation
    if not options.minimal or options.create_dirs then
        -- check and create dirs
        for _,path in ipairs({vim.o.backupdir, vim.o.directory, vim.o.undodir}) do
            if path ~= nil and path ~= '' then
                path = string.gsub(path, '^~', vim.env.HOME)
                if vim.fn.glob(path) == '' then
                    print('create dir: ' .. path)
                    vim.fn.mkdir(path, 'p')
                end
            end
        end
    end
    -- install plugins
    if not options.minimal or options.install_plugins then
        aloha.packer:download()
    end
    -- clean and update/install plugins
    if not options.minimal or options.sync_plugins then
        aloha.packer:clean()
        aloha.packer:download('update')
    end

    -- other
    vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}]]
end
