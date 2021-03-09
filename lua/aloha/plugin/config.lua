----------------------------------------------------------------------------------------
--                          \ Configurations for Plugins /                            --
----------------------------------------------------------------------------------------
_G.aloha.plugin.config = {}
local config = _G.aloha.plugin.config

-------------------------------\ Require and Abbreviate /-------------------------------
-- TODO: config functions using abbreviate can't be done properly.
local g          = vim.g
local global     = _G.aloha.global
local join_paths = _G.aloha.utils.join_paths
local add_map    = _G.aloha.wim.map.add_map
local add_maps   = _G.aloha.wim.map.add_maps

-------------------------------------\ ultisnips /--------------------------------------
config.ultisnips = function()
    vim.g.UltiSnipsEditSplit="vertical"
    vim.g.UltiSnipsRemoveSelectModeMappings = 0
    vim.g.UltiSnipsExpandTrigger="<c-space>"
    vim.g.UltiSnipsJumpForwardTrigger="<c-j>"
    vim.g.UltiSnipsJumpBackwardTrigger="<c-k>"
end

--------------------------------------\ ondedark /--------------------------------------
config.onedark = function()
    -- vim.cmd('colorscheme onedark')
end

------------------------------------\ vim-startify /------------------------------------
config.startify = function()
    vim.g.startify_change_to_vcs_dir   = 1
    vim.g.startify_change_to_dir       = 0
    vim.g.startify_fortune_use_unicode = 0
    vim.g.startify_padding_left        = 3
    vim.g.startify_session_dir         =
                aloha.utils.join_paths(aloha.global.paths.cache_base, 'startify')
    vim.g.startify_session_persistence = 0
    vim.g.startify_session_autoload    = 1
    vim.g.startify_skiplist            = {
        [[\.git]],
    }
    vim.g.startify_files_number = 10
    vim.g.startify_bookmarks = {
        '~/.config/nvim/plugins/vimspector/docs/schema/vimspector.schema.json',
        '~/.config/nvim/plugins/vimspector/docs/schema/gadgets.schema.json',
    }
    vim.g.startify_commands = {
        { t = {'Press t to open coc-explorer.',      'CocCommand explorer'}},
        { w = {"Open Index page for Vimwiki.",       'VimwikiIndex'}},
        { d = {"Open Index page for Vimwiki Diary.", 'VimwikiDiaryIndex'}},
    }
    vim.g.startify_lists = {
        { type = 'commands',  header = {'   Commands'}              },
        { type = 'files',     header = {'   Recent Opened Files'}   },
        { type = 'sessions',  header = {'   Sessions'}              },
        { type = 'dir',       header = {'   PWD: '..vim.fn.getcwd()}},
        { type = 'bookmarks', header = {'   Bookmarks'}             },
    }
end

-----------------------------------\ vim-which-key /------------------------------------
config.which_key = function()
    aloha.wim.map.add_map('n', '<leader><leader>', [[:<C-u>WhichKey ""<Left>]], {silent = false})
    vim.g.which_key_map = {}
    vim.g.which_key_map.j = { name = '+file' }
end

--------------------------------------\ undotree /--------------------------------------
function config.undotree()
    aloha.wim.map.add_map('n', '<leader>ut', '<Cmd>UndotreeToggle<CR>')
    vim.g.undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
    vim.g.undotree_CustomDiffpanelCmd = 'botright 10 new'
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_TreeNodeShape      = '⚑'
    vim.g.undotree_RelativeTimestamp  = 0
    vim.g.undotree_HelpLine           = 0
end

---------------------------------------\ rnvimr /---------------------------------------
function config.rnvimr()
    aloha.wim.map.add_map('n', '<CR>', '<Cmd>RnvimrToggle<cr>')
    vim.g.rnvimr_ex_enable = 1
    vim.g.rnvimr_pick_enable = 1
    vim.g.rnvimr_draw_border = 1
    vim.g.rnvimr_border_attr = {fg = 39, bg = -1}
    vim.g.rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"'
    vim.g.rnvimr_layout = {
        relative = 'editor',
        width    =  vim.o.columns,
        height   =  vim.o.lines,
        col      =  0,
        row      =  0,
        style    =  'minimal' }
    vim.g.rnvimr_presets = {
        {width = 1.0, height = 1.0},
    }
end

-----------------------------------\ defx.nvim /--------------------------------------
function config.defx()
    aloha.wim.map.add_map('n', '<leader>df', '<Cmd>Defx<Cr>')
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
    vim.g.defx_icons_column_length = 1
    vim.g.defx_icons_mark_icon     = ''
    vim.g.defx_icons_parent_icon   = ""
    vim.fn['defx#custom#column']('mark', { readonly_icon = '', selected_icon = '' })
end

