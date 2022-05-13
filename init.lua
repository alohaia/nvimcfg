require "aloha" {
    packer_settings = {
        plugins = require('aloha.plugins'),
        plugin_configs = require('aloha.plugin_configs'),
        packer_config = {
            -- pack_root = vim.fn.stdpath('data') .. '/site/pack',
            -- pack_name = 'packer',
            -- git = 'git',
            rm = 'gio trash',
        },
    },
    transparency = true,
}

vim.cmd[[cabbrev <expr> %% expand('%:p')]]
