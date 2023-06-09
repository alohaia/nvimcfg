return {
    -- lsp, completion and snippets
    ['neovim/nvim-lspconfig'] = {
        dependency = {
            'glepnir/lspsaga.nvim'
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
    ['glepnir/lspsaga.nvim'] = { opt=true, event='BufRead', branch = 'main' },
    -- snippets
    ['dcampos/nvim-snippy'] = {
        config = function ()
            require('snippy').setup({
                mappings = {
                    is = {
                        ['<Tab>'] = 'expand_or_advance',
                        ['<S-Tab>'] = 'previous',
                    },
                    nx = {
                        ['<leader>x'] = 'cut_text',
                    },
                },
            })
        end
    },
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
    ['akinsho/toggleterm.nvim'] = {},
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
    ['rhysd/clever-f.vim'] = {},
    ['brooth/far.vim'] = {},
    ['rainbowhxch/accelerated-jk.nvim'] = {},
    ['preservim/nerdcommenter'] = {},
    ['tpope/vim-surround'] = {},
    ['tpope/vim-repeat'] = {},
    ['dhruvasagar/vim-table-mode'] = { ft='rmd,markdown,text' },
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

    -- test
    ['dstein64/vim-startuptime'] = { disable = true },
}
