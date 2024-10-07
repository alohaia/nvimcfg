return {
    -- lsp, completion and snippets
    ['neovim/nvim-lspconfig'] = {
        dependencies = {
            'nvimdev/lspsaga.nvim'
        }
    },
    ['hrsh7th/nvim-cmp'] = {
        dependencies = {
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
        }
    },
    ['lewis6991/gitsigns.nvim'] = {
        dependencies = 'nvim-lua/plenary.nvim'
    },
    ['liuchengxu/vista.vim'] = {},
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
    ['preservim/nerdcommenter'] = {},
    ['tpope/vim-surround'] = {},
    ['tpope/vim-repeat'] = {},
    ['dhruvasagar/vim-table-mode'] = { ft='rmd,markdown,text' },
    ['alohaia/bullets.nvim'] = {},
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
        dependencies = 'nvim-treesitter/nvim-treesitter-textobjects'
    },
    ['nvim-treesitter/nvim-treesitter-textobjects'] = { opt=true },
    ['fladson/vim-kitty'] = { ft='kitty' },
    ['fatih/vim-go'] = { ft='go,gohtmltmpl' },

    -- R
    ['R-nvim/r.nvim'] = {},
    ['R-nvim/cmp-r'] = {
        config = function()
            require("cmp_r").setup({})
        end,
    },

    -- test
    ['dstein64/vim-startuptime'] = { disable = true },
}
