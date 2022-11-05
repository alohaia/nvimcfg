local configs = {}
local g = vim.g
local api = vim.api

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
end

configs['norcalli/nvim-colorizer.lua'] = function()
    require 'colorizer'.setup({
        'markdown', 'html', 'gohtmltmpl',
        ['css'] = { css = true },
    }, {
        name = false,
    })
end

configs['akinsho/bufferline.nvim'] = function()
    local colors = {
        white = "#ABB2BF",
        gray = "#3E4452",
        dark_gray = "#2C323C",
        green = "#98C379",
    }
    local hls_style = {
        normal = { bg=colors.dark_gray, italic=true, bold=false },
        selected = { bg=colors.white, italic=false, bold=true },
        visible = { bg=colors.gray, italic=false, bold=true }
    }
    local hls = {
        normal = { bg=colors.dark_gray },
        selected = { bg=colors.white },
        visible = { bg=colors.gray }
    }
    require('bufferline').setup {
        highlights = {
            fill = { bg="NONE" },

            background = hls_style.normal,
            buffer_selected = vim.tbl_extend("force", hls_style.selected, { fg=colors.dark_gray }),
            buffer_visible = hls_style.visible,

            hint = hls_style.normal,
            hint_selected = vim.tbl_extend("force", hls_style.selected, { fg=colors.dark_gray }),
            hint_visible = hls_style.visible,
            info = hls_style.normal, info_selected = hls_style.selected, info_visible = hls_style.visible,
            warning = hls_style.normal, warning_selected = hls_style.selected, warning_visible = hls_style.visible,
            error = hls_style.normal, error_selected = hls_style.selected, error_visible = hls_style.visible,
            hint_diagnostic = hls.normal,
            hint_diagnostic_selected = vim.tbl_extend("force", hls_style.selected, { fg=colors.dark_gray }),
            hint_diagnostic_visible = hls.visible,
            info_diagnostic = hls.normal, info_diagnostic_selected = hls.selected, info_diagnostic_visible = hls.visible,
            warning_diagnostic = hls.normal, warning_diagnostic_selected = hls.selected, warning_diagnostic_visible = hls.visible,
            error_diagnostic = hls.normal, error_diagnostic_selected = hls.selected, error_diagnostic_visible = hls.visible,

            duplicate = { bg=colors.dark_gray },
            duplicate_selected = { fg=colors.dark_gray, bg=colors.white },
            duplicate_visible = { bg=colors.gray },

            separator = { bg=colors.dark_gray },
            separator_selected = { fg=colors.dark_gray, bg=colors.white },
            separator_visible = { bg=colors.gray },

            indicator_selected = { fg=colors.dark_gray, bg=colors.white },
            indicator_visible = { bg=colors.gray },

            numbers = { bg=colors.dark_gray },
            numbers_selected = { fg=colors.dark_gray, bg=colors.white },
            numbers_visible = { bg=colors.gray },

            tab = { bg=colors.dark_gray },
            tab_selected = { fg=colors.dark_gray, bg=colors.white },

            tab_separator = { fg=colors.dark_gray, bg=colors.dark_gray },
            tab_separator_selected = { fg=colors.white, bg=colors.white },

            modified = { fg=colors.green, bg=colors.dark_gray },
            modified_selected = { fg=colors.dark_gray, bg=colors.white },
            modified_visible = { fg=colors.green, bg=colors.gray },

            pick = { fg=colors.green, bg=colors.dark_gray },
            pick_visible = { fg=colors.dark_gray, bg=colors.white },
            pick_selected = { fg=colors.green, bg=colors.gray },

            diagnostic = { bg=colors.dark_gray },
            diagnostic_visible = { fg=colors.dark_gray, bg=colors.white },
            diagnostic_selected = { bg=colors.gray },

            offset_separator = { bg=colors.dark_gray },
        },
        options = {
            mode = "buffers",
            numbers = "buffer_id",
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            middle_mouse_command = nil,
            --- NOTE: this plugin is designed with this icon in mind,
            --- and so changing this is NOT recommended, this is intended
            --- as an escape hatch for people who cannot bear it for whatever reason
            show_buffer_icons = true,
            show_buffer_close_icons = false,
            show_tab_indicators = true,
            show_close_icon = false,
            indicator = { style = 'none' },
            modified_icon = 'M', -- ✥ ●
            left_trunc_marker = '<', -- 
            right_trunc_marker = '>', -- 
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            tab_size = 18,
            diagnostics = "nvim_lsp", -- false | "nvim_lsp",
            diagnostics_indicator = function(count, level, _, context) -- 
                local sym = level == "error" and "E"
                    or (level == "warning" and "W" or (level == "hint" and "H" or "I"))
                return sym.."("..count..")"
            end,
            offsets = {
                {
                    filetype = "vista_markdown",
                    text = "Vista Tags",
                    highlight = "Title",
                    text_align = "left",
                }
            },
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            --- can also be a table containing 2 custom separators
            --- [focused and unfocused]. eg: { '|', '|' }
            separator_style = { "", "" }, -- "slant" | "thick" | "thin" | { 'any', 'any' },
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            sort_by = "id",
            custom_areas = {
              right = function()
                local result = {}
                local error   = vim.tbl_count(vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR }))
                local warning = vim.tbl_count(vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN  }))
                local info    = vim.tbl_count(vim.diagnostic.get(0, {severity = vim.diagnostic.severity.INFO  }))
                local hint    = vim.tbl_count(vim.diagnostic.get(0, {severity = vim.diagnostic.severity.HINT  }))

                if error ~= 0 then
                    table.insert(result, {text = "  " .. error, guifg = "#E06C75"})
                end

                if warning ~= 0 then
                    table.insert(result, {text = "  " .. warning, guifg = "#E5C07B"})
                end

                if hint ~= 0 then
                    table.insert(result, {text = "  " .. hint, guifg = "#56B6C2"})
                end

                if info ~= 0 then
                    table.insert(result, {text = "  " .. info, guifg = "#61AFEF"})
                end
                return result
              end,
            },
        }
    }
    api.nvim_set_keymap("n", "gb", "<Cmd>BufferLinePick<CR>", {noremap = true, silent = true})
