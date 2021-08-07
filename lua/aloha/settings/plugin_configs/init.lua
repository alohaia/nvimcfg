local configs = {}

configs['glepnir/dashboard-nvim'] = function()
    -- TODO
end

configs['glepnir/galaxyline.nvim'] = function()
    require('aloha.settings.plugin_configs.galaxyline')
end

configs['lukas-reineke/indent-blankline.nvim'] = function()
    require('indent_blankline').setup {
        char = '│',
        -- char_highlight_list = {'Error', 'Function'},
        space_char = ' ',
        use_treesitter = true,
        show_first_indent_level = false,
        -- show_end_of_line = false,
        show_current_context = true,
        filetype_exclude = {
            "startify", "dashboard", "dotooagenda", "log", "fugitive", "gitcommit",
            "packer", "vimwiki", "markdown", "json", "txt", "vista", "help", "todoist",
            "NvimTree", "peekaboo", "git", "TelescopePrompt", "undotree", "flutterToolsOutline",
            "" -- for all buffers without a file type
        },
        buftype_exclude = {"terminal", "nofile"},
        context_patterns = {
            "class", "function", "method", "block", "list_literal",
            "selector", "^if", "^table", "if_statement", "while", "for"
        },
    }
    -- vim.g.indent_blankline_show_current_context = 1
    -- vim.cmd[[au VimEnter * highlight IndentBlanklineChar guifg=#00FF00 gui=nocombine]]
    -- vim.cmd[[au VimEnter * highlight IndentBlanklineSpaceChar guifg=#00FF00 gui=nocombine]]
    -- vim.cmd[[au VimEnter * highlight IndentBlanklineSpaceCharBlankline guifg=#00FF00 gui=nocombine]]
    -- vim.cmd[[au VimEnter * highlight IndentBlanklineContextChar guifg=#00FF00 gui=nocombine]]
    --   vim.g.indent_blankline_show_trailing_blankline_indent = false
    --   vim.g.indent_blankline_show_current_context = true
    -- because lazy load indent-blankline so need readd this autocmd
    -- vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
end

configs['norcalli/nvim-colorizer.lua'] = function()
    require 'colorizer'.setup({
        '*',
        ['css'] = { css = true },
    }, {
        name = false,
    })
end

configs['akinsho/nvim-bufferline.lua'] = function()
    require('bufferline').setup{
        options = {
          modified_icon = '✥',
          buffer_close_icon = '',
          mappings = true,
          always_show_bufferline = false,
        }
    }
end

configs['kyazdani42/nvim-tree.lua'] = function()
    -- see :h nvim-tree-events
    require("nvim-tree.events").on_nvim_tree_ready(function()
        -- vim.cmd("NvimTreeRefresh")
        vim.api.nvim_set_keymap('n', '<leader>nt', '<Cmd>NvimTreeToggle<CR>', {noremap = true})
    end)
    vim.g.nvim_tree_ignore = { '.git', 'node_modules' }
    vim.g.nvim_tree_gitignore = 1
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_hide_dotfiles = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_highlight_opened_files = 3
    vim.g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}
    vim.g.nvim_tree_add_trailing = 1
    vim.g.nvim_tree_lsp_diagnostics = 1
    vim.g.nvim_tree_update_cwd = 1
    vim.g.nvim_tree_icons = {
        default =  '',
        symlink =  '',
        git = {
            unstaged = "✚",
            staged =  "✚",
            unmerged =  "≠",
            renamed =  "≫",
            untracked = "★",
        },
    }
    vim.g.nvim_tree_special_files = {
        ["Cargo.toml"] = true,
        Makefile = true,
        ["README.md"] = true,
        ["readme.md"] = true,
    }
    -- bindings see :h g:nvim_tree_bindings
end

configs['lewis6991/gitsigns.nvim'] = function()
    if not vim.g.pack_plenary_loaded then
        vim.cmd [[packadd plenary.nvim]]
        vim.g.pack_plenary_loaded = true
    end
    require('gitsigns').setup {
        signs = {
            add = {hl = 'GitGutterAdd', text = '▋'},
            change = {hl = 'GitGutterChange',text= '▋'},
            delete = {hl= 'GitGutterDelete', text = '▋'},
            topdelete = {hl ='GitGutterDeleteChange',text = '▔'},
            changedelete = {hl = 'GitGutterChange', text = '▎'},
        },
        keymaps = {
           -- Default keymap options
           noremap = true,
           buffer = true,

           ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
           ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

           ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
           ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
           ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
           ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
           ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

           -- Text objects
           ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
           ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        },
    }
end

configs['neovim/nvim-lspconfig'] = function()
    require('aloha.settings.plugin_configs.lspconfig')
end

configs['hrsh7th/nvim-compe'] = function()
    require'compe'.setup {
        enabled = true;
        debug = false;
        min_length = 1;
        preselect = 'always';
        allow_prefix_unmatch = false;
        source = {
            path = true;
            buffer = true;
            calc = true;
            vsnip = true;
            nvim_lsp = true;
            nvim_lua = true;
            spell = true;
            tags = true;
            snippets_nvim = false;
        };
    }
end

configs['hrsh7th/vim-vsnip'] = function()
    vim.g.vsnip_snippet_dir = vim.env.HOME .. '/.config/nvim/snippets'
end

configs['nvim-telescope/telescope.nvim'] = function()
    if not vim.g.pack_plenary_loaded then
        vim.cmd [[packadd plenary.nvim]]
        vim.g.pack_plenary_loaded = true
    end
    if not vim.g.pack_popup_loaded then
        vim.cmd [[packadd popup.nvim]]
        vim.g.pack_popup_loaded = true
    end
    if not vim.g.pack_telescope_fzy_native_loaded then
        vim.cmd [[packadd telescope-fzy-native.nvim]]
        vim.g.pack_telescope_fzy_native_loaded = true
    end
    require('telescope').setup{
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--line-number',
                '--column',
                '--smart-case'
            },
            prompt_prefix = "🔭 ",
            selection_caret = " ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "descending",
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    mirror = false,
                },
                vertical = {
                    mirror = false,
                },
            },
            file_sorter =  require'telescope.sorters'.get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
            winblend = 0,
            border = {},
            borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
            color_devicons = true,
            use_less = true,
            path_display = {},
            set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        },
    }
    require('telescope').load_extension('fzy_native')
    -- require'telescope'.load_extension('dotfiles')
    -- require'telescope'.load_extension('gosource')
end

configs['RRethy/vim-illuminate'] = function()
    vim.cmd[[autocmd VimEnter * hi illuminatedWord guibg=LightGrey]]
    -- vim.cmd[[autocmd VimEnter * hi illuminatedCurWord gui=bold]]
    vim.g.Illuminate_highlightUnderCursor = 0
    vim.g.Illuminate_insert_mode_highlight = true
    vim.g.Illuminate_ftblacklist = {'dashboard', 'NvimTree'}
    -- vim.g.Illuminate_ftwhitelist = {}
	-- vim.api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
	-- vim.api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
end

configs['rhysd/clever-f.vim'] = function()
    vim.g.clever_f_smart_case              = 1
    vim.g.clever_f_use_migemo              = 0
    vim.g.clever_f_fix_key_direction       = 1
    vim.g.clever_f_chars_match_any_signs   = ''
    vim.g.clever_f_repeat_last_char_inputs = { [[\<CR>]], [[\<Tab>]] }
    vim.g.clever_f_mark_direct             = 1
    vim.g.clever_f_mark_direct_color       = "CleverFDefaultLabel"
end


configs['nvim-treesitter/nvim-treesitter'] = function()
    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
    require'nvim-treesitter.configs'.setup {
        ensure_installed = 'maintained',
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",
                node_incremental = "grn",
                scope_incremental = "grc",
                node_decremental = "grm",
            },
        },
        highlight = {
            enable = true,
            custom_captures = {
                -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
                -- ["foo.bar"] = "Identifier",
            },
        },
        indent = {
            enable = true,
        },
        textobjects = {
            select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
          },
        },
    }