-------------------------------------\ choosewin /--------------------------------------
function config.choosewin()
    aloha.wim.map.add_map('n', '<C-w><C-i>', '<Cmd>ChooseWin<CR>')
    vim.g.choosewin_color_label         = {
        gui   = {'#af00ff', 'black', 'bold'},
        cterm = {129,       16,      'bold'},
    }
    vim.g.choosewin_color_label_current = {
        gui   = {'#afafff', 'white', 'bold'},
        cterm = {147,       15,      'bold'},
    }
    vim.g.choosewin_color_overlay         = vim.g.choosewin_color_label
    vim.g.choosewin_color_overlay_current = vim.g.choosewin_color_label_current
    vim.g.choosewin_color_land            = {
        gui   = {'#00ffff', 'Black', 'bold,underline'},
        cterm = {51, 15}
    }
    vim.g.choosewin_label_fill           = 0
    vim.g.choosewin_blink_on_land        = 0
    vim.g.choosewin_return_on_single_win = 0
    vim.g.choosewin_statusline_replace   = 0
    vim.g.choosewin_overlay_enable       = 1
    vim.g.choosewin_overlay_shade        = 1
end

-------------------------------------\ vista.vim /--------------------------------------
function config.vista()
    aloha.wim.map.add_maps(
        {'n', '<leader>vt', '<Cmd>Vista<Cr>'},
        {'n', ',T', '<Cmd>Vista finder<Cr>'}
    )
    vim.g.vista_default_executive = 'ctags'
    vim.g.vista_ctags_executable = 'ctags'
    vim.g.vista_ctags_project_opts = '--sort=no -R -o tags'
    vim.g.vista_executive_for = {
        vimwiki  = 'markdown',
        pandoc   = 'markdown',
        markdown = 'toc',
    }
    vim.g.vista_enable_markdown_extension    = 1
    vim.g['airline#extensions#fzf#enabled']  = 1
    vim.g.vista_enable_markdown_extension    = 1
    vim.g.vista_fzf_preview                  = {'right:50%'}
    vim.g.vista_sidebar_width                = 50
    vim.g.vista_fold_toggle_icons            = {'▾', '▸'}
    vim.g.vista_icon_indent                  = {"└─▸ ", "├─▸ "}
    vim.g.vista_echo_cursor                  = 1
    vim.g.vista_cursor_delay                 = 0
    vim.g.vista_echo_cursor_strategy         = 'scroll'
    vim.g.vista_update_on_text_changed       = 1
    vim.g.vista_update_on_text_changed_delay = 2000
    vim.g.vista_close_on_jump                = 0
    vim.g.vista_stay_on_open                 = 1
    vim.g.vista_blink                        = {0, 0}
    vim.g.vista_top_level_blink              = {0, 0}
    vim.g.vista_highlight_whole_line         = 1
    -- g['vista#renderer#icons'] = {
    --     function = "",
    --     variable = "",
    -- }
end

------------------------------------\ vim-devicons /------------------------------------
function config.devicons()
    vim.g.webdevicons_enable                 = 1
    vim.g.webdevicons_enable_airline_tabline = 1
    vim.g.airline_powerline_fonts            = 1
end

----------------------------------\ nvim-treesitter /-----------------------------------
function config.treesitter()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = 'maintained',
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
end

---------------------------------------\ yoink /----------------------------------------
function config.yoink()
    vim.g.yoinkMaxItems = 40
    -- :wshada :rshada
    vim.g.yoinkSavePersistently = 1
    vim.g.yoinkSwapClampAtEnds  = 0
    aloha.wim.map.add_maps(
        {'n', '<c-n>', '<plug>(YoinkPostPasteSwapBack)',          { silent = false, noremap = false }},
        {'n', '<c-p>', '<plug>(YoinkPostPasteSwapForward)',       { silent = false, noremap = false }},
        {'n', 'p',     '<plug>(YoinkPaste_p)',                    { silent = false, noremap = false }},
        {'n', 'P',     '<plug>(YoinkPaste_P)',                    { silent = false, noremap = false }},
        {'n', '[y',    '<plug>(YoinkRotateBack)',                 { silent = false, noremap = false }},
        {'n', ']y',    '<plug>(YoinkRotateForward)',              { silent = false, noremap = false }},
        {'n', 'y',     '<plug>(YoinkYankPreserveCursorPosition)', { silent = false, noremap = false }},
        {'x', 'y',     '<plug>(YoinkYankPreserveCursorPosition)', { silent = false, noremap = false }})
end