end

configs['kyazdani42/nvim-tree.lua'] = function()
    require("nvim-tree").setup {
        auto_reload_on_write = true,
        disable_netrw = true,
        hijack_cursor = true,
        hijack_netrw = true,
        view = {
            hide_root_folder = true,
            adaptive_size = true,
            float = {
                enable = true
            },
        },
        filters = {
            dotfiles = true,
        },
        renderer = {
            add_trailing = false,
            group_empty = true,
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    none = " ",
                },
            },
        },
        actions = {
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", 'quickfix', "terminal", "prompt", "help" },
                    },
                },
            },
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
    }
    -- see :h nvim-tree-events
    api.nvim_set_keymap('n', '<leader>nt', '<Cmd>NvimTreeToggle<CR>', {noremap = true})
    vim.cmd[[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]]
end

configs['lewis6991/gitsigns.nvim'] = function()
    require('gitsigns').setup {
        signs = {
            add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
            change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
            delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
            topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
            changedelete = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        numhl              = true,
        current_line_blame = false
    }
end

configs['neovim/nvim-lspconfig'] = function()
    local lspconfig = require 'lspconfig'
    local util = require 'lspconfig.util'

    local on_attach = function(client,bufnr)
        -- Set autocommands conditional on server_capabilities
        -- :lua =vim.lsp.get_active_clients()[1].server_capabilities
        -- https://github.com/neovim/neovim/issues/14090#issuecomment-1113956767
        -- if client.server_capabilities.documentHighlightProvider then
        --     api.nvim_exec([[
        --         hi LspReferenceRead cterm=bold ctermbg=red gui=italic guibg=#2C323C
        --         hi LspReferenceText cterm=bold ctermbg=red gui=italic guibg=#2C323C
        --         hi LspReferenceWrite cterm=bold ctermbg=red gui=italic guibg=#2C323C
        --         augroup lsp_document_highlight
        --             autocmd! * <buffer>
        --             autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        --             autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        --         augroup END
        --     ]], false)
        -- end
        -- keymaps
        local opts = { noremap = true, silent = true }
        api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        api.nvim_buf_set_keymap(bufnr, 'n', '<leader>?', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        -- -- api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        -- api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

        -- Enable completion triggered by <c-x><c-o>
        api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        -- for 'RRethy/vim-illuminate'
        require 'illuminate'.on_attach(client)
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
            properties = {
                "documentation",
                "detail",
                "additionalTextEdits",
            },
        },
    }

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    local root_files = {
        '.luarc.json',
        '.luacheckrc',
        '.stylua.toml',
        'selene.toml',
    }
    lspconfig.sumneko_lua.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
            "lua-language-server",
            "-E", "/usr/share/lua-language-server/main.lua"
        },
        single_file_support = true,
        root_dir = function(fname)
            return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
        end,
        settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim"}
                },
                runtime = {
                    version = "LuaJIT",
                    path = runtime_path,
                },
                workspace = {
                    library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
            },
        }
    }
    lspconfig.clangd.setup {
        capabilities = capabilities,
        on_attach = function (client, bufnr)
            api.nvim_buf_set_keymap(bufnr, 'n', '<C-s>', '<Cmd>ClangdSwitchSourceHeader<cr>', {noremap=true})
            on_attach(client, bufnr)
        end,
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" }
    }
    local servers = {
        'bashls', 'pyright', 'r_language_server'
    }
    for _,server in ipairs(servers) do
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
        }
    end

    lspconfig.tsserver.setup {
        capabilities = capabilities,
    }
    lspconfig.cssls.setup {
        capabilities = capabilities,
        cmd = { "/usr/bin/vscode-css-language-server", "--stdio" },
    }
    lspconfig.jsonls.setup {
        capabilities = capabilities,
        cmd = { "/usr/bin/vscode-json-language-server", "--stdio"  }
    }
    lspconfig.html.setup {
        capabilities = capabilities,
        cmd = { "/usr/bin/vscode-html-language-server", "--stdio"  }
    }
