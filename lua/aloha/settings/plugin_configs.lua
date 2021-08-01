return {
    ['mhinz/vim-startify'] = function()
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
    end,
    ['joshdick/onedark.vim'] = function()
        vim.cmd[[
            colorscheme onedark
            au ColorScheme onedark hi Normal guibg=NONE
            au ColorScheme onedark hi ColorColumn guibg=NONE
        ]]
    end,
    ['Yggdroot/indentLine'] = function()
        vim.g.indent_guides_guide_size  = 1
        vim.g.indent_guides_start_level = 2
        vim.g.indentLine_setColors      = 1
        vim.g.indentLine_color_term     = 239
        vim.g.indentLine_char           = '┆'
        vim.g.indentLine_fileType       = {'python'}
    end,
    ['SirVer/ultisnips'] = function()
        vim.g.UltiSnipsEditSplit="vertical"
        vim.g.UltiSnipsRemoveSelectModeMappings = 0
        vim.g.UltiSnipsExpandTrigger="<C-Space>"
        vim.g.UltiSnipsJumpForwardTrigger="<C-j>"
        vim.g.UltiSnipsJumpBackwardTrigger="<C-k>"
    end,
    ['vim-airline/vim-airline'] = function()
        vim.g.airline_symbols = {
            crypt      = '',
            linenr     = '☰',
            linenr     = '㏑',
            maxlinenr  = '¶',
            branch     = '',    -- 
            dirty      = '[+]',  -- ⚡
            paste      = 'Þ',
            -- spell      = 'Ꞩ',
            spell      = '﯑',
            notexists  = 'Ɇ',
            whitespace = 'Ξ'
        }
        -- ﯑韛 
        vim.g.airline_powerline_fonts                      = 1
        vim.g['airline#extensions#tabline#enabled']        = 0
        vim.g['airline#extensions#tabline#buffer_nr_show'] = 0
        vim.g['airline#extensions#tabline#formatter']      = 'default'
        vim.g['airline#extensions#tabline#left_sep']       = '┆'
        vim.g['airline#extensions#tabline#left_alt_sep']   = '┆'
        vim.g['airline#extensions#tabline#right_sep']      = '┆'
        vim.g['airline#extensions#tabline#right_alt_sep']  = '┆'
        vim.g['airline_left_sep']                          = '┆'
        vim.g['airline_left_alt_sep']                      = '┆'
        vim.g['airline_right_sep']                         = '┆'
        vim.g['airline_right_alt_sep']                     = '┆'
    end,
    ['preservim/nerdcommenter'] = function()
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
    end,
    ['mbbill/undotree'] = function()
        vim.api.nvim_set_keymap('n', '<leader>ut', '<Cmd>UndotreeToggle<CR>', {noremap = true})
        vim.g.undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
        vim.g.undotree_CustomDiffpanelCmd = 'botright 10 new'
        vim.g.undotree_SetFocusWhenToggle = 1
        vim.g.undotree_TreeNodeShape      = '⚑'
        vim.g.undotree_RelativeTimestamp  = 0
        vim.g.undotree_HelpLine           = 0
    end,
    ['dkarter/bullets.vim'] = function()
        vim.g.bullets_enabled_file_types = { "markdown", "text" }
        vim.g.bullets_enable_in_empty_buffers = 1
        vim.g.bullets_checkbox_markers = " X"
        vim.g.bullets_mapping_leader = ""
        vim.g.bullets_delete_last_bullet_if_empty = 1
        vim.g.bullets_outline_levels = {'ROM'}
        vim.api.nvim_set_keymap("i", "<C-a>", "<Cmd>ToggleCheckbox<CR>", {noremap = true})
        vim.api.nvim_set_keymap("n", "<leader>sn", "<Cmd>RenumberList<CR>", {noremap = true})
        vim.api.nvim_set_keymap("x", "<leader>sn", "<Cmd>RenumberSelection<CR>", {noremap = true})
    end,
    ['dhruvasagar/vim-table-mode'] = function()
        vim.api.nvim_set_keymap("n", "<leader>tm", "<cmd>TableModeToggle<cr>", {noremap = true})
        vim.g.table_mode_corner_corner="|"
        vim.g.table_mode_header_fillchar="-"
        vim.g.table_mode_align_char=":"
        vim.g.table_mode_delimiter = ','
    end,
    ['kevinhwang91/rnvimr'] = function()
        vim.api.nvim_set_keymap('n', '<CR>', '<Cmd>RnvimrToggle<cr>', {noremap = true})
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
    end,
    ['ryanoasis/vim-devicons'] = function()
        vim.g.webdevicons_enable                 = 1
        vim.g.webdevicons_enable_airline_tabline = 1
        vim.g.airline_powerline_fonts            = 1
    end,
    ['Shougo/defx.nvim'] = function()
        vim.api.nvim_set_keymap('n', '<leader>df', '<Cmd>Defx<Cr>', {noremap = true})
        vim.fn['defx#custom#option']('_', {
            columns = 'mark:indent:git:icon:icons:filename:type:size:time',
            sort = 'filename',
            preview_height = vim.o.lines/2,
            split = 'vertical', winwidth = 40, direction = 'topleft',
            root_marker = '[in]: ',
            buffer_name = 'Defx',
            show_ignored_files = 0,
            ignored_files = '.*,*.webp,*.png,*.jpg,*.o,*.exe',
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
    end,
    ['t9md/vim-choosewin'] = function()
        vim.api.nvim_set_keymap('n', '<C-w><C-i>', '<Cmd>ChooseWin<CR>', {noremap = true})
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
    end,
    ['liuchengxu/vista.vim'] = function()
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
    end,
    ['nvim-treesitter/nvim-treesitter'] = function()
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
    end,
    ['neovim/nvim-lspconfig'] = function()
        local lspconfig = require('lspconfig')
        --nvim_lsp.clangd.setup{on_attach=require'completion'.on_attach}
        --nvim_lsp.pyright.setup{on_attach=require'completion'.on_attach}
        --nvim_lsp.sumneko_lua.setup{on_attach=require'completion'.on_attach}

        --vim.g.completion_enable_snippet = "UltiSnips"

        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

            -- Mappings.
            local opts = { noremap=true, silent=true }
            buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'H', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            buf_set_keymap('n', '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
            buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
            buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
            buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

            -- Set some keybinds conditional on server capabilities
            if client.resolved_capabilities.document_formatting then
                buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
            end
            if client.resolved_capabilities.document_range_formatting then
                buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
            end

            -- Set autocommands conditional on server_capabilities
            if client.resolved_capabilities.document_highlight then
                vim.api.nvim_exec([[
                    hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
                    hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
                    hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
                    augroup lsp_document_highlight
                        autocmd! * <buffer>
                        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                    augroup END
                ]], false)
            end

            -- for 'RRethy/vim-illuminate'
            require 'illuminate'.on_attach(client)
        end

        -- setup lsp clients
        lspconfig.ccls.setup{
            on_attach = on_attach,
            commands_created = true,
            init_options = {
                clang = {
                    extraArgs = {
                        "-std=c++17"
                    }
                }
            }
        }
        -- lspconfig.ccls.setup {
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

        lspconfig.pyright.setup{
            on_attach = on_attach,
            commands_created = true,
        }
    end,
    ['svermeulen/vim-yoink'] = function()
        vim.g.yoinkMaxItems = 40
        vim.g.yoinkSavePersistently = 1
        vim.g.yoinkSwapClampAtEnds  = 0
        vim.g.yoinkSyncNumberedRegisters = 0
        -- vim.api.nvim_set_keymap('n', '<c-n>', '<plug>(YoinkPostPasteSwapBack)',          { silent = false, noremap = false }),
        -- vim.api.nvim_set_keymap('n', '<c-p>', '<plug>(YoinkPostPasteSwapForward)',       { silent = false, noremap = false }),
        vim.api.nvim_set_keymap('n', 'p',     '<plug>(YoinkPaste_p)',                    { silent = false, noremap = false })
        vim.api.nvim_set_keymap('n', 'P',     '<plug>(YoinkPaste_P)',                    { silent = false, noremap = false })
        vim.api.nvim_set_keymap('n', '[y',    '<plug>(YoinkRotateBack)',                 { silent = false, noremap = false })
        vim.api.nvim_set_keymap('n', ']y',    '<plug>(YoinkRotateForward)',              { silent = false, noremap = false })
        vim.api.nvim_set_keymap('n', 'y',     '<plug>(YoinkYankPreserveCursorPosition)', { silent = false, noremap = false })
        vim.api.nvim_set_keymap('x', 'y',     '<plug>(YoinkYankPreserveCursorPosition)', { silent = false, noremap = false })
    end,
    ['easymotion/vim-easymotion'] = function()
        vim.g.EasyMotion_do_mapping = 0
        vim.g.EasyMotion_do_shade   = 1
        vim.g.EasyMotion_smartcase  = 1
        vim.api.nvim_set_keymap('n', [[,]],   '<Plug>(easymotion-prefix)',       { noremap = false })
        vim.api.nvim_set_keymap('n', [[,.]],  '<Plug>(easymotion-repeat)',       { noremap = false })
        vim.api.nvim_set_keymap('n', [[,f]],  '<Plug>(easymotion-f)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,F]],  '<Plug>(easymotion-F)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,t]],  '<Plug>(easymotion-t)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,T]],  '<Plug>(easymotion-T)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,w]],  '<Plug>(easymotion-w)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,W]],  '<Plug>(easymotion-W)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,b]],  '<Plug>(easymotion-b)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,B]],  '<Plug>(easymotion-B)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,e]],  '<Plug>(easymotion-e)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,E]],  '<Plug>(easymotion-E)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,g]],  '<Plug>(easymotion-ge)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,g]],  '<Plug>(easymotion-gE)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,j]],  '<Plug>(easymotion-j)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,k]],  '<Plug>(easymotion-k)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,n]],  '<Plug>(easymotion-n)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,N]],  '<Plug>(easymotion-N)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,s]],  '<Plug>(easymotion-s)',            { noremap = false })
        vim.api.nvim_set_keymap('n', [[,2s]], '<Plug>(easymotion-s2)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,2f]], '<Plug>(easymotion-f2)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,2F]], '<Plug>(easymotion-F2)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,2t]], '<Plug>(easymotion-t2)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,2T]], '<Plug>(easymotion-T2)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,ns]], '<Plug>(easymotion-sn)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,nf]], '<Plug>(easymotion-fn)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,nF]], '<Plug>(easymotion-Fn)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,nt]], '<Plug>(easymotion-tn)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,nT]], '<Plug>(easymotion-Tn)',           { noremap = false })
        vim.api.nvim_set_keymap('n', [[,wf]], '<Plug>(easymotion-overwin-f)',    { noremap = false })
        vim.api.nvim_set_keymap('n', [[,wF]], '<Plug>(easymotion-overwin-f2)',   { noremap = false })
        vim.api.nvim_set_keymap('n', [[,wl]], '<Plug>(easymotion-overwin-line)', { noremap = false })
        vim.api.nvim_set_keymap('n', [[,ww]], '<Plug>(easymotion-overwin-w)',    { noremap = false })
    end,
    ['svermeulen/vim-subversive'] = function()
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
    end,
    ['rhysd/clever-f.vim'] = function()
        vim.g.clever_f_smart_case              = 1
        vim.g.clever_f_use_migemo              = 0
        vim.g.clever_f_fix_key_direction       = 1
        vim.g.clever_f_chars_match_any_signs   = ''
        vim.g.clever_f_repeat_last_char_inputs = { [[\<CR>]], [[\<Tab>]] }
        vim.g.clever_f_mark_direct             = 1
        vim.g.clever_f_mark_direct_color       = "CleverFDefaultLabel"
    end,
    ['mg979/vim-visual-multi'] = function()
        vim.g.VM_leader = { default = ',', visual = ',', buffer = ',' }
        vim.g.VM_default_mappings = 1
        vim.g.VM_theme = 'spacegray'
    end,
    ['jiangmiao/auto-pairs'] = function()
        vim.g.AutoPairsShortcutToggle   = '<M-o>'
        vim.g.AutoPairsShortcutFastWrap = '<M-e>'
        vim.g.AutoPairsShortcutJump     = ''
        vim.g.AutoPairsMapBs            = 1
        vim.g.AutoPairsMapCh            = 0
        vim.g.AutoPairsMapSpace         = 1
        vim.g.AutoPairsMapCR            = 1
    end,
    ['voldikss/vim-floaterm'] = function()
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
    end,
    ['mhinz/vim-signify'] = function()
        -- vim.g.signify_sign_add               = '▐'
        -- vim.g.signify_sign_delete_first_line = '▔'
        -- vim.g.signify_sign_delete            = '▎'
        -- vim.g.signify_sign_change            = '░'
        vim.g.signify_sign_add               = '▊'
        vim.g.signify_sign_delete_first_line = '▊'
        vim.g.signify_sign_delete            = '▊'
        vim.g.signify_sign_change            = '▊'
    end,
    ['ron89/thesaurus_query.vim'] = function()
        vim.api.nvim_set_keymap('n', '<Leader>cw', '<Cmd>ThesaurusQueryReplaceCurrentWord<CR>', {noremap = true})
        vim.g.tq_map_keys           = 0
        vim.g.tq_openoffice_en_file = "~/.config/nvim/thesaurus/th_en_US_new"
        vim.g.tq_mthesaur_file      = "~/.config/nvim/thesaurus/mthesaur.txt"
        vim.g.tq_cilin_txt_file     = "~/.config/nvim/thesaurus/cilin.txt"
    end,
    ['voldikss/vim-translator'] = function()
        vim.api.nvim_set_keymap('n', '<Leader>t', "<Cmd>TranslateW<Cr>", { silent = false, noremap = true })
        vim.api.nvim_set_keymap('x', '<Leader>t', "<Cmd>Translate<Cr>", { silent = false, noremap = true })
        vim.g.translator_history_enable   = 1
        vim.g.translator_window_type      = 'popup'
        vim.cmd("hi link TranslatorBorder Normal")
    end,
    ['lervag/vimtex'] = function()
        vim.g.tex_flavor = 'latex'
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_quickfix_mode = 0
        vim.g.vimtex_compiler_progname = 'nvr'
        vim.g.vimtex_complete_close_braces = 1
        vim.g.vimtex_cache_root = '/home/aloha/.cache/nvim/vimtex'
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
    end,

    ['RRethy/vim-hexokinase'] = function()
        vim.g.Hexokinase_highlighters  = {'backgroundfull'}
        vim.g.Hexokinase_refreshEvents = {'BufWrite', 'BufRead', 'InsertLeave'}
        vim.g.Hexokinase_termDisabled  = 1
    end,
    ['iamcco/markdown-preview.nvim'] = function()
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
    end,
}

