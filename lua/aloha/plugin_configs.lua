local configs = {}
local g = vim.g
local api = vim.api
local setmap = vim.keymap.set

configs['R-nvim/r.nvim'] = function()
    require("r").setup({
        pipe_version = "native",
        hook = {
            on_filetype = function()
               vim.api.nvim_buf_set_keymap(0, "i", "<M-->", "<Plug>RInsertAssign", { noremap = true })
               vim.api.nvim_buf_set_keymap(0, "i", "<M-.>", "<Plug>RInsertPipe", { noremap = true })
               if vim.bo.filetype == "rnoweb" then
                   vim.api.nvim_buf_set_keymap(0, "i", "<", "<Plug>RnwInsertChunk", { noremap = true })
               elseif vim.bo.filetype == "rmd" or vim.bo.filetype == "quarto" then
                   vim.api.nvim_buf_set_keymap(0, "i", "`", "<Plug>RmdInsertChunk", { noremap = true })
               end
            end,
            after_R_start = function()
                vim.api.nvim_buf_set_keymap(0, "n", "<M-Enter>", "<Plug>RDSendLine", {noremap = true})
                vim.api.nvim_buf_set_keymap(0, "v", "<M-Enter>", "<Plug>RSendSelection", {noremap = true})
            end
        },
        -- register_treesitter = false
    })
end

configs['lukas-reineke/indent-blankline.nvim'] = function()
    require'ibl'.setup {
        exclude = {
            filetypes = {
                "startify", "dashboard", "dotooagenda", "log", "fugitive", "gitcommit",
                "packer", "vimwiki", "markdown", "json", "txt", "vista", "help", "todoist",
                "NvimTree", "peekaboo", "git", "TelescopePrompt", "undotree", "flutterToolsOutline",
                "lspinfo", "checkhealth",  "man",
                "" -- for all buffers without a file type
            },
            buftypes = {"terminal", "nofile", "quickfix", "prompt"},
        },
    }
end

configs['norcalli/nvim-colorizer.lua'] = function()
    vim.opt.termguicolors = true
    require 'colorizer'.setup({
        'markdown', 'html', 'gohtmltmpl', 'rmarkdown',
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
    local expand_name = {
        ["index.md"] = {prefix = "(i)"},
        ["index.Rmd"] = {prefix = "(i.r)"},
        ["_index.md"] = {prefix = "(I)"},
        ["_index.Rmd"] = {prefix = "(I.r)"},
        ["init.lua"] = true,
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

            numbers = { bg=colors.dark_gray, italic=hls_style.normal.italic },
            numbers_selected = { fg=colors.dark_gray, bg=colors.white, italic=hls_style.selected.italic },
            numbers_visible = { bg=colors.gray, italic=hls_style.visible.italic },

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
            name_formatter = function(buf)
                if expand_name[buf.name] then
                    local path_slices = vim.split(buf.path, "/")
                    local basename = path_slices[#path_slices-1]
                    if type(expand_name[buf.name]) == "string" then
                        return basename .. expand_name[buf.name]
                    elseif type(expand_name[buf.name]) == "table" then
                        local bufname
                        if expand_name[buf.name].prefix then
                            bufname = expand_name[buf.name].prefix .. basename
                        end
                        if expand_name[buf.name].suffix then
                            bufname = basename .. expand_name[buf.name].suffix
                        end
                        return bufname
                    else
                        return basename .. "/" .. buf.name
                    end
                else
                    return buf.name
                end
            end,
            tab_size = 18,
            diagnostics = "nvim_lsp",
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
            persist_buffer_sort = true,
            separator_style = { "", "" },
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            sort_by = "id",
        }
    }
    setmap("n", "gb", "<Cmd>BufferLinePick<CR>", {noremap = true, silent = true})
end

configs['nvim-neo-tree/neo-tree.nvim'] = function ()
    vim.fn.sign_define("DiagnosticSignError", {text = "E", texthl = "DiagnosticSignError"})
    vim.fn.sign_define("DiagnosticSignWarn", {text = "W", texthl = "DiagnosticSignWarn"})
    vim.fn.sign_define("DiagnosticSignInfo", {text = "I", texthl = "DiagnosticSignInfo"})
    vim.fn.sign_define("DiagnosticSignHint", {text = "H", texthl = "DiagnosticSignHint"})

    require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
            bind_to_cwd = true
        },
        source_selector = {
            winbar = true,
        },
        window = {
            position = "left",
            width = 40,
            mappings = {
                ["P"] = { 'toggle_preview', config = { use_float = false, use_image_nvim = false } },
                ['s'] = 'open_split',
                ['v'] = 'open_vsplit',
            }
        },
        filtered_items = {
            visible = false,
            show_hidden_count = true
        },
        popup_border_style = "rounded"
    })

    api.nvim_set_hl(0, 'NeoTreeIndentMarker', {
        fg = api.nvim_get_hl(0, {name="Comment"}).fg
    })
    api.nvim_set_hl(0, 'NeoTreeMessage', {
        fg = api.nvim_get_hl(0, {name="Comment"}).fg
    })
    setmap('n', [[<C-CR>]], '<Cmd>Neotree toggle reveal<CR>', {noremap = true})
