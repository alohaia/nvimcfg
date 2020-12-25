----------------------------------------------------------------------------------------
--                         \ Settings and Global Variables /                          --
----------------------------------------------------------------------------------------

-------------------------------\ Require and Abbreviate /-------------------------------
local g          = vim.g
local global     = aloha.settings
local join_paths = aloha.utils.join_paths
local add_map    = aloha.utils.add_map
local add_maps   = aloha.utils.add_maps

----------------------------------\ nvim-treesitter /-----------------------------------
local ts = require 'nvim-treesitter.configs'
ts.setup {ensure_installed = 'maintained', highlight = {enable = true}}

------------------------------------\ vim-startify /------------------------------------
g.startify_change_to_vcs_dir   = 1
g.startify_change_to_dir       = 0
g.startify_fortune_use_unicode = 1
g.startify_padding_left        = 3
g.startify_session_dir         = join_paths(global.cache_base, 'startify')
g.startify_session_persistence = 0
g.startify_session_autoload    = 1
g.startify_skiplist            = {
    [[\.git]],
}
g.startify_files_number = 10
g.startify_bookmarks = {
    '~/.config/nvim/plugins/vimspector/docs/schema/vimspector.schema.json',
    '~/.config/nvim/plugins/vimspector/docs/schema/gadgets.schema.json',
}
g.startify_commands = {
    { t = {'Press t to open coc-explorer.',      'CocCommand explorer'}},
    { w = {"Open Index page for Vimwiki.",       'VimwikiIndex'}},
    { d = {"Open Index page for Vimwiki Diary.", 'VimwikiDiaryIndex'}},
}
g.startify_lists = {
    { type = 'commands',  header = {'   Commands'}              },
    { type = 'files',     header = {'   Recent Opened Files'}   },
    { type = 'sessions',  header = {'   Sessions'}              },
    { type = 'dir',       header = {'   PWD: '..vim.fn.getcwd()}},
    { type = 'bookmarks', header = {'   Bookmarks'}             },
}

-----------------------------------\ vim-which-key /------------------------------------
add_map('n', '<leader><leader>', [[:<C-u>WhichKey ""<Left>]], {silent = false})
g.which_key_map = {}
g.which_key_map.j = { name = '+file' }

--------------------------------------\ undotree /--------------------------------------
add_map('n', '<leader>ut', '<Cmd>UndotreeToggle<CR>')
g.undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
g.undotree_CustomDiffpanelCmd = 'botright 10 new'
g.undotree_SetFocusWhenToggle = 1
g.undotree_TreeNodeShape      = '⚑'
g.undotree_RelativeTimestamp  = 0
g.undotree_HelpLine           = 0

---------------------------------------\ rnvimr /---------------------------------------
add_map('n', '<CR>', '<Cmd>RnvimrToggle<cr>')
g.rnvimr_ex_enable = 1
g.rnvimr_pick_enable = 1
g.rnvimr_draw_border = 1
g.rnvimr_border_attr = {fg = 39, bg = -1}
g.rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"'
g.rnvimr_layout = {
    relative = 'editor',
    width    =  vim.o.columns,
    height   =  vim.o.lines,
    col      =  0,
    row      =  0,
    style    =  'minimal' }
g.rnvimr_presets = {
    {width = 1.0, height = 1.0},
}

-------------------------------------\ defx.nvim /--------------------------------------
add_map('n', '<leader>df', '<Cmd>Defx<Cr>')
vim.fn['defx#custom#option']('_', {
    columns = 'mark:indent:git:icon:icons:filename:type:size:time',
    sort = 'filename',
    preview_height = vim.o.lines/2,
    split = 'vertical', winwidth = 40, direction = 'topleft',
    root_marker = '[in]: ',
    buffer_name = 'Defx',
    show_ignored_files = 0, ignored_files = '.*,*.webp,*.png,*.jpg,*.o,*.exe',
    toggle = 1, resume = 1, focus = 1
})
vim.fn['defx#custom#column']('git', 'indicators', {
    Modified  = 'M',
    Staged    = 'S',
    Untracked = 'U',
    Renamed   = 'R',
    Unmerged  = '=',
    Ignored   = '~',
    Deleted   = 'D',
    Unknown   = '?',
})
vim.fn['defx#custom#column']('indent', 'indent', '  ')
vim.fn['defx#custom#column']('icon', {
    directory_icon = '▸',
    opened_icon    = '▾',
    root_icon      = ' ',
})

vim.fn['defx#custom#source']('file', {
    root = 'Root',
})
g.defx_icons_column_length = 1
g.defx_icons_mark_icon     = ''
g.defx_icons_parent_icon   = ""
vim.fn['defx#custom#column']('mark', { readonly_icon = '', selected_icon = '' })

-------------------------------------\ choosewin /--------------------------------------
add_map('n', '<C-w><C-i>', '<Cmd>ChooseWin<CR>')
g.choosewin_color_label         = {
    gui   = {'#af00ff', 'black', 'bold'},
    cterm = {129,       16,      'bold'},
}
g.choosewin_color_label_current = {
    gui   = {'#afafff', 'white', 'bold'},
    cterm = {147,       15,      'bold'},
}
g.choosewin_color_overlay         = g.choosewin_color_label
g.choosewin_color_overlay_current = g.choosewin_color_label_current
g.choosewin_color_land            = {
    gui   = {'#00ffff', 'Black', 'bold,underline'},
    cterm = {51, 15}
}
g.choosewin_label_fill           = 0
g.choosewin_blink_on_land        = 0
g.choosewin_return_on_single_win = 0
g.choosewin_statusline_replace   = 0
g.choosewin_overlay_enable       = 1
g.choosewin_overlay_shade        = 1

-------------------------------------\ vista.vim /--------------------------------------
add_maps(
    {'n', '<leader>vt', '<Cmd>Vista<Cr>'},
    {'n', ',T', '<Cmd>Vista finder<Cr>'}
)
g.vista_default_executive = 'ctags'
g.vista_ctags_project_opts = '--sort=no -R -o .tags'
g.vista_executive_for = {
    vimwiki  = 'markdown',
    pandoc   = 'markdown',
    markdown = 'toc',
}
g.vista_enable_markdown_extension    = 1
g['airline#extensions#fzf#enabled']  = 1
g.vista_enable_markdown_extension    = 1
g.vista_fzf_preview                  = {'right:50%'}
g.vista_sidebar_width                = 50
g.vista_fold_toggle_icons            = {'▾', '▸'}
g.vista_icon_indent                  = {"└─▸ ", "├─▸ "}
g.vista_cursor_delay                 = 200
g.vista_update_on_text_changed       = 1
g.vista_update_on_text_changed_delay = 2000
g.vista_close_on_jump                = 1
g.vista_stay_on_open                 = 1
g.vista_blink                        = {0, 0}
g.vista_top_level_blink              = {0, 0}

------------------------------------\ vim-devicons /------------------------------------
g.webdevicons_enable                 = 1
g.webdevicons_enable_airline_tabline = 1
g.airline_powerline_fonts            = 1

----------------------------------\ nvim-treesitter /-----------------------------------
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        custom_captures = {
            -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
            -- ["foo.bar"] = "Identifier",
        },
    },
    keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
    },
    indent = {
        enable = true,
    }
}

return true
