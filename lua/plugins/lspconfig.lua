local setmap = vim.keymap.set

local _cfg_lspconfig = {
    'neovim/nvim-lspconfig',
    config = function()
        local servers = {
            lua_ls = {
                single_file_support = true,
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
                    api.nvim_buf_set_keymap(
                        bufnr, 'n', '<M-s>',
                        '<Cmd>ClangdSwitchSourceHeader<cr>', {noremap=true}
                    )
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
            vim.lsp.config[lang] = cfg
            vim.lsp.enable(lang)
            _G.lsp_servers_enabled = true
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('user-lsp-config', { clear = true }),
            callback = function(event)
                -- https://github.com/hendrikmi/neovim-kickstart-config/blob/main
                -- /lua/plugins/lsp.lua
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(
                        mode, keys, func,
                        { buffer = event.buf, desc = 'LSP: ' .. desc }
                    )
                end

                map('gd', require('telescope.builtin').lsp_definitions,
                    '[G]oto [D]efinition')
                map('gr', require('telescope.builtin').lsp_references,
                    '[G]oto [R]eferences')
                map('gI', require('telescope.builtin').lsp_implementations,
                    '[G]oto [I]mplementation')
                map('<leader>D', require('telescope.builtin').lsp_type_definitions,
                    'Type [D]efinition')
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols,
                    '[D]ocument [S]ymbols')
                map('<leader>ws',
                    require('telescope.builtin').lsp_dynamic_workspace_symbols,
                    '[W]orkspace [S]ymbols')
                map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('<leader>ca', vim.lsp.buf.code_action,
                    '[C]ode [A]ction', { 'n', 'x' })
                map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
                map('<M-i>', vim.lsp.buf.hover, 'Show Hover [I]nformation')

                map("]d", function () vim.diagnostic.jump({count = 1}) end,
                    "Next Diagnostic")
                map("[d", function () vim.diagnostic.jump({count = -1}) end,
                    "Next Diagnostic")
                map("]e",
                    function ()
                        vim.diagnostic.jump({
                            count = 1,
                            severity = vim.diagnostic.severity.ERROR
                        })
                    end,
                    "Next Error")
                map("[e", function ()
                        vim.diagnostic.jump({
                            count = -1,
                            severity = vim.diagnostic.severity.ERROR
                        })
                    end,
                    "Next Error")

                -- use illuminate
                -- -- The following two autocommands are used to highlight references of the
                -- -- word under your cursor when your cursor rests there for a little while.
                -- --    See `:help CursorHold` for information about when this is executed
                -- --
                -- -- When you move your cursor, the highlights will be cleared (the second autocommand).
                -- local client = vim.lsp.get_client_by_id(event.data.client_id)
                -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                --     local highlight_augroup = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
                --     vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                --         buffer = event.buf,
                --         group = highlight_augroup,
                --         callback = function ()
                --             -- vim.lsp.buf.hover()
                --             vim.lsp.buf.document_highlight()
                --         end,
                --     })
                --
                --     vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                --         buffer = event.buf,
                --         group = highlight_augroup,
                --         callback = vim.lsp.buf.clear_references,
                --     })
                --
                --     vim.api.nvim_create_autocmd('LspDetach', {
                --         group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
                --         callback = function(event2)
                --             vim.lsp.buf.clear_references()
                --             vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = event2.buf }
                --         end,
                --     })
                -- end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                --
                -- This may be unwanted, since they displace some of your code
                if
                    client
                    and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
                then
                    map(
                        '<leader>th',
                        function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
                            )
                        end,
                        '[T]oggle Inlay [H]ints'
                    )
                end
            end,
        })
    end
}

local _cfg_blink_cmp = {
    'saghen/blink.cmp',
    version = '1.*',
    config = function ()
        require('blink.cmp').setup({
            keymap = {
                preset = 'default',
                ['<C-n>'] = { 'select_next', 'fallback' },
                ['<Tab>'] = { 'select_next', 'fallback' },
                ['<C-p>'] = { 'select_prev', 'fallback' },
                ['<S-Tab>'] = { 'select_prev', 'fallback' },
                ['<CR>'] = { 'accept', 'fallback' },
            },
            cmdline = { enabled = false },
            completion = {
                accept = { auto_brackets = { enabled = true }, },
                documentation = { auto_show = true, auto_show_delay_ms = 500 },
                ghost_text = { enabled = true },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            signature = { enabled = true }
        })
    end
}

local _cfg_telescope = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
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
        setmap('n', ',r', '<Cmd>Telescope resume<CR>', {
            noremap = true, desc = "Telescope: [R]esume last searching"
        })
        setmap('n', ',f', '<Cmd>Telescope find_files<CR>', {
            noremap = true, desc = "Telescope: search [F]iles"
        })
        setmap('n', ',b', '<Cmd>Telescope buffers<CR>', {
            noremap = true, desc = "Telescope: search [B]uffers"
        })
        setmap('n', ',j', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', {
            noremap = true, desc = "Telescope: fuzzy find and [J]ump in current buffer"
        })
        setmap('n', ',g', '<Cmd>Telescope live_grep<CR>', {
            noremap = true, desc = "Telescope: live [G]rep for contents of files"
        })
        setmap('n', ',h', '<Cmd>Telescope command_history<CR>', {
            noremap = true, desc = "Telescope: search Vim command [H]istory"
        })
        setmap('n', ',H', '<Cmd>Telescope help_tags<CR>', {
            noremap = true, desc = "Telescope: search Vim [H]elp tags"
        })
        setmap('n', ',d', '<Cmd>Telescope diagnostics<CR>', {
            noremap = true, desc = "Telescope: search LSP [D]iagnostics"
        })
        setmap('n', ',sb', '<Cmd>Telescope lsp_document_symbols<CR>', {
            noremap = true, desc = "Telescope: search document [S]ymbols in current [B]uffer"
        })
        setmap('n', ',sp', '<Cmd>Telescope lsp_workspace_symbols<CR>', {
            noremap = true, desc = "Telescope: search workspace [S]ymbols in current [P]roject"
        })
    end
}

local _cfg_inline_diagnostic = {
    'rachartier/tiny-inline-diagnostic.nvim',
    config = function ()
        vim.diagnostic.config({ virtual_text = false })
        require('tiny-inline-diagnostic').setup {
            preset = "modern",
            show_all_diags_on_cursorline = false,
            use_icons_from_diagnostic = true,
            set_arrow_to_diag_color = true,
            multilines = {
                enabled = false
            }
        }
    end
}

local _cfg_toggleterm = {
    'akinsho/toggleterm.nvim',
    config = function ()
        require("toggleterm").setup {
            size = 20,
            open_mapping = [[<C-\>]],
            -- clear_env = true,
            autochdir = true,
            on_create = function (term)
                local conda_env = vim.env.CONDA_DEFAULT_ENV
                if conda_env and conda_env ~= "" then
                    term:send(string.format("mamba activate %s", conda_env))
                end
            end,
            winbar = {
                enabled = true,
                name_formatter = function(term)
                    return term.name
                end
            },
        }
    end
}

local _cfg_trouble = {
    "folke/trouble.nvim",
    opts = {
        use_diagnostic_signs = true
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>cs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>cl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}

return {
    _cfg_lspconfig,
    _cfg_blink_cmp,
    _cfg_telescope,
    _cfg_inline_diagnostic,
    _cfg_toggleterm,
    _cfg_trouble,
}