end

configs['L3MON4D3/LuaSnip'] = function()
    require("luasnip.loaders.from_lua").lazy_load()

    api.nvim_set_keymap("i", "<C-n>", "<Plug>luasnip-next-choice", {})
    api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
    api.nvim_set_keymap("i", "<C-p>", "<Plug>luasnip-previous-choice", {})
    api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-previous-choice", {})
end

configs['hrsh7th/nvim-cmp'] = function()
    local cmp = require("cmp")
    cmp.setup{
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
            end,
        },
        sources = cmp.config.sources({ -- group 1
            { name = 'nvim_lsp' },
            -- { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
            { name = 'omni' },
        }, {                           -- group 2
            { name = 'buffer' },
            { name = 'path', option = {
                trailing_slash = true,
                -- get_cwd = fucntion
            }},
        }),
        mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end,
            ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            -- ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-Space>'] = cmp.config.disable,
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            })
        },
        preselect = cmp.PreselectMode.Item,
        completion = {
            -- autocomplete = types.cmp.TriggerEvent.TextChanged,
            -- keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
            -- keyword_length = 1, -- minimum length of a word to complete on
            -- get_trigger_characters = function(trigger_characters) return trigger_characters end,
            -- completeopt = 'menu,menuone,noselect'
        },
        confirmation = {
            -- default_behavior = cmp.ConfirmBehavior.Insert,
            -- get_commit_characters = function() ... end
        },
        experimental = {
            -- native_menu = true
        },
        -- onsails/lspkind-nvim
        formatting = {
            format = require('lspkind').cmp_format({with_text = true, maxwidth = 50})
        }
    }
    -- For markdown filetype
    -- au FileType markdown lua cmp.setup.buffer({})
    -- For nvim-autopairs
    -- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    -- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
end

configs['nvim-telescope/telescope.nvim'] = function()
    local telescope = require('telescope')
    telescope.setup {
        -- extensions = {
        --     fzy_native = {
        --         override_generic_sorter = false,
        --         override_file_sorter = true,
        --     },
        --     fzf = {
        --         fuzzy = true,                    -- false will only do exact matching
        --         override_generic_sorter = true,  -- override the generic sorter
        --         override_file_sorter = true,     -- override the file sorter
        --         case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
        --     },
        -- },
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case'
            },
            prompt_prefix = '   ', -- 🔍
            selection_caret = '> ', -- 
            entry_prefix = '  ',
            initial_mode = 'insert',
            sorting_strategy = 'ascending',
            selection_strategy = 'reset',
            layout_strategy = 'horizontal',
            scroll_strategy = 'cycle',
            layout_config = {
                horizontal = {
                    prompt_position = 'top',
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
            file_sorter =  require'telescope.sorters'.get_fuzzy_file,
            file_ignore_patterns = { 'node_modules' },
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
            buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
            mappings = {
                n = { ['q'] = require('telescope.actions').close },
            },
        },
    }
    -- telescope.load_extension('fzy_native')
    -- telescope.load_extension('fzf')

    -- keybindings
    api.nvim_set_keymap('n', ',t', '<Cmd>Telescope resume<CR>', {noremap = true})
    api.nvim_set_keymap('n', ',f', '<Cmd>Telescope find_files<CR>', {noremap = true})
    api.nvim_set_keymap('n', ',F', '<Cmd>Telescope file_browser<CR>', {noremap = true})
    api.nvim_set_keymap('n', ',b', '<Cmd>Telescope buffers<CR>', {noremap = true})
    api.nvim_set_keymap('n', ',g', '<Cmd>Telescope live_grep<CR>', {noremap = true})
    api.nvim_set_keymap('n', ',h', '<Cmd>Telescope help_tags<CR>', {noremap = true})
