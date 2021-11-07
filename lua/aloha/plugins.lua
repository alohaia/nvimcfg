return {
    -- completion
    ['neovim/nvim-lspconfig']         = {},
    ['hrsh7th/nvim-cmp']              = {},
    ['hrsh7th/cmp-nvim-lsp']          = {},
    ['hrsh7th/cmp-buffer']            = {},
    ['hrsh7th/cmp-path']              = {},
    ['quangnguyen30192/cmp-nvim-ultisnips'] = {},
    ['glepnir/lspsaga.nvim']          = {disable = true},
    ['onsails/lspkind-nvim']          = {},
    ['SirVer/ultisnips']              = {},
    ['nvim-telescope/telescope.nvim'] = {},

    -- ui
    ['mhinz/vim-startify'] = {},
    ['alohaia/onedark.vim'] = {},
    ['rafalbromirski/vim-airlineish'] = {disable = true},
    ['vim-airline/vim-airline'] = {
        config=[[:let g:airline_theme = 'onedark']]
    },
    ['kyazdani42/nvim-web-devicons'] = {},
    ['lukas-reineke/indent-blankline.nvim'] = {},
    ['akinsho/nvim-bufferline.lua'] = {},
    ['kyazdani42/nvim-tree.lua'] = {},
    ['lewis6991/gitsigns.nvim'] = {},
    ['liuchengxu/vista.vim'] = {},
    ['mbbill/undotree'] = {},
    ['voldikss/vim-floaterm'] = {},
    ['glepnir/zephyr-nvim'] = {disable = true, config = [[:colorscheme zephyr]]},
    ['glepnir/dashboard-nvim'] = {disable = true},
    ['glepnir/galaxyline.nvim'] = {disable = true, branch = 'main'},
    ['fatih/vim-go'] = {},

    -- editor
    ['RRethy/vim-illuminate'] = {},
    ['luochen1990/rainbow'] = {},
    ['alohaia/hugowiki.nvim'] = {ft='markdown,rmd,text'},
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
    ['godlygeek/tabular'] = {
        config = function()
            vim.cmd[[cnorea Tab Tabularize]]
        end
    },
    ['jalvesaq/Nvim-R'] = {disable = true, ft = 'r', branch = 'master'},
    ['skywind3000/asyncrun.vim'] = {disable = true},
    ['skywind3000/asyncrun.extra'] = {disable = true},
    ['skywind3000/asynctasks.vim'] = {disable = true},
    ['lilydjwg/fcitx.vim'] = {
        ft = 'rmd,markdown,text',
        config = [[vim.g.fcitx5_remote = '/usr/bin/fcitx5-remote']]
    },

    -- git
    ['tpope/vim-fugitive'] = {},
    ['cohama/agit.vim'] = {config = ':let g:agit_no_default_mappings = 0'},

    -- dependences
    ['nvim-treesitter/nvim-treesitter'] = {},
    ['nvim-treesitter/nvim-treesitter-textobjects'] = {},
    ['nvim-lua/plenary.nvim'] = {opt=true},
    ['nvim-lua/popup.nvim'] = {opt=true},
    ['nvim-telescope/telescope-fzy-native.nvim'] = {opt=true},

    -- database
    ['tpope/vim-dadbod'] = {disable = true},
    ['kristijanhusak/vim-dadbod-ui'] = {disable = true},
}