-----------------------------------\ vim-easymotiom /-----------------------------------
function config.easymotiom()
    vim.g.EasyMotion_do_mapping = 0
    vim.g.EasyMotion_do_shade   = 1
    vim.g.EasyMotion_smartcase  = 1
    aloha.wim.map.add_maps(
        {'n', [['']], ' <Plug>(easymotion-prefix)',       { noremap = false }},
        {'n', [['.]], ' <Plug>(easymotion-repeat)',       { noremap = false }},
        {'n', [['f]], ' <Plug>(easymotion-f)',            { noremap = false }},
        {'n', [['F]], ' <Plug>(easymotion-F)',            { noremap = false }},
        {'n', [['t]], ' <Plug>(easymotion-t)',            { noremap = false }},
        {'n', [['T]], ' <Plug>(easymotion-T)',            { noremap = false }},
        {'n', [['w]], ' <Plug>(easymotion-w)',            { noremap = false }},
        {'n', [['W]], ' <Plug>(easymotion-W)',            { noremap = false }},
        {'n', [['b]], ' <Plug>(easymotion-b)',            { noremap = false }},
        {'n', [['B]], ' <Plug>(easymotion-B)',            { noremap = false }},
        {'n', [['e]], ' <Plug>(easymotion-e)',            { noremap = false }},
        {'n', [['E]], ' <Plug>(easymotion-E)',            { noremap = false }},
        {'n', [['g]], ' <Plug>(easymotion-ge)',           { noremap = false }},
        {'n', [['g]], ' <Plug>(easymotion-gE)',           { noremap = false }},
        {'n', [['j]], ' <Plug>(easymotion-j)',            { noremap = false }},
        {'n', [['k]], ' <Plug>(easymotion-k)',            { noremap = false }},
        {'n', [['n]], ' <Plug>(easymotion-n)',            { noremap = false }},
        {'n', [['N]], ' <Plug>(easymotion-N)',            { noremap = false }},
        {'n', [['s]], ' <Plug>(easymotion-s)',            { noremap = false }},
        {'n', [['2s]], '<Plug>(easymotion-s2)',           { noremap = false }},
        {'n', [['2f]], '<Plug>(easymotion-f2)',           { noremap = false }},
        {'n', [['2F]], '<Plug>(easymotion-F2)',           { noremap = false }},
        {'n', [['2t]], '<Plug>(easymotion-t2)',           { noremap = false }},
        {'n', [['2T]], '<Plug>(easymotion-T2)',           { noremap = false }},
        {'n', [['ns]], '<Plug>(easymotion-sn)',           { noremap = false }},
        {'n', [['nf]], '<Plug>(easymotion-fn)',           { noremap = false }},
        {'n', [['nF]], '<Plug>(easymotion-Fn)',           { noremap = false }},
        {'n', [['nt]], '<Plug>(easymotion-tn)',           { noremap = false }},
        {'n', [['nT]], '<Plug>(easymotion-Tn)',           { noremap = false }},
        {'n', [['wf]], '<Plug>(easymotion-overwin-f)',    { noremap = false }},
        {'n', [['wF]], '<Plug>(easymotion-overwin-f2)',   { noremap = false }},
        {'n', [['wl]], '<Plug>(easymotion-overwin-line)', { noremap = false }},
        {'n', [['ww]], '<Plug>(easymotion-overwin-w)',    { noremap = false }})
end

-----------------------------------\ vim-subversive /-----------------------------------
function config.subversive()
    vim.g.subversiveCurrentTextRegister = 1
    aloha.wim.map.add_maps(
        {'n', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false }},
        {'x', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false }},
        {'x', 'p',                  '<plug>(SubversiveSubstitute)',                 { noremap = false }},
        {'x', 'P',                  '<plug>(SubversiveSubstitute)',                 { noremap = false }},
        {'n', 'ss',                 '<plug>(SubversiveSubstituteLine)',             { noremap = false }},
        {'n', 'S',                  '<plug>(SubversiveSubstituteToEndOfLine)',      { noremap = false }},
        {'n', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false }},
        {'x', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false }},
        {'n', '<leader>ss',         '<plug>(SubversiveSubstituteWordRange)',        { noremap = false }},
        {'n', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false }},
        {'x', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false }},
        {'n', '<leader>crr',        '<plug>(SubversiveSubstituteWordRangeConfirm)', { noremap = false }},
        {'n', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false }},
        {'x', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false }},
        {'n', '<leader><leader>ss', '<plug>(SubversiveSubvertWordRange)',           { noremap = false }})
end

------------------------------------\ clever-f.vim /------------------------------------
function config.clever_f()
    vim.g.clever_f_smart_case              = 1
    vim.g.clever_f_use_migemo              = 1
    vim.g.clever_f_fix_key_direction       = 1
    vim.g.clever_f_chars_match_any_signs   = ''
    vim.g.clever_f_repeat_last_char_inputs = { [[\<CR>]], [[\<Tab>]] }
    vim.g.clever_f_mark_direct             = 1
    vim.g.clever_f_mark_direct_color       = "CleverFDefaultLabel"
end

----------------------------------\ vim-visual-multi /----------------------------------
function config.visual_multi()
    vim.g.VM_leader = { default = ',', visual = ',', buffer = ',' }
    vim.g.VM_default_mappings = 1
end

------------------------------------\ vim-surround /------------------------------------
-- g.surround_{char2nr("d")} = "<div\1id: \r1.*\r id=\"&\"\1>\r</div>"
-- g.surround_insert_tail = "<++>"

-------------------------------------\ auto-pairs /-------------------------------------
function config.auto_pairs()
    vim.g.AutoPairsShortcutToggle   = 'M-o'
    vim.g.AutoPairsShortcutFastWrap = '<M-e>'
    vim.g.AutoPairsShortcutJump     = ''
    vim.g.AutoPairsMapBs            = 1
    vim.g.AutoPairsMapCh            = 0
    vim.g.AutoPairsMapSpace         = 1
    vim.g.AutoPairsMapCR            = 1
end

------------------------------------\ vim-floaterm /------------------------------------
function config.floaterm()
    vim.g.floaterm_keymap_toggle = '<F1>'
    vim.g.floaterm_keymap_prev   = '<F2>'
    vim.g.floaterm_keymap_next   = '<F3>'
    vim.g.floaterm_keymap_new    = '<F4>'
    vim.g.floaterm_gitcommit     = 'floaterm'
    vim.g.floaterm_autoinsert    = 1
    vim.g.floaterm_width         = 0.5
    vim.g.floaterm_height        = 0.5
    vim.g.floaterm_autoclose     = 1
    vim.g.floaterm_title         = 'floaterm: $1/$2'
    vim.g.floaterm_wintype       = 'popup'
    vim.g.floaterm_position      = 'bottomright'
    vim.cmd('hi link FloatermBorder Normal')
end

----------------------------------------\ agit /----------------------------------------
function config.agit()
    vim.g.agit_no_default_mappings = 0
end

------------------------------------\ vim-signify /-------------------------------------
function config.signify()
    vim.g.signify_sign_add               = '▐'
    vim.g.signify_sign_delete_first_line = '▔'
    vim.g.signify_sign_delete            = '▎'
    vim.g.signify_sign_change            = '░'
end

-------------------------------------\ indentLine /-------------------------------------
function config.indentLine()
    vim.g.indent_guides_guide_size  = 1
    vim.g.indent_guides_start_level = 2
    vim.g.indentLine_setColors      = 1
    vim.g.indentLine_color_term     = 239
    vim.g.indentLine_char           = '┆'
    vim.g.indentLine_fileType       = {'python'}
end

--------------------------------------\ rainbow /---------------------------------------
function config.rainbow()
    vim.g.rainbow_active = 1
end

--------------------------------\ thesaurus_query.vim /---------------------------------
function config.thesaurus_query()
    aloha.wim.map.add_map('n', '<Leader>cw', '<Cmd>ThesaurusQueryReplaceCurrentWord<CR>')
    vim.g.tq_map_keys           = 0
    vim.g.tq_openoffice_en_file = "~/.config/nvim/thesaurus/th_en_US_new"
    vim.g.tq_mthesaur_file      = "~/.config/nvim/thesaurus/mthesaur.txt"
    vim.g.tq_cilin_txt_file     = "~/.config/nvim/thesaurus/cilin.txt"
end

-------------------------------------\ hexokinase /-------------------------------------
function config.hexokinase()
    vim.g.Hexokinase_highlighters  = {'backgroundfull'}
    vim.g.Hexokinase_refreshEvents = {'BufWrite', 'BufRead', 'InsertLeave'}
    vim.g.Hexokinase_termDisabled  = 1
end

-------------------------------------\ translator /-------------------------------------
function config.translator()
    aloha.wim.map.add_maps(
        { 'n', '<Leader>t', "<Cmd>TranslateW<Cr>", { silent = false } },
        { 'x', '<Leader>t', "<Cmd>Translate<Cr>", { silent = false } }
    )
    vim.g.translator_history_enable   = 1
    vim.g.translator_window_type      = 'popup'
    vim.cmd("hi link TranslatorBorder Normal")
end

-----------------------------------\ nerdcommenter /------------------------------------
function config.nerdcommenter()
    vim.g.NERDSpaceDelims = 1
    vim.g.NERDCompactSexyComs = 1
    vim.g.NERDDefaultAlign = 'left'
    vim.g.NERDAltDelims_java = 1
    vim.g.NERDCustomDelimiters = {
        c = {
            left = '/**',
            right = '*/'
        }
    }
    vim.g.NERDCommentEmptyLines = 1
    vim.g.NERDTrimTrailingWhitespace = 1
    vim.g.NERDToggleCheckAllLines = 1
end

-------------------------------------\ lspconfig /--------------------------------------
function config.lspconfig()
    local nvim_lsp = require('lspconfig')
    nvim_lsp.clangd.setup{on_attach=require'completion'.on_attach}
    nvim_lsp.pyright.setup{on_attach=require'completion'.on_attach}
    nvim_lsp.sumneko_lua.setup{on_attach=require'completion'.on_attach}

    vim.g.completion_enable_snippet = "UltiSnips"

    aloha.wim.map.add_maps(
        {'i', '<Cr>',      '<Plug>(completion_trigger)', {silent = false, noremap = false}},
        {'i', '<tab>',     '<Plug>(completion_smart_tab)', {silent = false, noremap = false}},
        {'i', '<S-tab>',   '<Plug>(completion_smart_s_tab)', {silent = false, noremap = false}},
        {'n', 'gD',        '<Cmd>lua vim.lsp.buf.declaration()<CR>'},
        {'n', 'gd',        '<Cmd>lua vim.lsp.buf.definition()<CR>'},
        -- {'n', 'K',         '<Cmd>lua vim.lsp.buf.hover()<CR>'},
        {'n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>'},
        -- {'n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>'},
        {'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>'},
        {'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>'},
        {'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>'},
        {'n', '<leader>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>'},
        {'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>'},
        {'n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>'},
        {'n', '<leader>e',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'},
        {'n', '[d',        '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>'},
        {'n', ']d',        '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>'},
        {'n', '<leader>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>'}
    )
end

-- nvim_lsp.ccls.setup {
--     on_attach = on_attach,
--     command = "ccls",
--     args = {},
--     filetypes = { "c", "cpp", "cuda", "objc", "objcpp" },
--     rootPatterns = { ".ccls", ".ccls-root", "compile_commands.json", ".git/", ".hg/" },
--     init_options = {
--         cache = {
--             directory = ".ccls-caches",
--             hierarchicalPath = true,
--             format = "binary",
--             retain = 1
--         },
--         client = {
--             snippetSupport = true
--         },
--         clang = {
--             extraArgs = { "-I ./include" },
--             excludeArgs = {}
--         },
--         completion = {
--             placeholder = true
--         },
--         compilationDatabaseDirectory = "",
--         diagnostics = {
--             onOpen = 0,
--             onChange = 1000,
--             onSave = 0
--         },
--         index = {
--             comments = 2
--         }
--     }
-- }
-- npm i -g pyright
-- require'lspconfig'.pyright.setup{}


--------------------------------------\ airline /---------------------------------------
function config.airline()
    vim.g.airline_symbols = {
        crypt      = '',
        linenr     = '☰',
        linenr     = '㏑',
        maxlinenr  = '¶',
        branch     = '',    -- 
        dirty      = '[+]',  -- ⚡
        paste      = 'Þ',
        spell      = 'Ꞩ',
        notexists  = 'Ɇ',
        whitespace = 'Ξ'
    }
    vim.g.airline_powerline_fonts                      = 1
    vim.g['airline#extensions#tabline#enabled']        = 1
    vim.g['airline#extensions#tabline#buffer_nr_show'] = 1
    vim.g['airline#extensions#tabline#formatter']      = 'default'
    vim.g['airline#extensions#tabline#left_sep']       = '┆'
    vim.g['airline#extensions#tabline#left_alt_sep']   = '┆'
    vim.g['airline#extensions#tabline#right_sep']      = '┆'
    vim.g['airline#extensions#tabline#right_alt_sep']  = '┆'
    vim.g['airline_left_sep']                          = '┆'
    vim.g['airline_left_alt_sep']                      = '┆'
    vim.g['airline_right_sep']                         = '┆'
    vim.g['airline_right_alt_sep']                     = '┆'
end

---------------------------------\ markdown-previwew /----------------------------------
function config.markdown_preview()
    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_refresh_slow = 0
    vim.g.mkdp_command_for_global = 0
    vim.g.mkdp_open_to_the_world = 0
    vim.g.mkdp_open_ip = ''
    vim.g.mkdp_browser = 'google-chrome-stable'
    vim.g.mkdp_echo_preview_url = 0
    vim.g.mkdp_browserfunc = ''
    vim.g.mkdp_preview_options = {
        mkit                = {},
        katex               = {},
        uml                 = {},
        maid                = {},
        disable_sync_scroll = 0,
        sync_scroll_type    = 'middle',
        hide_yaml_meta      = 1,
        sequence_diagrams   = {},
        flowchart_diagrams  = {},
        content_editable    = false
    }
    vim.g.mkdp_markdown_css = ''
    vim.g.mkdp_highlight_css = ''
    vim.g.mkdp_port = ''
    vim.g.mkdp_page_title = '「${name}」'
    vim.g.mkdp_filetypes = {'markdown', 'vimwiki'}
end

----------------------------------\ vim-markdown-toc /----------------------------------
function config.markdown_toc()
    vim.g.vmt_cycle_list_item_markers = 1
    vim.g.vmt_fence_text              = 'TOC'
    vim.g.vmt_fence_closing_text      = '/TOC'
    vim.g.vmt_cycle_list_item_markers = 1
end

---------------------------------------\ vimtex /---------------------------------------
function config.vimtex()
    vim.g.tex_flavor = 'latex'
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_compiler_progname = 'nvr'
    vim.g.vimtex_complete_close_braces = 1
    vim.g.vimtex_cache_root = '~/.config/nvim/.cache/vimtex'
    vim.g.vimtex_mappings_enabled = 1
    vim.g.tex_conceal='abdmg'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_compiler_latexmk = {
        build_dir  = '',
        callback   = 1,
        continuous = 1,
        executable = 'latexmk',
        hooks      = {},
        options    = {
            '-verbose',
            '-file-line-error',
            '-synctex=1',
            '-interaction=nonstopmode',
        },
    }
    vim.g.vimtex_compiler_latexmk_engines = {
        _        = '-xelatex',
        pdflatex = '-pdf',
        dvipdfex = '-pdfdvi',
        lualatex = '-lualatex',
        xelatex  = '-xelatex',
        -- 'context (pdftex)' : '-pdf -pdflatex=texexec',
        -- 'context (luatex)' : '-pdf -pdflatex=context',
        -- 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    }
    vim.g.vimtex_compiler_latexrun_engines = {
        _         = 'xelatex',
        pdflatex  = 'pdflatex',
        lualatex  = 'lualatex',
        xelatex   = 'xelatex',
    }
end

--------------------------------------\ vimwiki /---------------------------------------
-- g.vimwiki_list = {
--     {
--         path                = '~/Shared/vimwiki/',
--         diary_index         = 'diary',
--         diary_header        = 'Diary',
--         diary_rel_path      = 'diary/',
--         syntax              = 'markdown',
--         ext                 = '.md',
--         links_space_char    = ' ',
--         makhi               = 1,
--         auto_tags           = 1,
--         auto_diary_index    = 0,
--         auto_generate_links = 1,
--         auto_generate_tags  = 1,
--         exclude_files       = {'**/README.md'},
--     },
--     {
--         path                = '~/vimwiki_origin/',
--         path_html           = '~/vimwiki_origin/export/',
--         syntax              = 'default',
--         ext                 = '.wiki',
--         links_space_char    = ' ',
--         auto_toc            = 1,
--         auto_tags           = 1,
--         auto_diary_index    = 0,
--         auto_generate_links = 1,
--         auto_generate_tags  = 1,
--         exclude_files       = {'**/README.md'},
--         }
-- }
-- g.vimwiki_conceal_pre = 1
-- g.vimwiki_use_calendar = 1
-- g.vimwiki_diary_months = {
--     ['1']  = '一月 January',
--     ['2']  = '二月 February',
--     ['3']  = '三月 March',
--     ['4']  = '四月 April',
--     ['5']  = '五月 May',
--     ['6']  = '六月 June',
--     ['7']  = '七月 July',
--     ['8']  = '八月 August',
--     ['9']  = '九月 September',
--     ['10'] = '十月 October',
--     ['11'] = '十一月 November',
--     ['12'] = '十二月December',
-- }
-- g.vimwiki_hl_headers            = 1
-- g.vimwiki_hl_cb_checked         = 2
-- g.vimwiki_folding               = 'expr'
-- g.vimwiki_markdown_link_ext     = 1
-- g.vimwiki_table_reduce_last_col = 0
-- g.vimwiki_dir_link              = 'main'
-- g.vimwiki_toc_header            = 'Table of Contents'
-- g.vimwiki_toc_header_level      = 2
-- g.vimwiki_html_header_numbering = 2
-- g.vimwiki_links_header          = 'Generated Links'
-- g.vimwiki_links_header_level    = 2
-- g.vimwiki_tags_header           = 'Generated Tags'
-- g.vimwiki_tags_header_level     = 2
-- g.vimwiki_auto_header           = 1
-- g.vimwiki_markdown_header_style = 1
-- g.vimwiki_table_auto_fmt        = 1
-- g.vimwiki_key_mappings = {
--     table_format = 1,
--     table_mappings = 1,
-- }
-- g.vimwiki_url_maxsave = 0
-- g.vimwiki_global_ext = 1
-- g.vimwiki_ext2syntax = {}
-- g.vimwiki_ext2syntax['.md']       = 'markdown'
-- g.vimwiki_ext2syntax['.mkdn']     = 'markdown'
-- g.vimwiki_ext2syntax['.mdwn']     = 'markdown'
-- g.vimwiki_ext2syntax['.mdown']    = 'markdown'
-- g.vimwiki_ext2syntax['.markdown'] = 'markdown'
-- g.vimwiki_ext2syntax['.mw']       = 'media'
--

-- auto_tags:          automatically update the tags metadata when current wiki page is saved
-- auto_diary_index:   automatically update the diary index when opened.
-- auto_genrate_links: automatically update generated links when the current wiki page is saved.
-- auto_genrate_tags:  automatically update generated tags when the current wiki page is saved.

---------------------------------------\ zeavim /---------------------------------------
function config.zeavim()
    vim.g.zv_file_types = {
        cpp = "c,cpp,qt,glib,opencv",
        python = "python,pandas,numpy",
    }
end

---------------------------------------\ rooter /---------------------------------------
function config.rooter()
    vim.g.rooter_patterns = { '.rooter', '.git' }
    vim.g.rooter_silent_chdir = 1
end

-------------------------------------\ galaxyline /-------------------------------------
function config.galaxyline()
    local gl = require('galaxyline')
    local gls = gl.section
    local extension = require('galaxyline.provider_extensions')

    gl.short_line_list = {
        'LuaTree',
        'vista',
        'dbui',
        'startify',
        'term',
        'nerdtree',
        'fugitive',
        'fugitiveblame',
        'plug'
    }

    -- VistaPlugin = extension.vista_nearest

    local colors = {
        bg = '#282c34',
        line_bg = '#353644',
        fg = '#8FBCBB',
        fg_green = '#65a380',

        yellow = '#fabd2f',
        cyan = '#008080',
        darkblue = '#081633',
        green = '#afd700',
        orange = '#FF8800',
        purple = '#5d4d7a',
        magenta = '#c678dd',
        blue = '#51afef';
        red = '#ec5f67'
    }

    local function lsp_status(status)
        shorter_stat = ''
        for match in string.gmatch(status, "[^%s]+")  do
            err_warn = string.find(match, "^[WE]%d+", 0)
            if not err_warn then
                shorter_stat = shorter_stat .. ' ' .. match
            end
        end
        return shorter_stat
    end


    local function get_coc_lsp()
      local status = vim.fn['coc#status']()
      if not status or status == '' then
          return ''
      end
      return lsp_status(status)
    end

    function get_diagnostic_info()
      if vim.fn.exists('*coc#rpc#start_server') == 1 then
        return get_coc_lsp()
        end
      return ''
    end

    local function get_current_func()
      local has_func, func_name = pcall(vim.fn.nvim_buf_get_var,0,'coc_current_function')
      if not has_func then return end
          return func_name
      end

    function get_function_info()
      if vim.fn.exists('*coc#rpc#start_server') == 1 then
        return get_current_func()
        end
      return ''
    end

    local function trailing_whitespace()
        local trail = vim.fn.search("\\s$", "nw")
        if trail ~= 0 then
            return ' '
        else
            return nil
        end
    end

    CocStatus = get_diagnostic_info
    CocFunc = get_current_func
    TrailingWhiteSpace = trailing_whitespace

    function has_file_type()
        local f_type = vim.bo.filetype
        if not f_type or f_type == '' then
            return false
        end
        return true
    end

    local buffer_not_empty = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
    end

    gls.left[1] = {
      FirstElement = {
        provider = function() return ' ' end,
        highlight = {colors.blue,colors.line_bg}
      },
    }
    gls.left[2] = {
      ViMode = {
        provider = function()
          -- auto change color according the vim mode
          local alias = {
              n = 'NORMAL',
              i = 'INSERT',
              c= 'COMMAND',
              V= 'VISUAL',
              [''] = 'VISUAL',
              v ='VISUAL',
              c  = 'COMMAND-LINE',
              ['r?'] = ':CONFIRM',
              rm = '--MORE',
              R  = 'REPLACE',
              Rv = 'VIRTUAL',
              s  = 'SELECT',
              S  = 'SELECT',
              ['r']  = 'HIT-ENTER',
              [''] = 'SELECT',
              t  = 'TERMINAL',
              ['!']  = 'SHELL',
          }
          local mode_color = {
              n = colors.green,
              i = colors.blue,v=colors.magenta,[''] = colors.blue,V=colors.blue,
              c = colors.red,no = colors.magenta,s = colors.orange,S=colors.orange,
              [''] = colors.orange,ic = colors.yellow,R = colors.purple,Rv = colors.purple,
              cv = colors.red,ce=colors.red, r = colors.cyan,rm = colors.cyan, ['r?'] = colors.cyan,
              ['!']  = colors.green,t = colors.green,
              c  = colors.purple,
              ['r?'] = colors.red,
              ['r']  = colors.red,
              rm = colors.red,
              R  = colors.yellow,
              Rv = colors.magenta,
          }
          local vim_mode = vim.fn.mode()
          vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color[vim_mode])
          return alias[vim_mode] .. '   '
        end,
        highlight = {colors.red,colors.line_bg,'bold'},
      },
    }
    gls.left[3] ={
      FileIcon = {
        provider = 'FileIcon',
        condition = buffer_not_empty,
        highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.line_bg},
      },
    }
    gls.left[4] = {
      FileName = {
        provider = {'FileName','FileSize'},
        condition = buffer_not_empty,
        highlight = {colors.fg,colors.line_bg,'bold'}
      }
    }

    gls.left[5] = {
      GitIcon = {
        provider = function() return '  ' end,
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {colors.orange,colors.line_bg},
      }
    }
    gls.left[6] = {
      GitBranch = {
        provider = 'GitBranch',
        condition = require('galaxyline.provider_vcs').check_git_workspace,
        highlight = {'#8FBCBB',colors.line_bg,'bold'},
      }
    }

    local checkwidth = function()
      local squeeze_width  = vim.fn.winwidth(0) / 2
      if squeeze_width > 40 then
        return true
      end
      return false
    end

    gls.left[7] = {
      DiffAdd = {
        provider = 'DiffAdd',
        condition = checkwidth,
        icon = ' ',
        highlight = {colors.green,colors.line_bg},
      }
    }
    gls.left[8] = {
      DiffModified = {
        provider = 'DiffModified',
        condition = checkwidth,
        icon = ' ',
        highlight = {colors.orange,colors.line_bg},
      }
    }
    gls.left[9] = {
      DiffRemove = {
        provider = 'DiffRemove',
        condition = checkwidth,
        icon = ' ',
        highlight = {colors.red,colors.line_bg},
      }
    }
    gls.left[10] = {
      LeftEnd = {
        provider = function() return '┆' end,
        separator = '┆',
        separator_highlight = {colors.bg,colors.line_bg},
        highlight = {colors.line_bg,colors.line_bg}
      }
    }

    gls.left[11] = {
        TrailingWhiteSpace = {
         provider = TrailingWhiteSpace,
         icon = '  ',
         highlight = {colors.yellow,colors.bg},
        }
    }

    gls.left[12] = {
      DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        highlight = {colors.red,colors.bg}
      }
    }
    gls.left[13] = {
      Space = {
        provider = function () return ' ' end
      }
    }
    gls.left[14] = {
      DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = '  ',
        highlight = {colors.yellow,colors.bg},
      }
    }


    gls.left[15] = {
        CocStatus = {
         provider = CocStatus,
         highlight = {colors.green,colors.bg},
         icon = '  🗱'
        }
    }

    gls.left[16] = {
      CocFunc = {
        provider = CocFunc,
        icon = '  λ ',
        highlight = {colors.yellow,colors.bg},
      }
    }

    gls.right[1]= {
      FileFormat = {
        provider = 'FileFormat',
        separator = '┆ ',
        separator_highlight = {colors.bg,colors.line_bg},
        highlight = {colors.fg,colors.line_bg,'bold'},
      }
    }
    gls.right[4] = {
      LineInfo = {
        provider = 'LineColumn',
        separator = ' | ',
        separator_highlight = {colors.blue,colors.line_bg},
        highlight = {colors.fg,colors.line_bg},
      },
    }
    gls.right[5] = {
      PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = {colors.line_bg,colors.line_bg},
        highlight = {colors.cyan,colors.darkblue,'bold'},
      }
    }

    -- gls.right[4] = {
    --   ScrollBar = {
    --     provider = 'ScrollBar',
    --     highlight = {colors.blue,colors.purple},
    --   }
    -- }

    -- gls.right[3] = {
    --   Vista = {
    --     provider = VistaPlugin,
    --     separator = ' ',
    --     separator_highlight = {colors.bg,colors.line_bg},
    --     highlight = {colors.fg,colors.line_bg,'bold'},
    --   }
    -- }

    gls.short_line_left[1] = {
      BufferType = {
        provider = 'FileTypeName',
        separator = '┆',
        condition = has_file_type,
        separator_highlight = {colors.purple,colors.bg},
        highlight = {colors.fg,colors.purple}
      }
    }


    gls.short_line_right[1] = {
      BufferIcon = {
        provider= 'BufferIcon',
        separator = '┆',
        condition = has_file_type,
        separator_highlight = {colors.purple,colors.bg},
        highlight = {colors.fg,colors.purple}
      }
    }
end

------------------------------------\ web_devicons /------------------------------------
-- function config.web_devicons()
--     require'nvim-web-devicons'.setup {
--      -- your personnal icons can go here (to override)
--      -- DevIcon will be appended to `name`
--      override = {
--       zsh = {
--         icon = "",
--         color = "#428850",
--         name = "Zsh"
--       }
--      };
--      -- globally enable default icons (default to false)
--      -- will get overriden by `get_icons` option
--      default = true;
--     }
-- end


----------------------------------------------------------------------------------------
--               \ Append Configurations to Each Items in Plugin List /               --
----------------------------------------------------------------------------------------

-- Normaliza Rpo Name
-- eg. vim-markdown-preview.nvim ==> markdown_preview
function _G.aloha.utils.normalize(str)
    local _,b,e = nil
    str = str:match('.*/(.*)$')

    _,b = str:find('n?vim%-.')
    -- 1 if didn't find
    b = b or 1

    -- nil if didn't find
    e,_ = str:find('.[%.%-]n?vim')

    -- replace - with _
    return str:sub(b, e):gsub('-', '_')
end

function config:list_show()
    for _,package in ipairs(_G.aloha.plugin.list) do
        local normalized = _G.aloha.utils.normalize(package[1])
        print(normalized)
    end
end

function config:init()
    for _,package in ipairs(_G.aloha.plugin.list) do
        local normalized = _G.aloha.utils.normalize(package[1])
        if type(config[normalized]) == 'function' then
            config[normalized]()
        end
        -- package.config = config[normal(package[1])]
    end
    return self
end

return _G.aloha.plugin.config