end

configs['RRethy/vim-illuminate'] = function()
    require('illuminate').configure({
        providers = {'lsp', 'treesitter', 'regex'},
        filetypes_denylist = {'dashboard', 'NvimTree'},
        under_cursor = true,
        modes_denylist = {},
    })
    api.nvim_set_keymap('n', '<a-n>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>', {noremap=true})
    api.nvim_set_keymap('n', '<a-p>', '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>', {noremap=true})
end

configs['rhysd/clever-f.vim'] = function()
    g.clever_f_smart_case              = 1
    g.clever_f_use_migemo              = 0
    g.clever_f_fix_key_direction       = 1
    g.clever_f_chars_match_any_signs   = ''
    g.clever_f_repeat_last_char_inputs = { [[\<CR>]], [[\<Tab>]] }
    g.clever_f_mark_direct             = 1
    g.clever_f_mark_direct_color       = "CleverFDefaultLabel"
end

configs['rainbowhxch/accelerated-jk.nvim'] = function ()
    -- require('accelerated-jk').setup({
    --     mode = 'time_driven',
    --     enable_deceleration = false,
    --     acceleration_motions = {},
    --     acceleration_limit = 150,
    --     acceleration_table = { 7,12,17,21,24,26,28,30 },
    --     -- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
    --     deceleration_table = { {150, 9999} }
    -- })
    vim.api.nvim_set_keymap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
    vim.api.nvim_set_keymap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
end

configs['nvim-treesitter/nvim-treesitter'] = function()
    api.nvim_command('set foldmethod=expr')
    api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'c', 'cpp', 'css', 'bash', 'cmake', 'glsl', 'go', 'html', 'javascript',
            'lua', 'r', 'ruby', 'rust', 'toml', 'vim', 'vue', 'yaml'
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<leader>ti',
                node_incremental = '<leader>ta',
                scope_incremental = '<leader>ts',
                node_decremental = '<leader>td',
            },
        },
        highlight = {
            enable = true,
            disable = {'markdwon'},
            custom_captures = {
                -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
                -- ['foo.bar'] = 'Identifier',
            },
        },
        indent = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
        },
    }
end

configs['brooth/far.vim'] = function()
    g['far#source'] = 'rgnvim'
    g['far#enable_undo'] = 1
    g['far#mapping'] = {
        stoggle_expand_all = 'zt',
        toggle_expand_all  = 'zA',
        expand_all         = 'zr',
        collapse_all       = 'zm',
    }
end

