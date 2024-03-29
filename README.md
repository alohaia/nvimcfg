<h1 align="center">nvimcfg</h1>

<p align="center">My NeoVim configuration with built-in packer, written in Lua.</p>

[中文文档](./README_cn.md)

![2021-08-27_12-36-07](https://user-images.githubusercontent.com/36324537/131072598-7969fcce-3e29-49f2-bdb1-9851ddfda637.png)

![2021-08-27_12-33-04](https://user-images.githubusercontent.com/36324537/131072714-1db0ed6d-c6ef-421d-9641-0720342230da.png)

## Features

- Built-in packer
- Useful plugins with detailed configuration
- Written in Lua

## Requirements

- nvim ≥ 0.7
- Other softwares: [ripgrep](https://github.com/BurntSushi/ripgrep), git
- [language servers](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) you need, you can add related configs [here](https://github.com/alohaia/nvimcfg/blob/b814f4427880159fb9c2cd54cc82fe358798bd57/lua/aloha/plugin_configs.lua#L223).

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

## Usage

### Commands

- `PackInstall`
    - `PackInstall`: install all plugins(`disable != true`)
    - `PackInstall <plugin>`: install specific plugins(`disable != true`)
- `PackUpdate`
    - `PackUpdate`: update all installed plugins(`disable != true`) and install plugins which are not installed(`disable != true`)
    - `PackUpdate <plugin>`: update specific plugins(`disable != true`), install it if it's not installed
- `PackUninstall <plugin>`: uninstall specific plugins(`disable != true`)
- `PackClean`
    - `PackClean`: uninstall disabled plugins(`disable == true`)
    - `PackClean <plugin>`: same as `PackUninstall`
- `PackSync`: equivalent to `PackClean` + `PackUpdate`
- `PackAdd <plugin>`: load an opt plugin and its configs manually, use this command instead of `packadd` as far as possible

## Configuration

### `~/.config/nvim/init.lua`

```lua
-- Default config
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
```

- `packer`
    - [`plugins`](#plugins): plugin list with basic configuration, see `~/.config/nvim/lua/aloha/plugins.lua` for example
    - [`plugin_configs`](#plugin_configs): configuration for plugins, see `~/.config/nvim/lua/aloha/plugin_configs/init.lua` for example
    - `config`: settings for built-in packer
        - `pack_root`, `pack_name`: plugins will be installed under `pack_root/pack_name/{opt,start}`
        - `git`
            - `cmd`: base git command, can be replaced with `proxychains -q git` for example.
            - `clone_depth`: `--depth` option for `clone`
            - `shallow_submodules`: whether to add `--shallow-submodules` in `clone` command and add `--depth=1` in `submodule update` command
            - `base_url`: base URL of GitHub, you can replace this to use a mirror site
        - `strict_deps`: when set to `true`, a plugin's config won't be executed if any dependency of this plugin is not successfully loaded
- `transparency`: transparent background and related config
- `mapleader`：`<Leader>` key

> **Tips** You can set `packer.rm` to `gio trash` on GNOME. You can also set `packer.git` to `proxychains -q git` to use proxy, but using `~/.gitconfig` is better. For example:
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
>     ['alohaia/hugowiki.nvim'] = { ft = 'markdown,rmd,text' },
>     ['dhruvasagar/vim-table-mode'] = { ft = {'rmd', 'markdown', 'text'} },
>     ['godlygeek/tabular'] = {
>         config = function()
>             vim.cmd[[cnorea Tab Tabularize]]
>         end
>     },
>     ['jalvesaq/Nvim-R'] = {disable = true, ft = 'r', branch = 'master'},
>     ['kyazdani42/nvim-tree.lua'] = {
>         cmd = 'NvimTreeToggle',
>         map = {
>             {mode = 'n', lhs = '<leader>nt'},
>         }
>     },
>     ['lewis6991/gitsigns.nvim'] = {
>         dependency = 'nvim-lua/plenary.nvim'
>     },
>     ['nvim-telescope/telescope.nvim'] = {
>         cmd = 'Telescope',
>         map = {
>             {mode = 'n', lhs = ',f'},
>             {mode = 'n', lhs = ',b'},
>             {mode = 'n', lhs = ',F'},
>             {mode = 'n', lhs = ',g'},
>         },
>         dependency = {
>             'nvim-lua/plenary.nvim',
>             'nvim-lua/popup.nvim',
>             'nvim-telescope/telescope-fzy-native.nvim'
>         }
>     },
>
>     -- dependencies
>     ['nvim-lua/plenary.nvim'] = {opt=true},
>     ['nvim-lua/popup.nvim'] = {opt=true},
>     ['nvim-telescope/telescope-fzy-native.nvim'] = {opt=true},
>     ['nvim-treesitter/nvim-treesitter-textobjects'] = {opt=true},
> }
> ```

A key-value table of plugins. The key is a plugin's name like `alohaia/vim-hexowiki`, and the value is another dictionary of basic settings:

- `opt`(`bool`): Whether the plugin is installed as an opt pack. Plugins with `ft`, `cmd` or `enable` options are also opt plugins.
- `ft`(`string`, `list`): For which filetype(s) should the plugin be loaded, such as `'markdown,text'` and `{'markdown', 'text'}`.
- `cmd`(`string`, `list`): On which vim command(s) should the plugin be loaded.
- `map`(`table`): On which mapping(s) should the plugin be loaded.
- `enable`(`bool`, `function`): Whether to load this plugin.
- `branch`(`string`): Branch of the plugin. This is effective only at initial installation.
- `dependency`(`string`, `table`): Plugin's dependencies. A dependency should be in plugin list additionally and set `opt=true`.
- `disabled`(`bool`): Whether the plugin is disabled. Disabled plugins won't be installed or updated and will be removed while cleaning. The difference between disabled plugins and plugins that are not in the plugin list is that the former appears in completion list of packer [commands](#commands).
- `config`(`function`, `string`): Configuration for the plugin, Can be a function:
    - Function: well be directly called in due course.
    - String:
        - Begin with `:`: Regarded as a vim command
        - Begin with `!`: Regarded as a commandline command
        - Other cases: Regarded as a piece of Lua code

> I recommend you write only simple configuration in `config` and use `plugin_configs` which I'll introduce later to config plugins.

#### `plugin_configs`

A table of configuration for plugins. The key is a plugin's name, and the value is a function.

> **Example**
> `~/.config/nvim/lua/aloha/plugin_configs.lua`
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
> And then you can use `require('aloha.plugin_configs')` in [`~/.config/nvim/init.lua`](#~/.config/nvim/init.lua) to get plugin configs.
