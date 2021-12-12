<h1 align="center">nvimcfg</h1>

<p align="center">My NeoVim Configuration Written in Lua.</p>

![2021-08-27_12-36-07](https://user-images.githubusercontent.com/36324537/131072598-7969fcce-3e29-49f2-bdb1-9851ddfda637.png)

![2021-08-27_12-33-04](https://user-images.githubusercontent.com/36324537/131072714-1db0ed6d-c6ef-421d-9641-0720342230da.png)

## Installation

1. Move `~/.config/nvim` to another place
2. Clone this repo to `~/.config/nvim`:
    ```shell
    git clone https://github.com/alohaia/nvimcfg ~/.config/nvim
    ```
3. Enter `nvim` and do some preparation work:
    ```vimscript
    lua require('aloha.prepare')
    ```

## Configuration

### `~/.config/nvim/init.lua`

```lua
require("aloha")({
    packer_settings = {
        plugins = require('aloha.plugins'),
        plugin_configs = require('aloha.plugin_configs'),
        packer_config = {
            -- pack_root = vim.fn.stdpath('data') .. '/site/pack',
            -- pack_name = 'packer',
            -- git = 'git',
            -- rm = 'rm -rf',
        },
    }
})
```

- `packer_settings`
    - [`plugins`](#plugins): plugin list with basic configuration, see `~/.config/nvim/lua/aloha/plugins.lua` for example
    - [`plugin_configs`](#plugin_configs): configuration for plugins, see `~/.config/nvim/lua/aloha/plugin_configs/init.lua` for example
    - `packer_config`: settings for built-in packer

> **Tips** You can set `packer_config.rm` to `gio trash` on GNOME. You can also set `packer_config.git` to `proxychains -q git` to use proxy, but using `~/.gitconfig` is better. For example:
> ```dosini
> [http]
> 	proxy = socks5://127.0.0.1:1089
> [https]
> 	proxy = socks5://127.0.0.1:1089
> ```

#### `plugins`

> **Example** `~/.config/nvim/lua/aloha/plugins.lua`
> ```lua
> return {
>     ['RRethy/vim-illuminate'] = {},
>     ['luochen1990/rainbow'] = {},
>     ['alohaia/hugowiki.nvim'] = {ft='markdown,rmd,text'},
>     ['tpope/vim-surround'] = {},
>     ['tpope/vim-repeat'] = {},
>     ['dhruvasagar/vim-table-mode'] = {ft='rmd,markdown,text'},
>     ['svermeulen/vim-subversive'] = {},
>     ['mg979/vim-visual-multi'] = {},
>     ['jiangmiao/auto-pairs'] = {},
>     ['godlygeek/tabular'] = {
>         config = function()
>             vim.cmd[[cnorea Tab Tabularize]]
>         end
>     },
>     ['jalvesaq/Nvim-R'] = {disable = true, ft = 'r', branch = 'master'},
> }
> ```

A key-value table of plugins. The key is a plugin's name like `alohaia/vim-hexowiki`, and the value is a list of basic settings:

- `opt`(`bool`): whether the plugin is installed as an opt pack
- `ft`(`string`, `list`): for which filetypes is the plugin loaded, such as `'markdown,text'` and `{'markdown', 'text'}`
- `branch`(`string`): branch of the plugin
- `disabled`(`bool`): whether the plugin is disabled. Disabled plugins won't be installed or updated and will be removed while cleaning
- `config`(`function`, `string`): configuration for the plugin. If this is a function, it'll be directly called in due course. Otherwise, if this is a string, it will be executed accordingly:
    - Begin with `:`: regarded as a vim command
    - Begin with `!`: regarded as a system command
    - Other cases: regarded as a piece of Lua code

> I recommend you write only simple configuration in `config` and use `plugin_configs` which I'll introduce later to config plugins.

#### `plugin_configs`

A table of configuration for plugins. The key is a plugin's name, and the value is a function.

> **Example** `~/.config/nvim/lua/aloha/plugin_configs.lua`
> ```lua
> local configs = {}
> 
> configs['glepnir/galaxyline.nvim'] = function()
>     require('aloha.plugin_configs.galaxyline')
> end
> 
> configs['alohaia/hugowiki.nvim'] = function()
>     vim.g.hugowiki_home = '~/blog.hugo/content/'
>     vim.g.hugowiki_try_init_file = 1
>     vim.g.hugowiki_follow_after_create = 0
>     vim.g.hugowiki_use_imaps = 1
>     vim.g.hugowiki_disable_fold = 0
>     vim.g.markdown_fenced_languages = {
>         'lua',  'c', 'cpp', 'r', 'javascript', 'python',
>         'sh', 'bash', 'zsh', 'yaml', 'tex'
>     }
>     -- ...
> end
> 
> -- ...
> 
> return configs
> ```

### `~/.config/nvim/remain.vim`

Some VimL code, which will be sourced in `init.lua`. You can add your VimL code here.

## Features

- Built-in packer
- Useful plugins with detailed configuration
- Mostly written in Lua
- Snippets for [UltiSnips](https://github.com/SirVer/ultisnips)