end

configs['brooth/far.vim'] = function()
    vim.g['far#source'] = 'rgnvim'
    vim.g['far#enable_undo'] = 1
    vim.g['far#mapping'] = {
        stoggle_expand_all = 'zt',
        toggle_expand_all  = 'zA',
        expand_all         = 'zr',
        collapse_all       = 'zm',
    }
end

configs['liuchengxu/vista.vim'] = function()
        vim.api.nvim_set_keymap('n', '<leader>vt', '<Cmd>Vista<Cr>', {noremap = true})
        vim.api.nvim_set_keymap('n', ',T', '<Cmd>Vista finder<Cr>', {noremap = true})
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
        vim.g.vista_close_on_jump                = 1
        vim.g.vista_stay_on_open                 = 1
        vim.g.vista_blink                        = {0, 0}
        vim.g.vista_top_level_blink              = {0, 0}
        vim.g.vista_highlight_whole_line         = 1
        -- g['vista#renderer#icons'] = {
        --     function = "",
        --     variable = "",
        -- }
end

configs['mhinz/vim-startify'] = function()
    vim.g.startify_change_to_vcs_dir   = 1
    vim.g.startify_change_to_dir       = 0
    vim.g.startify_fortune_use_unicode = 0
    vim.g.startify_padding_left        = 3
    vim.g.startify_session_persistence = 0
    vim.g.startify_session_autoload    = 1
    vim.g.startify_skiplist            = {
        [[pack/packer/start/vimdoc-cn/doc/.*\.cnx]]
    }
    vim.g.startify_files_number = 10
    vim.g.startify_bookmarks = {
        -- '~/.config/nvim/plugins/vimspector/docs/schema/vimspector.schema.json',
        -- '~/.config/nvim/plugins/vimspector/docs/schema/gadgets.schema.json',
    }
    vim.g.startify_commands = {
        -- { t = {'Press t to open coc-explorer.',      'CocCommand explorer'}},
        -- { w = {"Open Index page for Vimwiki.",       'VimwikiIndex'}},
        -- { d = {"Open Index page for Vimwiki Diary.", 'VimwikiDiaryIndex'}},
    }
    vim.g.startify_lists = {
        { type = 'dir',       header = {'   PWD: '..vim.fn.getcwd()}},
        { type = 'commands',  header = {'   Commands'}              },
        { type = 'files',     header = {'   Recent Opened Files'}   },
        { type = 'sessions',  header = {'   Sessions'}              },
        { type = 'bookmarks', header = {'   Bookmarks'}             },
    }
