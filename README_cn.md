<h1 align="center">nvimcfg</h1>

<p align="center">我的 NeoVim 配置，内置 packer，大部分使用 Lua 编写。</p>

![2021-08-27_12-36-07](https://user-images.githubusercontent.com/36324537/131072598-7969fcce-3e29-49f2-bdb1-9851ddfda637.png)

![2021-08-27_12-33-04](https://user-images.githubusercontent.com/36324537/131072714-1db0ed6d-c6ef-421d-9641-0720342230da.png)

## 特性

- 内置的 packer
- 许多有用的插件，详尽的配置
- 大部分使用 Lua 编写
- [UltiSnips](https://github.com/SirVer/ultisnips) 代码片段

## 安装

1. 将 `~/.config/nvim` 移到另一个地方
2. 将这个仓库克隆到 `~/.config/nvim`:
    ```shell
    git clone https://github.com/alohaia/nvimcfg ~/.config/nvim
    ```
3. 进入 `nvim`，做一些准备工作:
    ```vimscript
    lua require('aloha.prepare')
    ```

## 使用

### 命令

内置 packer 的命令：

- `PackInstall`
    - `PackInstall`：安装所有插件（`disable != true`）
    - `PackInstall <plugin>`：安装指定插件（`disable != true`）
- `PackUpdate`
    - `PackUpdate`：更新所有已安装的插件（`disable != true`） 并安装未安装的插件（`disable != true`）
    - `PackUpdate <plugin>`：更新指定插件（`disable != true`），如果未安装则安装指定插件
- `PackUninstall <plugin>`：卸载指定插件（`disable != true`）
- `PackClean`
    - `PackClean`：卸载禁用的插件（`disable == true`）
    - `PackClean <plugin>`：与 `PackUninstall <plugin>` 相同
- `PackSync`：相当于 `PackClean` + `PackUpdate`
- `PackAdd <plugin>`：手动加载一个 `opt` 插件及其配置

其他命令：

- `Format`（neovim/nvim-lspconfig）：调用 `vim.lsp.buf.formatting()` 格式化代码

### 快捷键

基本快捷键：

| 模式    | 按键         | 映射                                              | 说明                                  |
|---------|--------------|---------------------------------------------------|---------------------------------------|
| `n`,`x` | `;`          | `:`                                               | 交换 `;` 和 `:`                       |
| `n`,`x` | `:`          | `;`                                               | *同上*                                |
| `n`,`x` | `J`          | `5j`                                              | 快速移动                              |
| `n`,`x` | `K`          | `5k`                                              | *同上*                                |
| `n`     | `<leader>n`  | `nzz`                                             | 搜索下一个并居中                      |
| `n`     | `<leader>N`  | `Nzz`                                             | 搜索上一个并居中                      |
| `n`     | `<esc>`      | `<Cmd>nohl<cr>`                                   | normal 模式 `ESC` 消除搜索高亮        |
| `n`     | `Y`          | `y$`                                              | `Y` 复制直到行尾，与 `D` 类似         |
| `i`     | `<M-BS>`     | `<Del>`                                           | 插入模式 Alt + 退格键删除光标后的文字 |
| `i`     | `<M-CR>`     | `<ESC>o`                                          | 插入模式快速换行                      |
| `n`,`x` | `<C-h>`      | `<C-w><C-h>`                                      | 快速切换窗口                          |
| `n`,`x` | `<C-j>`      | `<C-w><C-j>`                                      | *同上*                                |
| `n`,`x` | `<C-k>`      | `<C-w><C-k>`                                      | *同上*                                |
| `n`,`x` | `<C-l>`      | `<C-w><C-l>`                                      | *同上*                                |
| `n`,`x` | `-`          | `<Cmd>bp<cr>`                                     | 快速切换 buffer                       |
| `n`,`x` | `=`          | `<Cmd>bn<cr>`                                     | *同上*                                |
| `n`,`x` | `_`          | `<Cmd>tabprevious<cr>`                            | 快速切换 tab                          |
| `n`,`x` | `+`          | `<Cmd>tabnext<cr>`                                | *同上*                                |
| `n`     | `<leader>ba` | `<Cmd>bufdo bd<cr>`                               | 删除所有 buffer                       |
| `n`     | `<leader>bo` | `<Cmd>%bd\|e#\|bd#<cr>`                           | 删除当前 buffer 以外的所有 buffer     |
| `n`     | `<leader>tn` | `<Cmd>tabnew<cr>`                                 | 新建 tab                              |
| `n`     | `<leader>tc` | `<Cmd>tabclose<cr>`                               | 关闭当前 tab                          |
| `n`     | `<leader>to` | `<Cmd>tabonly<cr>`                                | 关闭当前 tab 以外的所有 tab           |
| `n`     | `]t`         | `<Cmd>tablast<cr>`                                | 切换到最后一个 tab                    |
| `n`     | `[t`         | `<Cmd>tabfirst<cr>`                               | 切换到第一个 tab                      |
| `n`     | `<UP>`       | `<Cmd>res +5<CR>`                                 | 沿垂直方向增大窗口                    |
| `n`     | `<DOWN>`     | `<Cmd>res -5<CR>`                                 | 沿垂直方向减小窗口                    |
| `n`     | `<Left>`     | `<Cmd>vertical resize-5<CR>`                      | 沿水平方向增大窗口                    |
| `n`     | `<Right>`    | `<Cmd>vertical resize+5<CR>`                      | 沿水平方向减小窗口                    |
| `i`     | `<M-l>`      | `<Right>`                                         | *同上*                                |
| `i`     | `<M-h>`      | `<Left>`                                          | 插入模式下移动光标                    |
| `i`     | `<M-k>`      | `<Up>`                                            | *同上*                                |
| `i`     | `<M-j>`      | `<Down>`                                          | *同上*                                |
| `n`     | `<M-k>`      | ``mz:m-2<cr>`z``                                  | 常规模式上移光标所在的行              |
| `n`     | `<M-j>`      | ``mz:m+<cr>`z``                                   | 常规模式下移光标所在的行              |
| `x`     | `<M-j>`      | ``:m'>+<cr>`<my`>mzgv`yo`z``                      | visual 模式上移选中的的行             |
| `x`     | `<M-k>`      | ``:m'<-2<cr>`>my`<mzgv`yo`z``                     | visual 模式下移选中的的行             |
| `n`     | `<M-l>`      | `5zh`                                             | （行过长时）向左移动文本              |
| `n`     | `<M-h>`      | `5zl`                                             | （行过长时）向右移动文本              |
| `n`     | `<leader>o`  | `mzo<esc>`z`                                      | 在下方插入空行                        |
| `n`     | `<leader>O`  | `mzO<esc>`z`                                      | 在上方插入空行                        |
| `n`     | `<leader>e`  | `:e $HOME/.config/nvim/lua/aloha/<C-z>`           | 快速打开配置文件                      |
| `c`     | `<M-e>`      | `getcmdtype()==':' ? expand('%:p:h').'/' : ''`    | 命令模式下快速插入当前文件所在目录    |
| `i`     | `<C-s>`      | ``<c-g>u<Esc>[s1z=`^a<c-g>u``                     | 纠正光标前单词的拼写                  |
| `n`,`x` | `<C-c>`      | `"+yW""yW`,`"+ygv""y`                             | 复制到系统剪切板                      |
| `t`     | `<M-q>`      | `<C-\\><C-n>`                                     | 终端模式下退回常规模式                |
| `i`     | `<M-a>`      | `<HOME>`                                          | 插入模式下移动光标到行首              |
| `i`     | `<M-e>`      | `<END>`                                           | 插入模式下移动光标到行尾              |
| `n`     | `<Leader>ws` | `nnoremap <Leader>as i<Space><Esc>ea<Space><Esc>` | 快速添加包围的空格                    |
| `x`     | `as`         | ``<ESC>`<lt>i<Space><Esc>`>la<Space><Esc>``       | *同上*                                |


插件相关的快捷键：

| 模式 | 按键                 | 映射                                           | 说明                                              |
|------|----------------------|------------------------------------------------|---------------------------------------------------|
| `n`  | `<leader>tm`         | `<cmd>TableModeToggle<cr>`                     | 开关“表格模式”，见 `:h table-mode.txt`            |
| `i`  | `<C-a>`              | `<Cmd>ToggleCheckbox<CR>`                      | 见 `:h bullets.txt`                               |
| `n`  | `<leader>sn`         | `<Cmd>RenumberList<CR>`                        | *同上*                                            |
| `x`  | `<leader>sn`         | `<Cmd>RenumberSelection<CR>`                   | *同上*                                            |
| `n`  | `gD`                 | `<cmd> lua vim.lsp.buf.declaration()`          | 跳转到声明                                        |
| `n`  | `gd`                 | `<cmd> lua vim.lsp.buf.definition()`           | 跳转到定义                                        |
| `n`  | `<leader>?`          | `<cmd> lua vim.lsp.buf.hover()`                | 在浮动窗口中查看文档                              |
| `n`  | `<leader>r`          | `<cmd> lua vim.lsp.buf.references()`           | 列出所有引用                                      |
| `n`  | `<leader>rn`         | `<cmd> lua vim.lsp.buf.rename()`               | 重命名                                            |
| `n`  | `<leader>?`          | `<cmd> lua vim.lsp.diagnostic.set_loclist()`   | 列出代码审查结果                                  |
| `n`  | `<leader>ti`         | init_selection                                 | 见 `:h nvim-treesitter-incremental-selection-mod` |
| `x`  | `<leader>ta`         | node_incremental                               | *同上*                                            |
| `x`  | `<leader>ts`         | scope_incremental                              | *同上*                                            |
| `x`  | `<leader>td`         | node_decremental                               | *同上*                                            |
| `i`  | `<Down>`,`<Tab>`     | nvim-cmp 快捷键                                | 方向下键/Tab 选择补全下一个                       |
| `i`  | `<Up>`,`<S-Tab>`     | nvim-cmp 快捷键                                | 方向上键/Tab 选择补全上一个                       |
| `i`  | `CR`                 | nvim-cmp 快捷键                                | 回车确定补全选择                                  |
| `i`  | `<C-Space>`          | ultisnips 快捷键                               | 展开代码片段                                      |
| `i`  | `<C-j>`              | ultisnips 快捷键                               | 移动到下一个 placeholder                          |
| `i`  | `<C-k>`              | ultisnips 快捷键                               | 移动到上一个 placeholder                          |
| `n`  | `<C-\\>`             | vim-floaterm 快捷键                            | 开关浮动终端                                      |
| `n`  | `<F1>`               | vim-floaterm 快捷键                            | 切换到前一个浮动终端                              |
| `n`  | `<F2>`               | vim-floaterm 快捷键                            | 切换到后一个浮动终端                              |
| `n`  | `<F3>`               | vim-floaterm 快捷键                            | 新建浮动终端                                      |
| `n`  | `<F4>`               | vim-floaterm 快捷键                            | 杀死当前浮动终端                                  |
| `n`  | `<leader>ut`         | `<Cmd>UndotreeToggle<CR>`                      | 开关修改历史树，见 `:h undotree.txt`              |
| `n`  | `<leader>vt`         | `<Cmd>Vista<Cr>`                               | vista.vim，开关标签列表                           |
| `n`  | `,T`                 | `<Cmd>Vista finder<Cr>`                        | vista.vim，查找 ctags 标签                        |
| `n`  | `,g`                 | `<Cmd>Telescope live_grep<CR>`                 | telescope.nvim，在当前目录查找文件内容            |
| `n`  | `,f`                 | `<Cmd>Telescope find_files<CR>`                | telescope.nvim，在当前目录查找文件                |
| `n`  | `,b`                 | `<Cmd>Telescope buffers<CR>`                   | telescope.nvim，在当前目录查找 buffer             |
| `n`  | `,F`                 | `<Cmd>Telescope file_browser<CR>`              | telescope.nvim，在当前目录浏览文件                |
| `n`  | `gb`                 | `<Cmd>BufferLinePick<CR>`                      | nvim-bufferline.lua，快速切换 buffer              |
| `n`  | `<leader>nt`         | `<Cmd>NvimTreeToggle<CR>`                      | 打开 nvim-tree.lua（文件浏览器）                  |
| `n`  | `<F5>`               | `<cmd>AsyncTask run<cr>`                       | asynctasks.vim，运行 run 任务                     |
| `n`  | `<F6>`               | `<cmd>AsyncTask build<cr>`                     | asynctasks.vim，运行 build 任务                   |
| `n`  | `s`                  | `<plug>(SubversiveSubstitute)`                 | 见 `:h subversive.txt`                            |
| `x`  | `s`                  | `<plug>(SubversiveSubstitute)`                 | *同上*                                            |
| `x`  | `p`                  | `<plug>(SubversiveSubstitute)`                 | *同上*                                            |
| `x`  | `P`                  | `<plug>(SubversiveSubstitute)`                 | *同上*                                            |
| `n`  | `ss`                 | `<plug>(SubversiveSubstituteLine)`             | *同上*                                            |
| `n`  | `S`                  | `<plug>(SubversiveSubstituteToEndOfLine)`      | *同上*                                            |
| `n`  | `<leader>s`          | `<plug>(SubversiveSubstituteRange)`            | *同上*                                            |
| `x`  | `<leader>s`          | `<plug>(SubversiveSubstituteRange)`            | *同上*                                            |
| `n`  | `<leader>ss`         | `<plug>(SubversiveSubstituteWordRange)`        | *同上*                                            |
| `n`  | `<leader>cr`         | `<plug>(SubversiveSubstituteRangeConfirm)`     | *同上*                                            |
| `x`  | `<leader>cr`         | `<plug>(SubversiveSubstituteRangeConfirm)`     | *同上*                                            |
| `n`  | `<leader>crr`        | `<plug>(SubversiveSubstituteWordRangeConfirm)` | *同上*                                            |
| `n`  | `<leader><leader>s`  | `<plug>(SubversiveSubvertRange)`               | *同上*                                            |
| `x`  | `<leader><leader>s`  | `<plug>(SubversiveSubvertRange)`               | *同上*                                            |
| `n`  | `<leader><leader>ss` | `<plug>(SubversiveSubvertWordRange)`           | *同上*                                            |

> 插件自带的命令见各自的文档。

## 配置

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
    - [`plugins`](#plugins)：插件列表和一些简单配置，示例见 `~/.config/nvim/lua/aloha/plugins.lua`
    - [`plugin_configs`](#plugin_configs)：插件配置，示例见 `~/.config/nvim/lua/aloha/plugin_configs/init.lua`
    - `packer_config`：内置 packer 的配置

> **Tips** 在 GNOME 上，你可以将 `packer_config.rm` 设置为 `gio trash`。你可以将 `packer_config.git` 设置为 `proxychains -q git`，但是用 `~/.gitconfig` 更好，比如:
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
>     -- 依赖项
>     ['nvim-lua/plenary.nvim'] = {opt=true},
>     ['nvim-lua/popup.nvim'] = {opt=true},
>     ['nvim-telescope/telescope-fzy-native.nvim'] = {opt=true},
>     ['nvim-treesitter/nvim-treesitter-textobjects'] = {opt=true},
> }
> ```

一个用来表示插件的键-值对字典。“键”是插件的名称如 `alohaia/vim-hexowiki`，“值”是另一个字典，包含一些基本设置：

- `opt`(`bool`)：该插件是否是 `opt` 插件。设置了 `ft`, `cmd` or `enable` 选项的插件也是 `opt` 插件。
- `ft`(`string`, `list`)：对哪些文件类型启用该插件，如 `'markdown,text'` 或 `{'markdown', 'text'}`。
- `cmd`(`string`, `list`)：在使用哪些 Vim 命令时启用该插件。
- `map`(`table`): 在按下哪些映射时启用该插件。
- `enable`(`bool`, `function`)：根据布尔值或函数返回值决定是非加载该插件。
- `branch`(`string`)：插件的 GitHub 仓库的分支。
- `dependency`(`string`, `table`)：插件的依赖项。依赖项应该单独列在列表中，并且设置 `opt=true`。
- `disabled`(`bool`)：是否禁用该插件。禁用的插件不会被安装或更新，并会在清理（`PackClean`）时被移除。禁用的插件和不在列表中的插件的区别是，前者会出现在[命令](#命令)补全中。
- `config`(`function`, `string`)：插件的简单配置。可以是函数或者字符串：
    - 函数：会在适当的时候调用
    - 字符串：
        - 以 `:` 开头：视为 Vim 命令
        - 以 `!` 开头：视为命令行命令
        - 其他情况：视为一段 Lua 代码

> 我建议只在 `config` 作一些简单配置，详细的配置使用 [`plugin_configs`](#plugin_configs) 完成。

#### `plugin_configs`

一个包含插件配置的字典。“键”是插件的名称，“值”是一个函数。

> **Example**
> `~/.config/nvim/lua/aloha/plugin_configs.lua`
> ```lua
>
> local configs = {}
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
> 然后就可以在之前提到的 [`~/.config/nvim/init.lua`](#~/.config/nvim/init.lua) 文件中通过 `require('aloha.plugin_configs')` 获取插件配置。
