return {
    -- lsp, completion and snippets
    ['neovim/nvim-lspconfig'] = {},
    ['mfussenegger/nvim-lint'] = {
        config = function ()
            require('lint').linters_by_ft = {
                markdown = {'vale'},
                bash = {'bash'},
                zsh = {'zsh'},
                cpp = {'clang-tidy'},
                lua = {'luacheck'},
                python = {'ruff'}
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end
    },
    -- ['hrsh7th/nvim-cmp'] = {
    --     dependencies = {
    --         'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
    --         'hrsh7th/cmp-omni',
    --         'dcampos/cmp-snippy',
    --     }
    -- },
    -- ['hrsh7th/cmp-nvim-lsp'] = { opt=true },
    -- ['hrsh7th/cmp-buffer']   = { opt=true },
    -- ['hrsh7th/cmp-path']     = { opt=true },
    -- ['hrsh7th/cmp-omni']     = { opt=true },
    -- ['onsails/lspkind-nvim'] = { disable=true, opt=true },
    -- ['nvimdev/lspsaga.nvim'] = { disable=true, opt=true, event='BufRead', branch = 'main' },
    ['saghen/blink.cmp'] = {
        config = function ()
            require('blink.cmp').setup({
                keymap = { preset = 'default' },
                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = 'mono'
                },
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
            })
        end,
        run = '!cargo build --release'
    },
    ['j-hui/fidget.nvim'] = {
        config = function ()
            require("fidget").setup {
                notification = {
                    override_vim_notify = true,
                    view = {
                        reflow = true
                    },
                    window = {
                        normal_hl = "Comment",
                        winblend = 0,
                        avoid = { "NvimTree", "Outline", "aerial-nav", "aerial" },
                    }
                },
            }
            require("telescope").load_extension("fidget")
            vim.keymap.set('n', ',n', '<Cmd>Telescope fidget<CR>', {
                noremap = true, desc = "Telescope: Fidget notifications"
            })
        end,
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
    ['rachartier/tiny-inline-diagnostic.nvim'] = {
        config = function ()
            vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
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
    },
    -- snippets
    ['dcampos/nvim-snippy'] = {},
    ['dcampos/cmp-snippy'] = { opt=true },

    -- ui and appearance
    ['mhinz/vim-startify'] = { dependencies = {'kyazdani42/nvim-web-devicons'} },
    ['olimorris/onedarkpro.nvim'] = {},
    ['nvim-lualine/lualine.nvim'] = {},
    ['lukas-reineke/indent-blankline.nvim'] = {},
    ['akinsho/bufferline.nvim'] = {},
    ['nvim-neo-tree/neo-tree.nvim'] = {
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
            's1n7ax/nvim-window-picker'
        }
    },
    ['s1n7ax/nvim-window-picker'] = {
        config = function ()
            require('window-picker').setup {
                hint = 'floating-big-letter',
                show_prompt = false,
                picker_config = {
                    autoselect_one = true,
                    filter_rules = {
                        include_current_win = false,
                        handle_mouse_click = true,
                        filter_func = nil,
                        include_unfocusable_windows = false,
                        bo = {
                            filetype = { 'NvimTree', 'neo-tree', 'notify', 'snacks_notif' },
                            buftype = { 'terminal' },
                        },
                        wo = {}
                    }
                }
            }

            vim.keymap.set("n", "<C-w><C-w>", function ()
                local winid = require('window-picker').pick_window()
                vim.api.nvim_set_current_win(winid)
            end, { desc = "Pick a window" })
        end
    },
    ['MagicDuck/grug-far.nvim'] = {
        config = function ()
            require('grug-far').setup({})
        end
    },
    ['lewis6991/gitsigns.nvim'] = {
        dependencies = 'nvim-lua/plenary.nvim'
    },
    ['liuchengxu/vista.vim'] = { disable = true },
    ['mbbill/undotree'] = {},
    -- ['voldikss/vim-floaterm'] = {},
    ['akinsho/toggleterm.nvim'] = {
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
    },
    ['nvim-telescope/telescope.nvim'] = {
        map = {
            {mode = 'n', lhs = ',g'},
            {mode = 'n', lhs = ',f'}
        },
        dependencies = {
            'nvim-lua/plenary.nvim',
        }
    },
    ['RRethy/vim-illuminate'] = {},
    ['norcalli/nvim-colorizer.lua'] = {},
    -- dependencies
    ['nvim-lua/plenary.nvim'] = { opt = true },
    ['kyazdani42/nvim-web-devicons'] = { opt = true },
    ['MunifTanjim/nui.nvim'] = { opt = true },
    ["hedyhli/outline.nvim"] = {
        config = function()
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
            require("outline").setup {
                auto_close = true
            }
        end
    },

    -- text editing
    ['luochen1990/rainbow'] = {},
    ['alohaia/hugowiki.nvim'] = {
        dependencies = {
            'nvim-telescope/telescope.nvim'
        }
    },
    ['lervag/vimtex'] = {},
    ['rhysd/clever-f.vim'] = { disable=true },
    ['ggandor/leap.nvim'] = { disable=true },
    ['folke/flash.nvim'] = {},
    ['brooth/far.vim'] = {},
    ['rainbowhxch/accelerated-jk.nvim'] = {},
    ['preservim/nerdcommenter'] = { disable=true },
    ['numToStr/Comment.nvim'] = {
        config = function ()
            require('Comment').setup()

            local cmt = require('Comment.api')
            local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
            vim.keymap.set({'n', 'x'}, '<C-/>', function()
                if vim.fn.mode() == "\22" then
                    vim.api.nvim_feedkeys(esc, 'nx', false)
                    cmt.toggle.blockwise("v")
                elseif vim.fn.mode() == "V" or vim.fn.mode() == "v" then
                    vim.api.nvim_feedkeys(esc, 'nx', false)
                    cmt.toggle.linewise("V")
                else
                    cmt.toggle.linewise()
                end
            end, { noremap = true })
        end
    },
    ['tpope/vim-surround'] = {},
    ['tpope/vim-repeat'] = {},
    ['dhruvasagar/vim-table-mode'] = { ft='rmd,markdown,text' },
    ['bullets-vim/bullets.vim'] = {
        disable = true,
        config = function ()
            vim.g.bullets_enabled_file_types = { 'markdown', 'text', 'gitcommit', 'scratch' }
            vim.g.bullets_pad_right = 0
            vim.g.bullets_outline_levels = { 'num', 'abc', 'std-' }
            vim.g.bullets_renumber_on_change = 1
            vim.g.bullets_nested_checkboxes = 1
            vim.g.bullets_checkbox_markers = ' X'
        end
    },
    ['alohaia/bullets.nvim'] = {
        disable = false,
        config = function ()
            vim.g["bullets#renumber_on_change"] = true
        end
    },
    ['jake-stewart/multicursor.nvim'] = {},
    ['cohama/lexima.vim'] = {}, -- auto-pairs plugin works well with multicursor.nvim
    ['mattn/emmet-vim'] = {},
    ['godlygeek/tabular'] = {
        config = [[:cnorea Tbu Tabularize]]
    },
    ['alohaia/fcitx.nvim'] = {
        ft = 'rmd,markdown,text,tex',
        config = function ()
            require 'fcitx' {
                enable = {
                    select = "insert",
                },
            }
        end
    },

    -- git
    ['tpope/vim-fugitive'] = {},

    -- syntax highlight
    ['nvim-treesitter/nvim-treesitter'] = {
        branch = "main",
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context'
        },
    },
    ['nvim-treesitter/nvim-treesitter-textobjects'] = { branch = "main" },
    ['nvim-treesitter/nvim-treesitter-context'] = {
        config = function ()
            require'treesitter-context'.setup {
                enable = false,
                multiwindow = true
            }
            vim.keymap.set("n", "<Leader>tc", function()
                require"treesitter-context".toggle()
            end, { desc = "Toggle treesitter-context" })
        end
    },
    ['fladson/vim-kitty'] = { ft='kitty' },
    ['fatih/vim-go'] = { ft='go,gohtmltmpl' },

    ['nvim-mini/mini.icons'] = { opt=true },
    ['folke/which-key.nvim'] = {
        config = function ()
            vim.keymap.set("n", "<leader>?", function()
                require("which-key").show({ global = false })
            end, { desc = "Buffer Local Keymaps (which-key)" })
        end,
        dependencies = 'nvim-mini/mini.icons'
    },

    -- R
    ['R-nvim/r.nvim'] = {},
    -- ['R-nvim/cmp-r'] = {
    --     config = function()
    --         require("cmp_r").setup({})
    --     end,
    -- },

    -- test
    ['dstein64/vim-startuptime'] = { disable = true },


    -- debug
    ["mfussenegger/nvim-dap"] = {},
}