end

configs['preservim/nerdcommenter'] = function()
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

configs['mbbill/undotree'] = function()
    vim.api.nvim_set_keymap('n', '<leader>ut', '<Cmd>UndotreeToggle<CR>', {noremap = true})
    vim.g.undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
    vim.cmd[[
        function g:Undotree_CustomMap()
            nnoremap <buffer> n <plug>UndotreeNextState
            nnoremap <buffer> p <plug>UndotreePreviousState
            nnoremap <buffer> N 5<plug>UndotreeNextState
            nnoremap <buffer> P 5<plug>UndotreePreviousState
        endfunc
    ]]
    vim.g.undotree_CustomDiffpanelCmd = 'botright 10 new'
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_TreeNodeShape      = '⚑'
    vim.g.undotree_RelativeTimestamp  = 0
    vim.g.undotree_HelpLine           = 0
end

configs['SirVer/ultisnips'] = function()
    vim.g.UltiSnipsEditSplit="vertical"
    vim.g.UltiSnipsRemoveSelectModeMappings = 0
    vim.g.UltiSnipsExpandTrigger="<C-Space>"
    vim.g.UltiSnipsJumpForwardTrigger="<C-j>"
    vim.g.UltiSnipsJumpBackwardTrigger="<C-k>"
end

configs['alohaia/vim-hexowiki'] = function()
    vim.g.hexowiki_home = '~/blog/source/_posts/'
    vim.g.hexowiki_follow_after_create = 0
end

