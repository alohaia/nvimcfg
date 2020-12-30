----------------------------------------------------------------------------------------
--                            \ Plugin List and Config /                              --
----------------------------------------------------------------------------------------
_G.aloha.plugin.list = {
    {'wbthomason/packer.nvim', opt = true},

    -- Snippet
    {'SirVer/ultisnips'},
    -- {
    --     'zgpio/tree.nvim',
    --     run = [[
    --         cmake -DCMAKE_INSTALL_PREFIX=./INSTALL -DBoost_USE_STATIC_LIBS=ON -DCMAKE_BUILD_TYPE=Release -S tree.nvim/ -B tree.nvim/build
    --         make -C tree.nvim/build/ install
    --     ]],
    --     config = configs.tree
    -- },
    -- Search and Replace
    {'junegunn/fzf.vim'},
    {'pechorin/any-jump.vim'},
    {'rhysd/clever-f.vim'},
    -- taglist
    {'liuchengxu/vista.vim'},

    -- File Operation
    {'Shougo/defx.nvim'},
    {'kristijanhusak/defx-git'},
    {'kristijanhusak/defx-icons'},
    {'kevinhwang91/rnvimr'},

    -- Git
    {'tpope/vim-fugitive'},
    {'cohama/agit.vim'},
    {'mhinz/vim-startify'},
    {'ron89/thesaurus_query.vim',
        ft = { 'text', 'markdown', 'wiki' }
    },

    -- Text Editing
    -- {'tpope/vim-abolish'},
    {'tpope/vim-commentary'},
    {'tpope/vim-capslock'},
    {'tpope/vim-endwise'},
    {'tpope/vim-surround'},
    {'tpope/vim-repeat'},
    {'easymotion/vim-easymotion'},
    {'svermeulen/vim-yoink'},
    {'jiangmiao/auto-pairs'},
    {'junegunn/vim-after-object'},
    -- {'chrisbra/NrrwRgn'},
    {'svermeulen/vim-subversive'},

    -- Visual Improvements
    {'RRethy/vim-hexokinase', run = 'make hexokinase' },
    {'vim-airline/vim-airline'},
    {'Yggdroot/indentLine', ft = { 'python' }},
    {'RRethy/vim-illuminate'},
    {'joshdick/onedark.vim'},
    {'luochen1990/rainbow'},

    {'kyazdani42/nvim-web-devicons'},   -- need to add manually
    {'ryanoasis/vim-devicons'},

    -- Syntax and Highlighting
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
    {'beyondmarc/opengl.vim', ft = { 'c', 'cpp' }},
    {'tikhomirov/vim-glsl', ft = 'glsl'},

    -- Linting and Grammar Checking
    {'neoclide/coc.nvim'},

    -- Note Taking
    {
        'vimwiki/vimwiki',
    },
    -- {'dhruvasagar/vim-table-mode', ft = { 'text', 'markdown', 'wiki' }},
    -- {'dkarter/bullets.vim', ft = { 'text', 'markdown', 'wiki' }},

    -- Useful Functionalities
    {'voldikss/vim-floaterm'},
    {'t9md/vim-choosewin'},
    -- Tasks
    {'skywind3000/asyncrun.vim'},
    {'skywind3000/asynctasks.vim'},
    -- Helper
    {'liuchengxu/vim-which-key', cmd = {'WhichKey', 'WhichKeyVisual'}},
    {'voldikss/vim-translator'},
    {'KabbAmine/zeavim.vim'},
    -- Beyond of Programming
    {'iamcco/markdown-preview.nvim',
        ft = { 'text', 'markdown', 'wiki' },
        run = 'sh -c "cd app && yarn install"' },
    {'mzlogin/vim-markdown-toc', ft = { 'markdown', 'wiki' }},
    {'lervag/vimtex'},
    -- Multi cursor
    {'mg979/vim-visual-multi'},
    -- Undotree
    {'mbbill/undotree'},

    -- Disabled Plugins ( Need :PackerCompile to make this work )
    -- {'preservim/nerdcommenter', disable = true},
    -- {'airblade/vim-rooter', disable = true},
    -- {'wincent/terminus', disable = true},
    -- {'puremourning/vimspector', disable = true, ft = { 'c', 'cpp', 'python', 'rust', 'ruby', 'go' }},
    -- {'vim-airline/vim-airline-themes', disable = true},
    -- {'fatih/vim-go', disable = true, ft = { 'go' }},
    -- {'pangloss/vim-javascript', disable = true},
    -- {'octol/vim-cpp-enhanced-highlight', disable = true, ft = { 'c', 'cpp' }},
    -- {'plasticboy/vim-markdown', disable = true, ft = { 'markdown', 'wiki' }},
    -- {'alohaia/md-img-paste.vim', disable = true, ft = { 'markdown', 'wiki' }},
    -- {'arcticicestudio/nord-vim', disable = true},
    -- {'godlygeek/tabular', disable = true},
    -- {'hotoo/pangu.vim', disable = true},
    -- {'guns/xterm-color-table.vim', disable = true},
    -- {'itchyny/calendar.vim', disable = true},
    -- {'junegunn/goyo.vim', disable = true, ft = { 'text', 'markdown', 'wiki' }},
    -- {'Chiel92/vim-autoformat', disable = true},
    -- {'AndrewRadev/splitjoin.vim', disable = true},
    -- {'dracula/vim', disable = true, as = 'dracula' },
    -- {'flazz/vim-colorschemes', disable = true},
    -- {'fszymanski/fzf-gitignore', disable = true},
    -- {'rafalbromirski/vim-airlineish', disable = true},
    -- {'sheerun/vim-polyglot', disable = true},
}
