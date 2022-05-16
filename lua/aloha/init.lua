return function(_configs)
    local configs = vim.tbl_extend('keep', _configs, {
        transparency = true,
        mapleader = ' ',
    })
    if configs.packer_settings == nil then
        configs.packer_settings = {
            plugins = require('aloha.plugins'),
            plugin_configs = require('aloha.plugin_configs'),
            packer_config = {
                pack_root = vim.fn.stdpath('data') .. '/site/pack',
                pack_name = 'packer',
                git = 'git',
                rm = 'rm -rf',
            }
        }
    end

    _G.aloha = { configs = configs }

    -- local settings = {}
    -- if vim.fn.glob('./settings/init.lua') or vim.fn.glob('./settings.lua') then
    --     settings = require('aloha.settings')
    -- end
    local settings = require('aloha.settings')

    _G.aloha = {
        map = {
            list = settings.mappings or {},
            leader = configs.mapleader or ' ',
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
        commands = settings.commands or {},
        configs = configs
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
    aloha.packer = require('aloha.packer'):init(configs.packer_settings)

    -- define user commands
    for cmd_name,cmd in pairs(aloha.commands) do
        vim.api.nvim_create_user_command(cmd_name, cmd.exec, cmd.opts or {})
    end

    -- autocmds
    require('aloha.autocmds')
end
