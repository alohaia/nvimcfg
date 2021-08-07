return {
    -- completion
    ['neovim/nvim-lspconfig'] = {},
    ['glepnir/lspsaga.nvim'] = {},
    ['hrsh7th/nvim-compe'] = {},
    ['hrsh7th/vim-vsnip'] = {disable = true},
    ['SirVer/ultisnips'] = {},
    ['nvim-telescope/telescope.nvim'] = {},
    ['glepnir/smartinput.nvim'] = {},
    ['mattn/vim-sonictemplate'] = {},
    ['mattn/emmet-vim'] = {},
    ['mbbill/undotree'] = {},
    ['voldikss/vim-floaterm'] = {},

    -- ui
    ['joshdick/onedark.vim'] = {config = [[:colorscheme onedark]]},
    ['glepnir/zephyr-nvim'] = {disable = true, config = [[:colorscheme zephyr]]},
    ['glepnir/dashboard-nvim'] = {disable = true},
    ['mhinz/vim-startify'] = {},
    ['glepnir/galaxyline.nvim'] = {branch = 'main'},
    ['kyazdani42/nvim-web-devicons'] = {},
    ['lukas-reineke/indent-blankline.nvim'] = {},
    ['akinsho/nvim-bufferline.lua'] = {},
    ['kyazdani42/nvim-tree.lua'] = {},
    ['lewis6991/gitsigns.nvim'] = {},
    ['liuchengxu/vista.vim'] = {},

    -- editor
    ['RRethy/vim-illuminate'] = {},
    ['luochen1990/rainbow'] = {config = 'vim.g.rainbow_active = 1'},
    ['alohaia/vim-hexowiki'] = {ft='markdown,text'},
    ['rhysd/clever-f.vim'] = {},
    ['norcalli/nvim-colorizer.lua'] = {},
    ['brooth/far.vim'] = {},
    ['preservim/nerdcommenter'] = {},
    ['tpope/vim-capslock'] = {},
    ['tpope/vim-surround'] = {},
    ['tpope/vim-repeat'] = {},
    ['dkarter/bullets.vim'] = {ft = 'markdown,text'},
    ['dhruvasagar/vim-table-mode'] = {ft='markdown,text'},
    ['svermeulen/vim-subversive'] = {},
    ['mg979/vim-visual-multi'] = {},
    ['jiangmiao/auto-pairs'] = {},
    ['godlygeek/tabular'] = {
        config = function()
            vim.cmd[[cnorea Tab Tabularize]]
        end
    },

    -- dependences
    ['nvim-treesitter/nvim-treesitter'] = {},
    ['nvim-lua/plenary.nvim'] = {opt=true},
    ['nvim-lua/popup.nvim'] = {opt=true},
    ['nvim-telescope/telescope-fzy-native.nvim'] = {opt=true},

    -- database
    ['tpope/vim-dadbod'] = {disable = true},
    ['kristijanhusak/vim-dadbod-ui'] = {disable = true},
}
