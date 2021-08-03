return {
    ['mhinz/vim-startify'] = {},
    ['joshdick/onedark.vim'] = {},
    ['Yggdroot/indentLine'] = {},
    ['SirVer/ultisnips'] = {},
    ['junegunn/fzf.vim'] = {},
    ['vim-airline/vim-airline'] = {config=[[:let g:airline_theme = 'airlineish']]},
    ['preservim/nerdcommenter'] = {},
    ['tpope/vim-capslock'] = {},
    ['tpope/vim-surround'] = {},
    ['tpope/vim-endwise'] = {},
    ['tpope/vim-repeat'] = {},
    ['mbbill/undotree'] = {},
    ['alohaia/vim-hexowiki'] = {ft='markdown,text'},
    ['dkarter/bullets.vim'] = {ft = 'markdown,text'},
    ['dhruvasagar/vim-table-mode'] = {ft='markdown,text'},
    ['rafalbromirski/vim-airlineish'] = {},
    ['ryanoasis/vim-devicons'] = {},
    ['t9md/vim-choosewin'] = {},
    ['liuchengxu/vista.vim'] = {},
    ['svermeulen/vim-yoink'] = {},
    ['easymotion/vim-easymotion'] = {},
    ['svermeulen/vim-subversive'] = {},
    ['rhysd/clever-f.vim'] = {},
    ['mg979/vim-visual-multi'] = {},
    ['jiangmiao/auto-pairs'] = {},
    ['voldikss/vim-floaterm'] = {},
    ['voldikss/fzf-floaterm'] = {},
    ['mhinz/vim-signify'] = {},
    ['luochen1990/rainbow'] = {config = 'vim.g.rainbow_active = 1'},
    ['ron89/thesaurus_query.vim'] = {},
    ['voldikss/vim-translator'] = {},
    ['lervag/vimtex'] = {ft = 'plaintex'},
    ['wsdjeg/vimdoc-cn'] = {},
    ['godlygeek/tabular'] = {
        config = function()
            vim.cmd[[cnorea Tab Tabularize]]
        end
    },
    ['beyondmarc/opengl.vim'] = {ft = { 'c', 'cpp' }},
    ['tikhomirov/vim-glsl'] = {},
    ['skywind3000/asyncrun.vim'] = {},
    ['skywind3000/asynctasks.vim'] = {},

    -- git
    ['tpope/vim-fugitive'] = {},
    ['cohama/agit.vim'] = {config = ':let g:agit_no_default_mappings = 0'},

    -- lua plugins
    ['nvim-treesitter/nvim-treesitter'] = {run = ':au VimEnter * TSUpdate'},
    ['neovim/nvim-lspconfig'] = {},
    ['RRethy/vim-illuminate'] = {},
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
    ['brooth/far.vim'] = {disable = true},
}
