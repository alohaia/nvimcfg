return function(_configs)
    _G.aloha = { utils = require('aloha.utils') }

    local configs = vim.tbl_deep_extend('keep', _configs, {
        transparency = true,
        mapleader = ' ',
        packer = {
            plugins = require('aloha.plugins'),
            plugin_configs = require('aloha.plugin_configs'),
            config = {
                pack_root = vim.fn.stdpath('data') .. '/site/pack',
                pack_name = 'packer',
                git = {
                    cmd = 'git',
                    clone_depth = 1,
                    clone_submodules = true,
                    shallow_submodules = true,
                    base_url = 'https://github.com',
                },
                rm = 'rm -rf',
                strict_deps = true,
            }
        }
    })

    aloha.configs = configs

    local settings = require('aloha.settings')

    aloha.map = {
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
    }
    aloha.options = settings.options or {}
    aloha.commands = settings.commands or {}
    aloha.autocmds = settings.autocmds or {}

    -- set up mappings
    vim.g.mapleader = aloha.map.leader
    for _,map in pairs(aloha.map.list) do
        vim.keymap.set(map[1], map[2], map[3], aloha.map.default_args + map[4])
    end

    -- set up options
    if aloha.options.global_options then
        for o,v in pairs(aloha.options.global_options) do
            vim.opt[o] = v
        end
    end
    if aloha.options.filetype_options then
        local ft_options_id = vim.api.nvim_create_augroup("aloha_ft_options", {clear=true})
        for filetypes,options in pairs(aloha.options.filetype_options) do
            vim.api.nvim_create_autocmd("FileType", {
                group = ft_options_id,
                pattern = filetypes,
                callback = function ()
                    for o,v in pairs(options) do
                        vim.opt_local[o] = v
                    end
                end
            })
        end
    end

    -- packer
    aloha.packer = require('aloha.packer'):init(configs.packer)

    -- define user commands
    for cmd_name,cmd in pairs(aloha.commands) do
        vim.api.nvim_create_user_command(cmd_name, cmd.exec, cmd.opts or {})
    end

    -- autocmds
    local au_id = vim.api.nvim_create_augroup('aloha_autocmds', {clear=true})
    for _,autocmd in ipairs(aloha.autocmds) do
        vim.api.nvim_create_autocmd(autocmd[1], vim.tbl_extend('keep', autocmd[2], {group=au_id}))
    end
end