configs['liuchengxu/vista.vim'] = function()
    vim.cmd[[autocmd FileType vista,vista_kind nnoremap <buffer> <silent> f <Cmd>call vista#finder#fzf#Run()<CR>]]
    api.nvim_set_keymap('n', '<leader>vt', '<Cmd>Vista<Cr>', {noremap = true})
    api.nvim_set_keymap('n', ',T', '<Cmd>Vista finder<Cr>', {noremap = true})
    g.vista_default_executive = 'ctags'
    g.vista_ctags_executable = 'ctags'
    g.vista_ctags_project_opts = '--sort=no -R -o tags'
    g.vista_executive_for = {
        -- vimwiki  = 'markdown',
        pandoc   = 'markdown',
        rmd      = 'markdown',
        markdown = 'toc',
    }
    g.vista_enable_markdown_extension    = 1
    g.vista_enable_markdown_extension    = 1
    g.vista_fzf_preview                  = {'right:50%'}
    g.vista_sidebar_width                = 30
    g.vista_fold_toggle_icons            = {'▾', '▸'}
    g.vista_icon_indent                  = {"└─▸ ", "├─▸ "}
    g.vista_echo_cursor                  = 1
    g.vista_cursor_delay                 = 0
    g.vista_echo_cursor_strategy         = 'scroll'
    g.vista_update_on_text_changed       = 1
    g.vista_update_on_text_changed_delay = 2000
    g.vista_close_on_jump                = 0
    g.vista_stay_on_open                 = 1
    g.vista_blink                        = {0, 0}
    g.vista_top_level_blink              = {0, 0}
    g.vista_highlight_whole_line         = 1
    -- g['vista#renderer#icons'] = {
    --     function = "",
    --     variable = "",
    -- }
end

configs['mhinz/vim-startify'] = function()
    g.startify_change_to_vcs_dir   = 1
    g.startify_change_to_dir       = 0
    g.startify_fortune_use_unicode = 0
    g.startify_padding_left        = 3
    g.startify_session_persistence = 0
    g.startify_session_autoload    = 1
    g.startify_skiplist            = {
        [[.*/doc/.*\.txt$]],
        [[/usr/share/nvim/runtime/doc/.*\.txt$]],
        [[.*/vimdoc-cn/doc/.*\.cnx]],
        [[.*/.git/.*]],
    }
    g.startify_files_number = 10
    g.startify_bookmarks = {
        -- '~/.config/nvim/plugins/vimspector/docs/schema/vimspector.schema.json',
        -- '~/.config/nvim/plugins/vimspector/docs/schema/gadgets.schema.json',
    }
    g.startify_commands = {
        -- { t = {'Press t to open coc-explorer.',      'CocCommand explorer'}},
        -- { w = {"Open Index page for Vimwiki.",       'VimwikiIndex'}},
        -- { d = {"Open Index page for Vimwiki Diary.", 'VimwikiDiaryIndex'}},
    }
    g.startify_lists = {
        { type = 'dir',       header = {'   PWD: '..vim.fn.getcwd()}},
        { type = 'commands',  header = {'   Commands'}              },
        { type = 'files',     header = {'   Recent Opened Files'}   },
        { type = 'sessions',  header = {'   Sessions'}              },
        { type = 'bookmarks', header = {'   Bookmarks'}             },
    }

    _G.webDevIcons = function(path)
        local filename = vim.fn.fnamemodify(path, ':t')
        local extension = vim.fn.fnamemodify(path, ':e')
        return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
    end
    vim.cmd[[
    function! StartifyEntryFormat() abort
        return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
    endfunction
    ]]
end

configs['preservim/nerdcommenter'] = function()
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
end

configs['mbbill/undotree'] = function()
    api.nvim_set_keymap('n', '<leader>ut', '<Cmd>UndotreeToggle<CR>', {noremap = true})
    g.undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
    vim.cmd[[
        function g:Undotree_CustomMap()
            nnoremap <buffer> n <plug>UndotreeNextState
            nnoremap <buffer> p <plug>UndotreePreviousState
            nnoremap <buffer> N 5<plug>UndotreeNextState
            nnoremap <buffer> P 5<plug>UndotreePreviousState
        endfunc
    ]]
    g.undotree_CustomDiffpanelCmd = 'botright 10 new'
    g.undotree_SetFocusWhenToggle = 1
    g.undotree_TreeNodeShape      = '⚑'
    g.undotree_RelativeTimestamp  = 0
    g.undotree_HelpLine           = 0
end

configs['nvim-lua/completion-nvim'] = function()
    api.nvim_set_keymap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], {noremap=true, expr=true})
    api.nvim_set_keymap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], {noremap=true, expr=true})
    g.completion_enable_auto_popup = 1
    g.completion_enable_snippet = 'UltiSnips'
    g.completion_confirm_key = '<CR>'
end

configs['SirVer/ultisnips'] = function()
    g.UltiSnipsEditSplit = "vertical"
    g.UltiSnipsRemoveSelectModeMappings = 0
    g.UltiSnipsExpandTrigger = "<Tab>"
    g.UltiSnipsJumpForwardTrigger = "<Tab>"
    g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"
end

configs['luochen1990/rainbow'] = function()
    g.rainbow_conf = {}
    g.rainbow_conf.separately = {
        ['*'] = {},
        markdown = 0;
        rmd = 0;
    }
end

configs['alohaia/hugowiki.nvim'] = function()
    g.hugowiki_home = '~/Documents/blog/'
    g.hugowiki_try_init_file = 1
    g.hugowiki_follow_after_create = 0
    g.hugowiki_use_imaps = 1
    g.hugowiki_disable_fold = 0
    g.markdown_fenced_languages = {
        'lua',  'c', 'cpp', 'r', 'javascript', 'python',
        'sh', 'bash', 'zsh', 'yaml', 'tex'
    }
    g.hugowiki_wrap = 0
    g.hugowiki_auto_save = 0
    g.hugowiki_auto_update_lastmod = 1
    g.hugowiki_lastmod_under_date = 1
    g.hugowiki_rmd_auto_knit = {
        enable = true,
        cwd = vim.fn.expand(g.hugowiki_home),
        r_script = vim.fn.expand(g.hugowiki_home) .. 'utils/R/build_one.R',
    }
end

