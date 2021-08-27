return function(_options)
    local options = vim.tbl_extend('keep', _options, {
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
                }
            ),
        },
        options = settings.options or {},
    }

    -- set up mappings
    vim.g.mapleader = aloha.map.leader
    for _,map in pairs(aloha.map.list) do
        vim.api.nvim_set_keymap(map[1], map[2], map[3], aloha.map.default_args + map[4])
    end

    -- set up options
    for o,v in pairs(aloha.options) do
        vim.opt[o] = v
    end

    -- plugins
    aloha.packer = require('aloha.packer'):init(options.packer_settings)
end
