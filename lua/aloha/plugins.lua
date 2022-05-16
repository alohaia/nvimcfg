return {
    -- completion
    ['neovim/nvim-lspconfig']         = {
        ft = {
            'lua',                          -- sumneko_lua
            'c', 'cpp', 'objc', 'objcpp',   -- clangd
            'sh',                           -- bashls
            'python',                       -- pyright
            'r', 'rmd',                     -- r_language_server
            'javascript', 'javascriptreact', 'javascript.jsx', 'typescript',
                'typescriptreact', 'typescript.tsx', -- tsserver
            'css', 'scss', 'less',          -- ccsls
            'json', 'jsonc',                -- jsonls
            'html',                         -- html
        }
    },
    ['hrsh7th/nvim-cmp']              = {},
    ['hrsh7th/cmp-nvim-lsp']          = {},
    ['hrsh7th/cmp-buffer']            = {},
    ['hrsh7th/cmp-path']              = {},
    ['quangnguyen30192/cmp-nvim-ultisnips'] = {},
    ['glepnir/lspsaga.nvim']          = {disable = true},
    ['onsails/lspkind-nvim']          = {},
    ['SirVer/ultisnips']              = {},

    -- ui
    ['mhinz/vim-startify'] = {},
    ['alohaia/onedark.vim'] = {disable = true},
    ['olimorris/onedarkpro.nvim'] = {},
    ['nvim-lualine/lualine.nvim'] = {},
    ['rafalbromirski/vim-airlineish'] = {disable = true},
    ['vim-airline/vim-airline'] = {
        disable = true,
        config=[[:let g:airline_theme = 'onedark']]
    },
    ['kyazdani42/nvim-web-devicons'] = {opt = true},
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
    ['akinsho/toggleterm.nvim'] = {disable=true},
    ['glepnir/zephyr-nvim'] = {disable = true, config = [[:colorscheme zephyr]]},
    ['glepnir/dashboard-nvim'] = {disable = true},
    ['glepnir/galaxyline.nvim'] = {disable = true, branch = 'main'},
    ['fatih/vim-go'] = {},
    ['nvim-telescope/telescope.nvim'] = {
        cmd = 'Telescope',
        map = {
            {mode = 'n', lhs = ',f'},
            {mode = 'n', lhs = ',b'},
            {mode = 'n', lhs = ',F'},
            {mode = 'n', lhs = ',g'},
        },
        dependency = {
            'nvim-lua/plenary.nvim',
            'nvim-lua/popup.nvim',
            'nvim-telescope/telescope-fzy-native.nvim'
        }
    },

    -- editor
    ['RRethy/vim-illuminate'] = {},
    ['luochen1990/rainbow'] = {},
    ['alohaia/hugowiki.nvim'] = {},
    ['rhysd/clever-f.vim'] = {},
    ['norcalli/nvim-colorizer.lua'] = {},
    ['brooth/far.vim'] = {},
    ['preservim/nerdcommenter'] = {},
    ['tpope/vim-capslock'] = {},
    ['tpope/vim-surround'] = {},
    ['tpope/vim-repeat'] = {},
    ['dkarter/bullets.vim'] = {},   -- use `vim.g.bullets_enabled_file_types`
    ['dhruvasagar/vim-table-mode'] = {ft='rmd,markdown,text'},
    ['svermeulen/vim-subversive'] = {},
    ['mg979/vim-visual-multi'] = {},
    ['jiangmiao/auto-pairs'] = {},
    ['mattn/emmet-vim'] = {};
    ['godlygeek/tabular'] = {
        config = [[:cnorea Tab Tabularize]]
    },
    ['jalvesaq/Nvim-R'] = {disable = true, ft = 'r', branch = 'master'},
    ['skywind3000/asyncrun.vim'] = {disable = true},
    ['skywind3000/asyncrun.extra'] = {disable = true},
    ['skywind3000/asynctasks.vim'] = {disable = true},
    ['lilydjwg/fcitx.vim'] = {
        ft = 'rmd,markdown,text',
        config = [[vim.g.fcitx5_remote = '/usr/bin/fcitx5-remote']]
    },

    ['tpope/vim-fugitive'] = {},
    ['cohama/agit.vim'] = {config = ':let g:agit_no_default_mappings = 0'},

    ['nvim-treesitter/nvim-treesitter'] = {
        dependency = 'nvim-treesitter/nvim-treesitter-textobjects'
    },

    -- dependencies
    ['nvim-lua/plenary.nvim'] = {opt=true},
    ['nvim-lua/popup.nvim'] = {opt=true},
    ['nvim-telescope/telescope-fzy-native.nvim'] = {opt=true},
    ['nvim-treesitter/nvim-treesitter-textobjects'] = {opt=true},

    -- database
    ['tpope/vim-dadbod'] = {disable = true},
    ['kristijanhusak/vim-dadbod-ui'] = {disable = true},

    -- test
    ['dstein64/vim-startuptime'] = {},
}
