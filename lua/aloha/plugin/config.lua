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
    vim.g.vista_ctags_project_opts = '--sort=no -R -o .tags'
    vim.g.vista_executive_for = {
        vimwiki  = 'markdown',
        pandoc   = 'markdown',
        markdown = 'toc',
    }
    vim.g.vista_enable_markdown_extension    = 1
    g['airline#extensions#fzf#enabled']  = 1
    vim.g.vista_enable_markdown_extension    = 1
    vim.g.vista_fzf_preview                  = {'right:50%'}
    vim.g.vista_sidebar_width                = 50
    vim.g.vista_fold_toggle_icons            = {'▾', '▸'}
    vim.g.vista_icon_indent                  = {"└─▸ ", "├─▸ "}
    vim.g.vista_cursor_delay                 = 200
    vim.g.vista_update_on_text_changed       = 1
    vim.g.vista_update_on_text_changed_delay = 2000
    vim.g.vista_close_on_jump                = 1
    vim.g.vista_stay_on_open                 = 1
    vim.g.vista_blink                        = {0, 0}
    vim.g.vista_top_level_blink              = {0, 0}
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
config.treesitter = function()
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

    -----------------------------------\ vim-easymotiom /-----------------------------------
    vim.g.EasyMotion_do_mapping = 0
    vim.g.EasyMotion_do_shade = 1
    vim.g.EasyMotion_smartcase = 1
    aloha.wim.map.add_maps(
        {'n', [[\']], ' <Plug>(easymotion-prefix)',       { noremap = false }},
        {'n', [[\.]], ' <Plug>(easymotion-repeat)',       { noremap = false }},
        {'n', [[\f]], ' <Plug>(easymotion-f)',            { noremap = false }},
        {'n', [[\F]], ' <Plug>(easymotion-F)',            { noremap = false }},
        {'n', [[\t]], ' <Plug>(easymotion-t)',            { noremap = false }},
        {'n', [[\T]], ' <Plug>(easymotion-T)',            { noremap = false }},
        {'n', [[\w]], ' <Plug>(easymotion-w)',            { noremap = false }},
        {'n', [[\W]], ' <Plug>(easymotion-W)',            { noremap = false }},
        {'n', [[\b]], ' <Plug>(easymotion-b)',            { noremap = false }},
        {'n', [[\B]], ' <Plug>(easymotion-B)',            { noremap = false }},
        {'n', [[\e]], ' <Plug>(easymotion-e)',            { noremap = false }},
        {'n', [[\E]], ' <Plug>(easymotion-E)',            { noremap = false }},
        {'n', [[\g]], ' <Plug>(easymotion-ge)',           { noremap = false }},
        {'n', [[\g]], ' <Plug>(easymotion-gE)',           { noremap = false }},
        {'n', [[\j]], ' <Plug>(easymotion-j)',            { noremap = false }},
        {'n', [[\k]], ' <Plug>(easymotion-k)',            { noremap = false }},
        {'n', [[\n]], ' <Plug>(easymotion-n)',            { noremap = false }},
        {'n', [[\N]], ' <Plug>(easymotion-N)',            { noremap = false }},
        {'n', [[\s]], ' <Plug>(easymotion-s)',            { noremap = false }},
        {'n', [[\2s]], '<Plug>(easymotion-s2)',           { noremap = false }},
        {'n', [[\2f]], '<Plug>(easymotion-f2)',           { noremap = false }},
        {'n', [[\2F]], '<Plug>(easymotion-F2)',           { noremap = false }},
        {'n', [[\2t]], '<Plug>(easymotion-t2)',           { noremap = false }},
        {'n', [[\2T]], '<Plug>(easymotion-T2)',           { noremap = false }},
        {'n', [[\ns]], '<Plug>(easymotion-sn)',           { noremap = false }},
        {'n', [[\nf]], '<Plug>(easymotion-fn)',           { noremap = false }},
        {'n', [[\nF]], '<Plug>(easymotion-Fn)',           { noremap = false }},
        {'n', [[\nt]], '<Plug>(easymotion-tn)',           { noremap = false }},
        {'n', [[\nT]], '<Plug>(easymotion-Tn)',           { noremap = false }},
        {'n', [[\wf]], '<Plug>(easymotion-overwin-f)',    { noremap = false }},
        {'n', [[\wF]], '<Plug>(easymotion-overwin-f2)',   { noremap = false }},
        {'n', [[\wl]], '<Plug>(easymotion-overwin-line)', { noremap = false }},
        {'n', [[\ww]], '<Plug>(easymotion-overwin-w)',    { noremap = false }})
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
    g.floaterm_keymap_toggle = '<F1>'
    g.floaterm_keymap_prev   = '<F2>'
    g.floaterm_keymap_next   = '<F3>'
    g.floaterm_keymap_new    = '<F4>'
    g.floaterm_gitcommit     = 'floaterm'
    g.floaterm_autoinsert    = 1
    g.floaterm_width         = 0.5
    g.floaterm_height        = 0.5
    g.floaterm_autoclose     = 1
    g.floaterm_title         = 'floaterm: $1/$2'
    g.floaterm_wintype       = 'popup'
    g.floaterm_position      = 'bottomright'
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
end

------------------------------------\ web_devicons /------------------------------------
function config.web_devicons()
    require'nvim-web-devicons'.setup {
	 -- your personnal icons can go here (to override)
	 -- DevIcon will be appended to `name`
	 override = {
	  zsh = {
	    icon = "",
	    color = "#428850",
	    name = "Zsh"
	  }
	 };
	 -- globally enable default icons (default to false)
	 -- will get overriden by `get_icons` option
	 default = true;
	}
end

-----------------------------------\ nerdcommenter /------------------------------------
g.NERDSpaceDelims = 1
g.NERDCompactSexyComs = 1
g.NERDDefaultAlign = 'left'
g.NERDAltDelims_java = 1
g.NERDCustomDelimiters = {
    c = {
        left = '/**',
        right = '*/'
    }
}
g.NERDCommentEmptyLines = 1
g.NERDTrimTrailingWhitespace = 1
g.NERDToggleCheckAllLines = 1

-------------------------------------\ lspconfig /--------------------------------------
local nvim_lsp = require('lspconfig')
nvim_lsp.clangd.setup{on_attach=require'completion'.on_attach}
nvim_lsp.pyright.setup{on_attach=require'completion'.on_attach}
nvim_lsp.sumneko_lua.setup{on_attach=require'completion'.on_attach}

add_maps(
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

----------------------------------------------------------------------------------------
--               \ Append Configurations to Each Items in Plugin List /               --
----------------------------------------------------------------------------------------

-- Normaliza Rpo Name
-- eg. vim-markdown-preview.nvim ==> markdown_preview
function _G.aloha.utils.normal(str)
    local _,b,e = nil
    str = str:match('.*/(.*)$')

    _,b = str:find('n?vim%-.')
    -- 1 if didn't find
    b = b or 1

    -- nil if didn't find
    e,_ = str:find('.[%.%-]n?vim')

    return str:sub(b, e):gsub('-', '_')
end

function config:list_show()
    for _,package in ipairs(_G.aloha.plugin.list) do
        local normalized = _G.aloha.utils.normal(package[1])
        print(normalized)
	end
end

function config:init()
    for _,package in ipairs(_G.aloha.plugin.list) do
        local normalized = _G.aloha.utils.normal(package[1])
        if type(config[normalized]) == 'function' then
            config[normalized]()
        end
        -- package.config = config[normal(package[1])]
    end
    return self
end

return _G.aloha.plugin.config