end

configs['lewis6991/gitsigns.nvim'] = function()
    require('gitsigns').setup {
        numhl              = true,
        current_line_blame = true,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol',
            delay = 200,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        }
    }
end

configs['neovim/nvim-lspconfig'] = function()
    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-config', { clear = true }),
        callback = function(event)
            -- https://github.com/hendrikmi/neovim-kickstart-config/blob/main/lua/plugins/lsp.lua
            local map = function(keys, func, desc, mode)
                mode = mode or 'n'
                vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end

            map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
            map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
            map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            map('<M-i>', vim.lsp.buf.hover, 'Show Hover [I]nformation')

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
                vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = function ()
                        -- vim.lsp.buf.hover()
                        vim.lsp.buf.document_highlight()
                    end,
                })

                vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.clear_references,
                })

                vim.api.nvim_create_autocmd('LspDetach', {
                    group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
                    callback = function(event2)
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
                    end,
                })
            end

            -- The following code creates a keymap to toggle inlay hints in your
            -- code, if the language server you are using supports them
            --
            -- This may be unwanted, since they displace some of your code
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
              map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
              end, '[T]oggle Inlay [H]ints')
            end
        end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {
        lua_ls = {
            single_file_support = true,
            -- root_dir = function(fname)
            --     return util.root_pattern(unpack(lua_root_files))(fname) or util.find_git_ancestor(fname)
            -- end,
            settings = {
                Lua = {
                    completion = {
                        callSnippet = 'Replace',
                    },
                    runtime = { version = 'LuaJIT' },
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            '${3rd}/luv/library',
                            unpack(vim.api.nvim_get_runtime_file('', true)),
                        },
                    },
                    diagnostics = { disable = { 'missing-fields' } },
                    format = {
                        enable = false,
                    },
                },
            }
        },
        rust_analyzer = {
            settings = {
                ['rust-analyzer'] = {
                    diagnostics = {
                        enable = false;
                    }
                }
            }
        },
        vimls = {},
        clangd = {
            -- https://clangd.llvm.org/config#files
            -- specific standard in ~/.config/clangd/config.yaml
            -- or project-specific <project-root>/.clangd
            --
            -- CompileFlags:
            --   Add: [-std=c++23]
            --
            on_attach = function (_, bufnr)
                api.nvim_buf_set_keymap(bufnr, 'n', '<M-s>', '<Cmd>ClangdSwitchSourceHeader<cr>', {noremap=true})
            end,
            cmd = {
                "clangd",
                "--background-index",
                "--suggest-missing-includes",
                "--clang-tidy",
                "--header-insertion=iwyu",
            },
            filetypes = { "c", "cpp", "objc", "objcpp" }
        },
        pyright = {},
        r_language_server = {
            cmd = { "R", "--slave", "--no-echo", "-e", "languageserver::run()" }
        },
        ts_ls = {}, -- https://github.com/pmizio/typescript-tools.nvim
        cssls = {},
        jsonls = {},
        html = {},
        -- jedi_language_server = {},
    }

    for lang, cfg in pairs(servers) do
        cfg.capabilities = vim.tbl_deep_extend('force', {}, capabilities, cfg.capabilities or {})
        vim.lsp.config(lang, cfg)
        vim.lsp.enable(lang)
    end
end