configs['lervag/vimtex'] = function()
    g.vimtex_view_method = 'zathura'
    g.vimtex_complete_close_braces = 1  -- ineffective?
    g.vimtex_fold_enabled = 1
    g.vimtex_quickfix_ignore_filters = {
        [[Package fontspec Warning.*CJK]]
    }
    g.vimtex_syntax_conceal = {
        math_bounds = 0,
        sections = 1,
    }

    g.vimtex_compiler_method = 'latexmk'
    g.vimtex_compiler_latexmk = {
        build_dir = '',
        callback = 1,
        hooks = {},
        executable = 'latexmk',
        options   = {
            '-verbose',
            '-file-line-error',
            '-synctex=1',
            '-interaction=nonstopmode',
        },
    }
    g.vimtex_compiler_latexmk_engines = {
        _                    = '-xelatex',
        pdfdvi               = '-pdfdvi',
        pdfps                = '-pdfps',
        pdflatex             = '-pdf',
        luatex               = '-lualatex',
        lualatex             = '-lualatex',
        xelatex              = '-xelatex',
        ['context (pdftex)'] = '-pdf -pdflatex = texexec',
        ['context (luatex)'] = '-pdf -pdflatex = context',
        ['context (xetex)']  = '-pdf -pdflatex = "texexec --xtx"',
    }
end

configs['dkarter/bullets.vim'] = function()
    g.bullets_enabled_file_types = { "markdown", "text" }
    g.bullets_enable_in_empty_buffers = 1
    g.bullets_checkbox_markers = " X"
    g.bullets_mapping_leader = ""
    g.bullets_delete_last_bullet_if_empty = 1
    g.bullets_outline_levels = {'ROM'}
    api.nvim_set_keymap("i", "<C-a>", "<Cmd>ToggleCheckbox<CR>", {noremap = true})
    api.nvim_set_keymap("n", "<leader>sn", "<Cmd>RenumberList<CR>", {noremap = true})
    api.nvim_set_keymap("x", "<leader>sn", "<Cmd>RenumberSelection<CR>", {noremap = true})
end

configs['dhruvasagar/vim-table-mode'] = function()
    api.nvim_set_keymap("n", "<leader>tm", "<cmd>TableModeToggle<cr>", {noremap = true})
    g.table_mode_corner = '|'
    g.table_mode_corner_corner="|"
    g.table_mode_align_char=":"
    g.table_mode_header_fillchar="-"
    g.table_mode_delimiter = ','
end


configs['svermeulen/vim-subversive'] = function()
    g.subversiveCurrentTextRegister = 1
    api.nvim_set_keymap('n', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    api.nvim_set_keymap('x', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    api.nvim_set_keymap('x', 'p',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    api.nvim_set_keymap('x', 'P',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    api.nvim_set_keymap('n', 'ss',                 '<plug>(SubversiveSubstituteLine)',             { noremap = false })
    api.nvim_set_keymap('n', 'S',                  '<plug>(SubversiveSubstituteToEndOfLine)',      { noremap = false })
    api.nvim_set_keymap('n', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false })
    api.nvim_set_keymap('x', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false })
    api.nvim_set_keymap('n', '<leader>ss',         '<plug>(SubversiveSubstituteWordRange)',        { noremap = false })
    api.nvim_set_keymap('n', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false })
    api.nvim_set_keymap('x', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false })
    api.nvim_set_keymap('n', '<leader>crr',        '<plug>(SubversiveSubstituteWordRangeConfirm)', { noremap = false })
    api.nvim_set_keymap('n', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false })
    api.nvim_set_keymap('x', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false })
    api.nvim_set_keymap('n', '<leader><leader>ss', '<plug>(SubversiveSubvertWordRange)',           { noremap = false })
end

configs['svermeulen/vim-yoink'] = function ()
    api.nvim_set_keymap('n', 'p', '<plug>(YoinkPaste_p)', {noremap=false})
    api.nvim_set_keymap('n', 'P', '<plug>(YoinkPaste_P)', {noremap=false})
    api.nvim_set_keymap('n', 'gp', '<plug>(YoinkPaste_gp)', {noremap=false})
    api.nvim_set_keymap('n', 'gP', '<plug>(YoinkPaste_gP)', {noremap=false})
    api.nvim_set_keymap('n', '[s', '<plug>(YoinkPostPasteSwapBack)', {noremap=false})
    api.nvim_set_keymap('n', ']s', '<plug>(YoinkPostPasteSwapForward)', {noremap=false})
    api.nvim_set_keymap('n', '[y', '<plug>(YoinkRotateBack)', {noremap=false})
    api.nvim_set_keymap('n', ']y', '<plug>(YoinkRotateForward)', {noremap=false})
    api.nvim_set_keymap('n', 'y', '<plug>(YoinkYankPreserveCursorPosition)', {noremap=false})
    api.nvim_set_keymap('x', 'y', '<plug>(YoinkYankPreserveCursorPosition)', {noremap=false})
