_ = {
    ['Yggdroot/indentLine'] = {},
    ['junegunn/fzf.vim'] = {},
    ['tpope/vim-endwise'] = {},
    ['ryanoasis/vim-devicons'] = {},
    ['t9md/vim-choosewin'] = {},
    ['svermeulen/vim-yoink'] = {},
    ['easymotion/vim-easymotion'] = {},
    ['mhinz/vim-signify'] = {},
    ['ron89/thesaurus_query.vim'] = {},
    ['voldikss/vim-translator'] = {},
    ['lervag/vimtex'] = {ft = 'plaintex'},
    ['wsdjeg/vimdoc-cn'] = {},
    ['beyondmarc/opengl.vim'] = {ft = { 'c', 'cpp' }},
    ['tikhomirov/vim-glsl'] = {},
    ['skywind3000/asyncrun.vim'] = {},
    ['skywind3000/asyncrun.extra'] = {},
    ['skywind3000/asynctasks.vim'] = {},

    -- git
    ['tpope/vim-fugitive'] = {},
    ['cohama/agit.vim'] = {config = ':let g:agit_no_default_mappings = 0'},

    -- lua plugins
    ['nvim-treesitter/nvim-treesitter'] = {run = ':au VimEnter * TSUpdate'},
    ['neovim/nvim-lspconfig'] = {},
    ['RRethy/vim-hexokinase'] =  {run = '!make hexokinase'},

    -- disabled plugins
    ['kevinhwang91/rnvimr'] = {disable = true},
    ['Shougo/defx.nvim'] = {disable = true},
    ['kristijanhusak/defx-git'] = {disable = true},
    ['kristijanhusak/defx-icons'] = {disable = true},
    ['junegunn/vim-after-object'] = {disable = true},
    ['iamcco/markdown-preview.nvim'] = {
        disable = true,
        ft = {'text', 'markdown'},
        run = 'sh -c "cd app && yarn install"',
    },
    ['KabbAmine/zeavim.vim'] = {
        disable = true,
        config = function()
            vim.g.zv_file_types = {
                cpp = "c,cpp,qt,glib,opencv",
                python = "python,pandas,numpy",
            }
        end,
    },
}

return {
    -- completion
    ['neovim/nvim-lspconfig'] = {},
    ['glepnir/lspsaga.nvim'] = {},
    ['hrsh7th/nvim-compe'] = {disable = true},
    ['hrsh7th/vim-vsnip'] = {disable = true},
    ['nvim-lua/completion-nvim'] = {},
    ['SirVer/ultisnips'] = {},
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
    ['kyazdani42/nvim-tree.lua'] = {disable = true}, -- TODO: `on`
    ['lewis6991/gitsigns.nvim'] = {},
    ['liuchengxu/vista.vim'] = {},
    ['mbbill/undotree'] = {},
    ['voldikss/vim-floaterm'] = {},
    ['glepnir/zephyr-nvim'] = {disable = true, config = [[:colorscheme zephyr]]},
    ['glepnir/dashboard-nvim'] = {disable = true},
    ['glepnir/galaxyline.nvim'] = {disable = true, branch = 'main'},

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
    ['dkarter/bullets.vim'] = {},   -- use `vim.g.bullets_enabled_file_types`
    ['dhruvasagar/vim-table-mode'] = {ft='markdown,text'},
    ['svermeulen/vim-subversive'] = {},
    ['mg979/vim-visual-multi'] = {},
    ['jiangmiao/auto-pairs'] = {},
    ['godlygeek/tabular'] = {
        config = function()
            vim.cmd[[cnorea Tab Tabularize]]
        end
    },
    ['jalvesaq/Nvim-R'] = {disable = true, ft = 'r', branch = 'master'},

    -- dependences
    ['nvim-treesitter/nvim-treesitter'] = {},
    ['nvim-lua/plenary.nvim'] = {opt=true},
    ['nvim-lua/popup.nvim'] = {opt=true},
    ['nvim-telescope/telescope-fzy-native.nvim'] = {opt=true},

    -- database
    ['tpope/vim-dadbod'] = {disable = true},
    ['kristijanhusak/vim-dadbod-ui'] = {disable = true},
}