configs['hrsh7th/nvim-cmp'] = function()
    local cmp = require("cmp")
    local snippy = require("snippy")

    local kind_icons = {
        Text = '󰉿', Method = 'm', Function = '󰊕', Constructor = '',
        Field = '', Variable = '󰆧', Class = '󰌗', Interface = '', Module = '',
        Property = '', Unit = '', Value = '󰎠', Enum = '', Keyword = '󰌋',
        Snippet = '', Color = '󰏘', File = '󰈙', Reference = '', Folder = '󰉋',
        EnumMember = '', Constant = '󰇽', Struct = '', Event = '',
        Operator = '󰆕', TypeParameter = '󰊄',
    }

    cmp.setup({
        snippet = {
            expand = function(args)
                require'snippy'.expand_snippet(args.body) -- For snippy users.
            end,
        },
        sources = cmp.config.sources({ -- group 1
            { name = 'nvim_lsp' },
            { name = 'cmp_r' },   -- for R.nvim
            { name = 'snippy' }, -- For snippy users.
            { name = 'omni' },
        }, {                           -- group 2
            { name = 'buffer' },
            { name = 'path', option = { trailing_slash = true }},
        }),
        mapping = {
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif snippy.can_expand_or_advance() then
                    snippy.expand_or_advance()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif snippy.can_jump(1) then
                    snippy.previous()
                else
                    fallback()
                end
            end, { 'i', 's' }),

            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),

            -- ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-Space>'] = cmp.config.disable,

            ['<C-y>'] = cmp.mapping.confirm { select = true },
            ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),

            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),

            -- snippy
            ['<C-l>'] = cmp.mapping(function()
                if snippy.can_expand_or_advance() then
                    snippy.expand_or_advance()
                end
            end, { 'i', 's' }),
            ['<C-h>'] = cmp.mapping(function()
                if snippy.can_jump(1) then
                    snippy.next()
                end
            end, { 'i', 's' }),
            ['<M-s>'] = cmp.mapping.complete({
                config = {
                    sources = {
                        { name = 'snippy' }
                    }
                }
            })
        },
        preselect = cmp.PreselectMode.Item,
        completion = {
            completeopt = 'menu,menuone,noinsert'
        },
        experimental = {
            -- native_menu = true
        },
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, vim_item)
              vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
              vim_item.menu = ({
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                buffer = '[Buffer]',
                path = '[Path]',
              })[entry.source.name]
              return vim_item
            end,
        }
    })
    -- For markdown filetype
    -- au FileType markdown lua cmp.setup.buffer({})
    -- For nvim-autopairs
    -- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    -- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
end

configs['nvim-telescope/telescope.nvim'] = function()
    local telescope = require('telescope')
    -- telescope.load_extension('fzy_native')
    -- telescope.load_extension('fzf')
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
            border = true,
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

    -- keybindings
    setmap('n', ',t', '<Cmd>Telescope resume<CR>', {noremap = true})
    setmap('n', ',f', '<Cmd>Telescope find_files<CR>', {noremap = true})
    setmap('n', ',F', '<Cmd>Telescope file_browser<CR>', {noremap = true})
    setmap('n', ',b', '<Cmd>Telescope buffers<CR>', {noremap = true})
    setmap('n', ',g', '<Cmd>Telescope live_grep<CR>', {noremap = true})
    setmap('n', ',h', '<Cmd>Telescope help_tags<CR>', {noremap = true})
end

configs['RRethy/vim-illuminate'] = function()
    require('illuminate').configure({
        providers = {'lsp', 'treesitter', 'regex'},
        filetypes_denylist = {'dashboard', 'NvimTree', 'markdown', 'rmd', 'tex', ''},
        under_cursor = true,
        modes_denylist = {},
        large_file_overrides = 1000,
        large_file_config = {},
    })
    setmap('n', '<M-n>', '<Cmd>lua require"illuminate".next_reference{wrap=true}<CR>', {noremap=true})
    setmap('n', '<M-p>', '<Cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>', {noremap=true})
    setmap('n', '<M-i>', '<Cmd>lua require("illuminate").textobj_select()<CR>', {noremap=true})
    api.nvim_set_hl(0, "IlluminatedWordText", {italic=true, bg="#53565d"})
    api.nvim_set_hl(0, "IlluminatedWordRead", {link="IlluminatedWordText"})
    api.nvim_set_hl(0, "IlluminatedWordWrite", {link="IlluminatedWordText"})
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

configs['ggandor/leap.nvim'] = function ()
    local leap = require('leap')
    leap.add_default_mappings()
    leap.opt.special_keys = {
        next_target = '<Tab>',
        prev_target = '<S-Tab>',
        next_group = '<Space>',
        prev_group = '<S-Tab>',
        multi_accept = '<enter>',
        multi_revert = '<backspace>',
    }
end