end

configs['mg979/vim-visual-multi'] = function()
    g.VM_leader = { default = ',', visual = ',', buffer = ',' }
    g.VM_default_mappings = 1
    g.VM_theme = 'spacegray'
    -- g.VM_maps = {[vim.type_idx] = vim.types.dictionary}
    -- g.VM_maps['Undo'] = 'u'
    -- g.VM_maps['Redo'] = '<C-r>'
    -- g.VM_maps['Find Under'] = '<M-n>'
    -- g.VM_maps['Find Subword Under'] = '<M-n>'
end

configs['voldikss/vim-floaterm'] = function()
    g.floaterm_keymap_toggle = '<C-\\>'
    g.floaterm_keymap_prev   = '<F1>'
    g.floaterm_keymap_next   = '<F2>'
    g.floaterm_keymap_new    = '<F3>'
    g.floaterm_keymap_kill   = '<F4>'
    g.floaterm_gitcommit     = 'floaterm'
    g.floaterm_autoinsert    = 1
    g.floaterm_width         = 0.5
    g.floaterm_height        = 0.5
    g.floaterm_autoclose     = 1
    g.floaterm_title         = 'floaterm: $1/$2'
    g.floaterm_wintype       = 'popup'
    g.floaterm_position      = 'bottomright'
    vim.cmd('hi link FloatermBorder Normal')
end

configs['akinsho/toggleterm.nvim'] = function()
    require("toggleterm").setup{
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
            border = "curved",
        }
    }
end

configs['jiangmiao/auto-pairs'] = function()
    -- g.AutoPairsFlyMode            = 1
    g.AutoPairsShortcutToggle     = ''
    g.AutoPairsShortcutFastWrap   = '<M-w>'
    g.AutoPairsShortcutBackInsert = '<M-b>'
    g.AutoPairsShortcutJump       = ''
    g.AutoPairsMapCh              = 0
    g.AutoPairsCenterLine         = 0
    g.AutoPairsMultilineClose     = 1

    g.AutoPairs = {
        ['(']   = ')',
        ['[']   = ']',
        ['{']   = '}',
        ["'"]   = "'",
        ['"']   = '"',
        ['`']   = '`'
    }
    api.nvim_create_autocmd('FileType', {
        pattern = 'html',
        callback = function ()
            vim.b.AutoPairs = vim.tbl_extend('force', g.AutoPairs, {
                ['<'] = '>'
            })
        end
    })
    api.nvim_create_autocmd('FileType', {
        pattern = {'markdown', 'rmd'},
        callback = function ()
            vim.b.AutoPairs = vim.tbl_extend('force', g.AutoPairs, {
                ['``'] = '``',
                ['```'] = '```',
            })
        end
    })
    api.nvim_create_autocmd('FileType', {
        pattern = 'vim',
        callback = function ()
            vim.b.AutoPairs = vim.tbl_extend('force', g.AutoPairs, {
                ['"'] = '',
                ['"""'] = ''
            })
        end
    })
end

