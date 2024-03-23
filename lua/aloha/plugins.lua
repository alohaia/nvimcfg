return {
    -- lsp, completion and snippets
    ['neovim/nvim-lspconfig'] = {
        dependency = {
            'nvimdev/lspsaga.nvim'
        }
    },
    ['hrsh7th/nvim-cmp'] = {
        dependency = {
            'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
            'hrsh7th/cmp-omni',
            'dcampos/cmp-snippy',
            -- 'quangnguyen30192/cmp-nvim-ultisnips',
            -- 'saadparwaiz1/cmp_luasnip',
            'onsails/lspkind-nvim',
        }
    },
    ['hrsh7th/cmp-nvim-lsp'] = { opt=true },
    ['hrsh7th/cmp-buffer']   = { opt=true },
    ['hrsh7th/cmp-path']     = { opt=true },
    ['hrsh7th/cmp-omni']     = { opt=true },
    ['onsails/lspkind-nvim'] = { opt=true },
    ['nvimdev/lspsaga.nvim'] = { opt=true, event='BufRead', branch = 'main' },
    -- snippets
    ['dcampos/nvim-snippy'] = {},
    ['dcampos/cmp-snippy'] = { opt=true },
    -- ['SirVer/ultisnips'] = {},
    -- ['quangnguyen30192/cmp-nvim-ultisnips'] = { opt=true },
    -- ['L3MON4D3/LuaSnip'] = {},
    -- ['saadparwaiz1/cmp_luasnip'] = {opt=true},

    -- ui and appearance
    ['mhinz/vim-startify'] = { dependency = {'kyazdani42/nvim-web-devicons'} },
    ['olimorris/onedarkpro.nvim'] = {},
    ['nvim-lualine/lualine.nvim'] = {},
    ['kyazdani42/nvim-web-devicons'] = { opt = true },
    ['lukas-reineke/indent-blankline.nvim'] = {},
    ['akinsho/bufferline.nvim'] = {},
    ['kyazdani42/nvim-tree.lua'] = {
        cmd = 'NvimTreeToggle',
        map = {
            {mode = 'n', lhs = '<leader>nt'},
        }
    },
    ['lewis6991/gitsigns.nvim'] = {
        dependency = 'nvim-lua/plenary.nvim'
    },
    ['liuchengxu/vista.vim'] = {},
    ['mbbill/undotree'] = {},
    ['voldikss/vim-floaterm'] = {},
    ['nvim-telescope/telescope.nvim'] = {
        cmd = 'Telescope',
        map = {
            { mode = 'n', lhs = ',f' },
            { mode = 'n', lhs = ',b' },
            { mode = 'n', lhs = ',F' },
            { mode = 'n', lhs = ',g' },
        },
        dependency = {
            'nvim-lua/plenary.nvim',
        }
    },
    ['RRethy/vim-illuminate'] = {},
    ['norcalli/nvim-colorizer.lua'] = {},
    -- dependencies
    ['nvim-lua/plenary.nvim'] = { opt=true },

    -- text editing
    ['luochen1990/rainbow'] = {},
    ['alohaia/hugowiki.nvim'] = {},
    ['lervag/vimtex'] = {},
    ['rhysd/clever-f.vim'] = { disable=true },
    ['ggandor/leap.nvim'] = { disable=true },
    ['folke/flash.nvim'] = {},
    ['brooth/far.vim'] = {},
    ['rainbowhxch/accelerated-jk.nvim'] = {},
    ['preservim/nerdcommenter'] = {},
    ['tpope/vim-surround'] = {},
    ['tpope/vim-repeat'] = {},
    ['dhruvasagar/vim-table-mode'] = { ft='rmd,markdown,text' },
    ['bullets-vim/bullets.vim'] = {
        config = function ()
            vim.g.bullets_enabled_file_types = {'rmd', 'markdown', 'text'}
            vim.g.bullets_set_mappings = 0
            vim.g.bullets_custom_mappings = {
                {'imap', '<cr>', '<Plug>(bullets-newline)'},
                {'nmap', 'o', '<Plug>(bullets-newline)'},
                {'vmap', 'gN', '<Plug>(bullets-renumber)'},
                {'nmap', 'gN', '<Plug>(bullets-renumber)'},
                {'nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)'},
                {'imap', '<C-t>', '<Plug>(bullets-demote)'},
                {'nmap', '>>', '<Plug>(bullets-demote)'},
                {'vmap', '>', '<Plug>(bullets-demote)'},
                {'imap', '<C-d>', '<Plug>(bullets-promote)'},
                {'nmap', '<<', '<Plug>(bullets-promote)'},
                {'vmap', '<', '<Plug>(bullets-promote)'}
            }
            vim.g.bullets_pad_right = 0 -- no extra space between bullet and text
            vim.g.bullets_auto_indent_after_colon = 1
            vim.g.bullets_outline_levels = {'std-', 'std*', 'std+'}
            vim.g.bullets_renumber_on_change = 1
            vim.g.bullets_nested_checkboxes = 1
            vim.g.bullets_checkbox_markers = ' X'
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

    -- task
    ['skywind3000/asyncrun.vim'] = { disable = true },
    ['skywind3000/asyncrun.extra'] = { disable = true },
    ['skywind3000/asynctasks.vim'] = { disable = true },

    -- syntax highlight
    ['nvim-treesitter/nvim-treesitter'] = {
        dependency = 'nvim-treesitter/nvim-treesitter-textobjects'
    },
    ['nvim-treesitter/nvim-treesitter-textobjects'] = { opt=true },
    ['fladson/vim-kitty'] = { ft='kitty' },
    ['fatih/vim-go'] = { ft='go,gohtmltmpl' },

    -- test
    ['dstein64/vim-startuptime'] = { disable = true },
}
