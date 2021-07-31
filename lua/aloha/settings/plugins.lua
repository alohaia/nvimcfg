_ = {
    -- Text Editing

    -- Visual Improvements
    -- show colors
    {'vim-airline/vim-airline'},
    -- {
    --     'glepnir/galaxyline.nvim',
    --     branch = 'main',
    --     -- your statusline
    --     -- config = function() require'my_statusline' end,
    --     -- some optional icons
    --     requires = {'kyazdani42/nvim-web-devicons', opt = true}
    -- },
    {'Yggdroot/indentLine', ft = { 'python' }},
    -- highlight other use of current word under the cursor
    {'RRethy/vim-illuminate'},
    {'joshdick/onedark.vim'},

    {'ryanoasis/vim-devicons'},

    -- Syntax and Highlighting
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
    {'beyondmarc/opengl.vim', ft = { 'c', 'cpp' }},
    {'tikhomirov/vim-glsl'},

    -- Linting and Grammar Checking
    {'neoclide/coc.nvim'},
    -- {'nvim-lua/completion-nvim'},
    -- {'nvim-lua/lsp-status.nvim'},

    -- Note Taking
    {'alohaia/vim-hexowiki'},

    -- Useful Functionalities
    -- Tasks
    {'skywind3000/asyncrun.vim'},
    -- {'skywind3000/asyncrun.extra'},
    {'skywind3000/asynctasks.vim'},
    -- Helper
    -- Multi cursor
    {'mg979/vim-visual-multi'},
    -- Undotree
    {'mbbill/undotree'},
    -- Starting interface
    {'mhinz/vim-startify'},

    -- Vim Documentation
    {'wsdjeg/vimdoc-cn'},

    -- Disabled Plugins ( Need :PackerCompile to make this work )
    {'pechorin/any-jump.vim', disable = true},
    {'rhysd/clever-f.vim', disable = true},
    {'brooth/far.vim', disable = true},
    {'iamcco/markdown-preview.nvim',
        ft = { 'text', 'markdown', 'wiki' },
        run = 'sh -c "cd app && yarn install"',
        disable = true},
    {'mzlogin/vim-markdown-toc', disable = true, ft = { 'markdown', 'wiki' }},
    {'airblade/vim-rooter',              disable = true},
    {'wincent/terminus',                 disable = true},
    {'puremourning/vimspector',          disable = true, ft = { 'c', 'cpp', 'python', 'rust', 'ruby', 'go' }},
    {'vim-airline/vim-airline-themes',   disable = true},
    {'fatih/vim-go',                     disable = true, ft = { 'go' }},
    {'pangloss/vim-javascript',          disable = true},
    {'octol/vim-cpp-enhanced-highlight', disable = true, ft = { 'c', 'cpp' }},
    {'plasticboy/vim-markdown',          disable = true, ft = { 'markdown', 'wiki' }},
    {'alohaia/md-img-paste.vim',         disable = true, ft = { 'markdown', 'wiki' }},
    {'arcticicestudio/nord-vim',         disable = true},
    {'godlygeek/tabular',                disable = true},
    {'hotoo/pangu.vim',                  disable = true},
    {'guns/xterm-color-table.vim',       disable = true},
    {'itchyny/calendar.vim',             disable = true},
    {'junegunn/goyo.vim',                disable = true, ft = { 'text', 'markdown', 'wiki' }},
    {'Chiel92/vim-autoformat',           disable = true},
    {'AndrewRadev/splitjoin.vim',        disable = true},
    {'dracula/vim',                      disable = true, as = 'dracula' },
    {'flazz/vim-colorschemes',           disable = true},
    {'fszymanski/fzf-gitignore',         disable = true},
    {'rafalbromirski/vim-airlineish',    disable = true},
    {'sheerun/vim-polyglot',             disable = true},
}

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
    ['alohaia/vim-hexowiki'] = {ft='md,markdown,txt'},
    ['dkarter/bullets.vim'] = {ft = 'txt,md,markdown'},
    ['dhruvasagar/vim-table-mode'] = {ft='md,markdown,txt'},
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
    ['lervag/vimtex'] = {ft = 'tex'},

    -- git
    ['tpope/vim-fugitive'] = {},
    ['cohama/agit.vim'] = {config = ':let g:agit_no_default_mappings = 0'},

    -- lua plugins
    ['nvim-treesitter/nvim-treesitter'] = {run = ':au VimEnter * TSUpdate'},
    ['neovim/nvim-lspconfig'] = {},

    ['kevinhwang91/rnvimr'] = {disable = true},
    ['Shougo/defx.nvim'] = {disable = true},
    ['kristijanhusak/defx-git'] = {disable = true},
    ['kristijanhusak/defx-icons'] = {disable = true},
    ['junegunn/vim-after-object'] = {disable = true},
    -- {'RRethy/vim-hexokinase', run = 'make hexokinase'},
    ['iamcco/markdown-preview.nvim'] = {
        disable = true,
        ft = { 'text', 'markdown', 'wiki' },
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