configs['windwp/nvim-autopairs'] = function()
    local npairs = require("nvim-autopairs")
    local Rule = require('nvim-autopairs.rule')
    -- local conds = require('nvim-autopairs.conds')
    npairs.setup{
        disable_filetype = { "TelescopePrompt" },
        disable_in_macro = false,                 -- disable when recording or executing a macro
        disable_in_visualblock = true,            -- disable when insert after visual block mode
        ignored_next_char = [=[[%w%%%'%[%"%.]]=],
        enable_moveright = true,
        enable_afterquote = true,                 -- add bracket pairs after quote
        enable_check_bracket_line = true,         -- - check bracket in same line
        enable_bracket_in_quote = true,
        check_ts = true,
        map_cr = true,
        map_bs = true,                            -- map the <BS> key
        map_c_h = false,                          -- Map the <C-h> key to delete a pair
        map_c_w = false,                          -- map <c-w> to delete a pair if possible
        fast_wrap = {
            map = '<M-w>',
            chars = { '{', '[', '(', '"', "'" },
            pattern = [=[[%'%"%)%>%]%)%}%,]]=],
            end_key = '$',
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            check_comma = true,
            highlight = 'Search',
            highlight_grey='Comment'
        },
    }
    Rule('“', '”', {'markdown', 'rmd', 'text'})
    Rule('‘', '’', {'markdown', 'rmd', 'text'})
    Rule('``', '``', {'markdown', 'rmd', 'text'})
    Rule('h', 'a', {'markdown', 'rmd', 'text'})
    -- Rule('%s```.*', '```', {'markdown', 'rmd'})

        :use_regex(true)
        -- :end_wise(conds.done())
        -- :only_cr(conds.done())
    -- Treesitter rules
    -- local ts_conds = require('nvim-autopairs.ts-conds')
    -- npairs.setup({
    --     check_ts = true,
    --     ts_config = {
    --         lua = {'string'},-- it will not add a pair on that treesitter node
    --         javascript = {'template_string'},
    --         java = false,-- don't check treesitter on java
    --     }
    -- })
    -- -- press % => %% only while inside a comment or string
    -- npairs.add_rules({
    --   Rule("%", "%", "lua")
    --     :with_pair(ts_conds.is_ts_node({'string','comment'})),
    --   Rule("$", "$", "lua")
    --     :with_pair(ts_conds.is_not_ts_node({'function'}))
    -- })
end

configs['olimorris/onedarkpro.nvim'] = function()
    vim.opt.background = "dark"
    local transparentbg = _G.aloha.configs.transparency == nil and true or _G.aloha.configs.transparency
    require("onedarkpro").setup({
        dark_theme = "onedark_vivid",
        light_theme = "onelight_vivid",
        highlights = {
            Conceal = { link = "Normal" },
            -- Keyword = { gui = "italic" }
        },
        plugins = {
            all = false,
            native_lsp = true,
            polygot = false,
            treesitter = true
        },
        options = {
            bold = true,
            italic = true,
            undercurl = true,
            underline = true,
            cursorline = true,
            transparency = transparentbg,
            terminal_colors = true,
            window_unfocussed_color = false,
        }
    })
    require("onedarkpro").load()
    if transparentbg then
        api.nvim_create_autocmd("VimEnter", {
            pattern = "*",
            callback = function ()
                api.nvim_set_hl(0, 'lualine_c_normal', {bg="NONE"})
                api.nvim_set_hl(0, 'lualine_c_inactive',{bg="NONE"})
            end
        })
    end
end

configs['nvim-lualine/lualine.nvim'] = function()
    local function spelllang()
        return '﯑ ' .. string.upper(table.concat(vim.opt.spelllang:get(), ','))
    end
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = { left = '┆', right = '┆'}, -- 
            section_separators = { left = '┆', right = '┆'},
            disabled_filetypes = {},
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                { 'filetype', color = { bg='#2c323c' } },
                { 'filename' }
            },
            lualine_x = {
                'encoding',
                { 'fileformat', color = { bg='#2c323c' } }
            },
            lualine_y = {
                { spelllang, cond = function() return vim.opt.spell:get() end },
                'progress'
            },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        extensions = {"nvim-tree", "fzf", "fugitive", "quickfix", "symbols-outline"}
    }
end

configs['vim-airline/vim-airline'] = function()
    g['airline#extensions#tabline#enabled'] = 0
    -- ﯑韛 
    g['airline_left_sep']                   = '┆'
    g['airline_left_alt_sep']               = '┆'
    g['airline_right_sep']                  = '┆'
    g['airline_right_alt_sep']              = '┆'
    g.airline_symbols = {
        colnr      = ' ㏇:',
        notexists  = 'Ɇ',
        readonly   = '',    -- 🔒
        linenr     = ' ㏑:', -- ☰
        maxlinenr  = '',     -- ¶
        branch     = '',    -- 
        dirty      = '[+]',  -- ⚡
        paste      = 'Þ',
        spell      = '﯑',    -- Ꞩ
        whitespace = 'Ξ'
    }
end

configs['skywind3000/asyncrun.vim'] = function()
    g.asyncrun_rootmarks = {'.git', '.svn', '.root'}
end

configs['skywind3000/asyncrun.extra'] = function()
    g['asyncrun_extra#floaterm#title_style'] = 'asyncrun'
    g.asynctasks_term_pos = 'floaterm'
end

configs['skywind3000/asynctasks.vim'] = function()
    api.nvim_set_keymap('n', '<F5>', '<cmd>AsyncTask run<cr>', {})
    api.nvim_set_keymap('n', '<F6>', '<cmd>AsyncTask build<cr>', {})
end

return configs
