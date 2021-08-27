<h1 align="center">nvimcfg</h1>

<p align="center">My NeoVim Configuration Written in Lua.</p>

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
    - [`plugin_configs`](plugin_configs): configurations for plugins, see `~/.config/nvim/lua/aloha/plugin_configs/init.lua` for example
    - `packer_config`: settings for built-in packer

> **Tips** You can set `packer_config.rm` to `gio trash` on GNOME. You can also set `packer_config.git` to `proxychains -q git` to use proxy, but using `~/.gitconfig` is better. For example:
> 
> ```dosini
> [http]
> 	proxy = socks5://127.0.0.1:1089
> [https]
> 	proxy = socks5://127.0.0.1:1089
> ```

#### `plugins`

A key-value table of plugins. The key is a plugin's name like `alohaia/vim-hexowiki`, and the value is a list of basic settings:

- `opt`(`bool`): whether the plugin is installed as an opt pack
- `ft`(`string`, `list`): for which filetypes is the plugin loaded, such as `'markdown,text'` and `{'markdown', 'text'}`
- `branch`(`string`): branch of the plugin
- `disabled`(`bool`): whether the plugin is disabled. Disabled plugins won't be installed or updated and will be removed while cleaning
- `config`(`function`, `string`): configuration for the plugin. If this is a function, it'll be directly called in due course. Otherwise, if this is a string, it will be executed accordingly:
    - Begin with `:`: regarded as a vim command
    - Begin with `!`: regarded as a system command
    - Other cases: regarded as a piece of Lua code

> I recommend you write only simple configurations in `config` and use `plugin_configs` which I'll introduce later to config plugins.

#### `plugin_configs`

A table of configurations for plugins. The key is a plugin's name, and the value is a function.

### `~/.config/nvim/remain.vim`

Some VimL code, which will be sourced in `init.lua`. You can add your VimL code here.
