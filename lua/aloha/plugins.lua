return {
    -- lsp, completion and snippets
    ['neovim/nvim-lspconfig'] = {
        dependencies = { 'hrsh7th/cmp-nvim-lsp' }
    },
    ['hrsh7th/nvim-cmp'] = {
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-omni',
            'dcampos/cmp-snippy',
        }
    },
    ['hrsh7th/cmp-nvim-lsp'] = { opt=true },
    ['hrsh7th/cmp-buffer']   = { opt=true },
    ['hrsh7th/cmp-path']     = { opt=true },
    ['hrsh7th/cmp-omni']     = { opt=true },
    ['onsails/lspkind-nvim'] = { disable=true, opt=true },
    ['nvimdev/lspsaga.nvim'] = { disable=true, opt=true, event='BufRead', branch = 'main' },
    ['j-hui/fidget.nvim'] = {
        config = function ()
            require("fidget").setup {}
            require("telescope").load_extension("fidget")
        end,
        dependencies = { 'nvim-telescope/telescope.nvim' }
    },
    ['rachartier/tiny-inline-diagnostic.nvim'] = {
        config = function ()
            vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
            require('tiny-inline-diagnostic').setup {
                preset = "modern",
                show_all_diags_on_cursorline = false
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
            'folke/snacks.nvim'
        }
    },
    ['folke/snacks.nvim'] = {},
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
    ['voldikss/vim-floaterm'] = {},
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
    ['rcarriga/nvim-notify'] = { opt = true },
    ['folke/noice.nvim'] = {
        -- disable = true,
        config = function ()
            require("notify").setup({
                background_colour = "#000000",
            })

            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
                documentation = {
                    view = "hover",
                    ---@type NoiceViewOptions
                    opts = {
                        lang = "markdown",
                        replace = true,
                        render = "plain",
                        format = { "{message}" },
                        win_options = {
                            concealcursor = "n",
                            conceallevel = 3,
                            winhighlight = {
                                Normal = "Normal",
                                FloatBorder = "Normal",
                            }
                        },
                    },
                },
            })
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    },
    ["Isrothy/neominimap.nvim"] = {
        config = function ()
            vim.g.neominimap = {
                auto_enable = false
            }
        end
    },
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
    ['stevearc/aerial.nvim'] = {
        config = function ()
            require("aerial").setup({
                backends = {
                    ['_']  = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
                    -- rmd = { "treesitter", "lsp", "markdown", "asciidoc", "man" }
                },
                -- optionally use on_attach to set keymaps when aerial has attached to a buffer
                on_attach = function(bufnr)
                    -- Jump forwards/backwards with '{' and '}'
                    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
                end,
                placement = "edge",
            })
            vim.keymap.set("n", "<leader>ae", "<cmd>AerialToggle!<CR>")
            vim.keymap.set("n", "<leader>an", "<cmd>AerialNavToggle<CR>")
        end
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
    ['svermeulen/vim-subversive'] = {},
    ['svermeulen/vim-yoink'] = {},
    ['mg979/vim-visual-multi'] = {},
    ['jiangmiao/auto-pairs'] = {},
    ['RRethy/nvim-treesitter-endwise'] = {
        config = function ()
            require('nvim-treesitter.configs').setup { endwise = { enable = true } }
        end
    },
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
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects'
    },
    ['nvim-treesitter/nvim-treesitter-textobjects'] = { opt=true },
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