configs['folke/flash.nvim'] = function ()
    setmap({'n', 'x', 'o'}, '<C-s>', function()
        require("flash").jump({
            prompt = { enabled = false }
        })
    end)
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
    setmap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
    setmap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
end

configs['nvim-treesitter/nvim-treesitter'] = function()
    api.nvim_command('set foldmethod=expr')
    api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
    -- require("nvim-treesitter.install").command_extra_args = {
    --     curl = { "--proxy", "<proxy url>" },
    -- }
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            'c', 'cpp', 'python', 'css', 'bash', 'cmake', 'glsl', 'go', 'html',
            'javascript', 'lua', 'r', 'ruby', 'rust', 'toml', 'vim', 'vue',
            'yaml', 'markdown', 'rnoweb', 'latex'
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
            disable = {'markdown'},
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
    setmap('n', '<leader>vt', '<Cmd>Vista<Cr>', {noremap = true})
    setmap('n', ',T', '<Cmd>Vista finder<Cr>', {noremap = true})
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
    g.vista_close_on_jump                = 1
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
    g.NERDCommentEmptyLines = 0
    g.NERDTrimTrailingWhitespace = 1
    g.NERDToggleCheckAllLines = 1
end

configs['mbbill/undotree'] = function()
    setmap('n', '<leader>ut', '<Cmd>UndotreeToggle<CR>', {noremap = true})
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

configs['SirVer/ultisnips'] = function()
    g.UltiSnipsEditSplit = "vertical"
    g.UltiSnipsRemoveSelectModeMappings = 0
    g.UltiSnipsExpandTrigger = "<C-Space>"
    g.UltiSnipsJumpForwardTrigger = "<M-j>"
    g.UltiSnipsJumpBackwardTrigger = "<M-k>"
end


configs['dcampos/nvim-snippy'] = function()
    require('snippy').setup({
        snippet_dirs = '~/.config/nvim/snippets',
        local_snippet_dir = '.snippets',
        enable_auto = true,
        mappings = {
            is = {
                ['<Tab>'] = 'expand_or_advance',
                ['<S-Tab>'] = 'previous',
            },
            nx = {
                ['<leader>x'] = 'cut_text',
            },
        },
        expand_options = {
            m = function()
                return vim.fn["vimtex#syntax#in_mathzone"] and vim.fn["vimtex#syntax#in_mathzone"]() == 1
            end,
            c = function()
                return vim.fn["vimtex#syntax#in_comment"] and vim.fn["vimtex#syntax#in_comment"]() == 1
            end,
        }
    })
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
        cwd = g.hugowiki_home,
        r_script = g.hugowiki_home .. 'utils/R/build_one.R',
    }
    g.hugowiki_spellcheck_ignore_upcase = 1
    g.hugowiki_snippy_integration = 1
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

configs['dhruvasagar/vim-table-mode'] = function()
    setmap("n", "<leader>tm", "<cmd>TableModeToggle<cr>", {noremap = true})
    g.table_mode_corner = '|'
    g.table_mode_corner_corner="|"
    g.table_mode_align_char=":"
    g.table_mode_header_fillchar="-"
    g.table_mode_delimiter = ','
end

configs['svermeulen/vim-subversive'] = function()
    g.subversiveCurrentTextRegister = 1
    setmap('n', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    setmap('x', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    setmap('x', 'p',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    setmap('x', 'P',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
    setmap('n', 'ss',                 '<plug>(SubversiveSubstituteLine)',             { noremap = false })
    setmap('n', 'S',                  '<plug>(SubversiveSubstituteToEndOfLine)',      { noremap = false })
    setmap('n', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false })
    setmap('x', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false })
    setmap('n', '<leader>ss',         '<plug>(SubversiveSubstituteWordRange)',        { noremap = false })
    setmap('n', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false })
    setmap('x', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false })
    setmap('n', '<leader>crr',        '<plug>(SubversiveSubstituteWordRangeConfirm)', { noremap = false })
    setmap('n', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false })
    setmap('x', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false })
    setmap('n', '<leader><leader>ss', '<plug>(SubversiveSubvertWordRange)',           { noremap = false })
end