configs['dkarter/bullets.vim'] = function()
    vim.g.bullets_enabled_file_types = { "markdown", "text" }
    vim.g.bullets_enable_in_empty_buffers = 1
    vim.g.bullets_checkbox_markers = " X"
    vim.g.bullets_mapping_leader = ""
    vim.g.bullets_delete_last_bullet_if_empty = 1
    vim.g.bullets_outline_levels = {'ROM'}
    vim.api.nvim_set_keymap("i", "<C-a>", "<Cmd>ToggleCheckbox<CR>", {noremap = true})
    vim.api.nvim_set_keymap("n", "<leader>sn", "<Cmd>RenumberList<CR>", {noremap = true})
    vim.api.nvim_set_keymap("x", "<leader>sn", "<Cmd>RenumberSelection<CR>", {noremap = true})
end

configs['dhruvasagar/vim-table-mode'] = function()
    vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>TableModeToggle<cr>", {noremap = true})
    vim.g.table_mode_corner_corner="|"
    vim.g.table_mode_align_char=":"
    vim.g.table_mode_header_fillchar="-"
    vim.g.table_mode_delimiter = ','
end


configs['svermeulen/vim-subversive'] = function()
    vim.g.subversiveCurrentTextRegister = 1
    vim.api.nvim_set_keymap('n', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    vim.api.nvim_set_keymap('x', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    vim.api.nvim_set_keymap('x', 'p',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    vim.api.nvim_set_keymap('x', 'P',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    vim.api.nvim_set_keymap('n', 'ss',                 '<plug>(SubversiveSubstituteLine)',             { noremap = false })
    vim.api.nvim_set_keymap('n', 'S',                  '<plug>(SubversiveSubstituteToEndOfLine)',      { noremap = false })
    vim.api.nvim_set_keymap('n', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false })
    vim.api.nvim_set_keymap('x', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false })
    vim.api.nvim_set_keymap('n', '<leader>ss',         '<plug>(SubversiveSubstituteWordRange)',        { noremap = false })
    vim.api.nvim_set_keymap('n', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false })
    vim.api.nvim_set_keymap('x', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false })
    vim.api.nvim_set_keymap('n', '<leader>crr',        '<plug>(SubversiveSubstituteWordRangeConfirm)', { noremap = false })
    vim.api.nvim_set_keymap('n', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false })
    vim.api.nvim_set_keymap('x', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false })
    vim.api.nvim_set_keymap('n', '<leader><leader>ss', '<plug>(SubversiveSubvertWordRange)',           { noremap = false })
end

configs['mg979/vim-visual-multi'] = function()
    vim.g.VM_leader = { default = ',', visual = ',', buffer = ',' }
    vim.g.VM_default_mappings = 1
    vim.g.VM_theme = 'spacegray'
    -- vim.g.VM_maps = {[vim.type_idx] = vim.types.dictionary}
    -- vim.g.VM_maps['Undo'] = 'u'
    -- vim.g.VM_maps['Redo'] = '<C-r>'
    -- vim.g.VM_maps['Find Under'] = '<M-n>'
    -- vim.g.VM_maps['Find Subword Under'] = '<M-n>'
end

configs['voldikss/vim-floaterm'] = function()
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
    vim.cmd('au Colorscheme * hi link FloatermBorder Floaterm')
end

configs['jiangmiao/auto-pairs'] = function()
    vim.g.AutoPairsShortcutToggle   = '<M-o>'
    vim.g.AutoPairsShortcutFastWrap = '<M-e>'
    vim.g.AutoPairsShortcutJump     = ''
    vim.g.AutoPairsMapBs            = 1
    vim.g.AutoPairsMapCh            = 0
    vim.g.AutoPairsMapSpace         = 1
    vim.g.AutoPairsMapCR            = 1
    vim.cmd[[au FileType html let b:AutoPairs = extend(g:AutoPairs, {'<': '>'})]]
end

configs['joshdick/onedark.vim'] = function()
    vim.cmd[[
        colorscheme onedark
        "au ColorScheme onedark hi Normal guibg=NONE
        "au ColorScheme onedark hi ColorColumn guibg=NONE
    ]]
end

return configs
