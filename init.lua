-- See https://github.com/alohaia/nvimcfg#confignviminitlua
require 'aloha' {
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
       },
    },
    transparency = true,
    mapleader = ' ',
}