configs['svermeulen/vim-yoink'] = function()
    setmap('n', 'p', '<plug>(YoinkPaste_p)', {noremap=false})
    setmap('n', 'P', '<plug>(YoinkPaste_P)', {noremap=false})
    setmap('n', 'gp', '<plug>(YoinkPaste_gp)', {noremap=false})
    setmap('n', 'gP', '<plug>(YoinkPaste_gP)', {noremap=false})
    setmap('n', '[s', '<plug>(YoinkPostPasteSwapBack)', {noremap=false})
    setmap('n', ']s', '<plug>(YoinkPostPasteSwapForward)', {noremap=false})
    setmap('n', '[y', '<plug>(YoinkRotateBack)', {noremap=false})
    setmap('n', ']y', '<plug>(YoinkRotateForward)', {noremap=false})
    setmap('n', 'y', '<plug>(YoinkYankPreserveCursorPosition)', {noremap=false})
    setmap('x', 'y', '<plug>(YoinkYankPreserveCursorPosition)', {noremap=false})
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
    g.floaterm_keymap_prev   = '<F5>'
    g.floaterm_keymap_next   = '<F6>'
    g.floaterm_keymap_new    = '<F3>'
    g.floaterm_keymap_kill   = '<F4>'
    g.floaterm_gitcommit     = 'floaterm'
    g.floaterm_autoinsert    = 1
    g.floaterm_width         = 0.5
    g.floaterm_height        = 0.5
    g.floaterm_autoclose     = 1
    g.floaterm_title         = '   floaterm: $1/$2 '
    g.floaterm_wintype       = 'popup'
    g.floaterm_position      = 'bottomright'
    g.floaterm_borderchars   = '─│─│╭╮╯╰'

    vim.api.nvim_set_hl(0, "FloatermBorder", { link = "Normal" })
end

configs['akinsho/toggleterm.nvim'] = function()
    require("toggleterm").setup{
        size = function()
            return math.floor(vim.o.lines * 0.3 + 0.5)
        end,
        open_mapping = [[<c-\>]],
        direction = 'horizontal',
          winbar = {
            enabled = true,
            name_formatter = function(term)
                return term.name
            end
        },
    }
    -- function _G.set_terminal_keymaps()
    --     local opts = { buffer = 0 }
    --     ...
    -- end

    -- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
    -- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
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
                -- ['［'] = '］',
                -- ['「'] = '」',
                -- ['【'] = '】',
                -- ['〔'] = '〕',
                -- ['“'] = '”',
                -- ['‘'] = '’',
                -- ['（'] = '）',
                -- ['《'] = '》',
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

configs['olimorris/onedarkpro.nvim'] = function()
    vim.opt.background = "dark"
    local transparentbg = _G.aloha.configs.transparency == nil and true or _G.aloha.configs.transparency
    require("onedarkpro").setup({
        colors = {},
        highlights = {
            Conceal = { link = "Normal" },
            -- Keyword = { gui = "italic" }
        },
        styles = {},
        filetypes = {},
        plugins = {
            all = false,
            nvim_lsp = true,
            polygot = false,
            treesitter = true
        },
        options = {
            underline = true,
            cursorline = true,
            transparency = transparentbg,
            lualine_transparency = transparentbg,
            terminal_colors = true,
            window_unfocussed_color = false,
        }
    })
    vim.cmd.colorscheme("onedark")
end

configs['nvim-lualine/lualine.nvim'] = function()
    local function spelllang()
        return string.upper(table.concat(vim.opt.spelllang:get(), ','))
    end
    local function saga()
        local wb = require('lspsaga.symbolwinbar'):get_winbar()
        if wb ~= nil then
            return wb
        else
            return ''
        end
    end
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = { left = '┆', right = '┆'}, -- 
            section_separators = { left = '┆', right = '┆'},
            disabled_filetypes = { 'toggleterm' },
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                { 'filetype', color = { bg='#2c323c' } },
                { 'filename' },
                { saga },
                { require("r.utils").get_lang }
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

configs['skywind3000/asyncrun.vim'] = function()
    g.asyncrun_rootmarks = {'.git', '.svn', '.root'}
end

configs['skywind3000/asyncrun.extra'] = function()
    g['asyncrun_extra#floaterm#title_style'] = 'asyncrun'
    g.asynctasks_term_pos = 'floaterm'
end

configs['skywind3000/asynctasks.vim'] = function()
    setmap('n', '<F5>', '<cmd>AsyncTask run<cr>', {})
    setmap('n', '<F6>', '<cmd>AsyncTask build<cr>', {})
end

configs['mfussenegger/nvim-dap'] = function()
    local dap = require('dap')
    dap.adapters.debugpy = {
        type = 'executable';
        command = os.getenv('HOME') .. '/.virtualenvs/tools/bin/python';
        args = { '-m', 'debugpy.adapter' };
    }
end

return configs
