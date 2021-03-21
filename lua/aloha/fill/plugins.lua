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
    {'brooth/far.vim'},

    -- taglist
    {'liuchengxu/vista.vim'},

    -- File Operation
    {'Shougo/defx.nvim'},
    {'kristijanhusak/defx-git'},
    {'kristijanhusak/defx-icons'},
    -- {'kevinhwang91/rnvimr'},

    -- Git
    {'tpope/vim-fugitive'},
    {'cohama/agit.vim'},
    {'mhinz/vim-signify'},

    -- Text Editing
    -- {'tpope/vim-abolish'},
    {'preservim/nerdcommenter'},
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
    {'ron89/thesaurus_query.vim',
        -- ft = { 'text', 'markdown', 'wiki' }
    },

    -- Visual Improvements
    -- show colors
    {'RRethy/vim-hexokinase', run = 'make hexokinase' },
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
    {'luochen1990/rainbow'},
    {'joshdick/onedark.vim'},
    {'altercation/vim-colors-solarized'},

    {'ryanoasis/vim-devicons'},

    -- Syntax and Highlighting
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
    {'beyondmarc/opengl.vim', ft = { 'c', 'cpp' }},
    {'tikhomirov/vim-glsl'},

    -- Linting and Grammar Checking
    {'neoclide/coc.nvim'},
    -- {'neovim/nvim-lspconfig'},
    -- {'nvim-lua/completion-nvim'},
    -- {'nvim-lua/lsp-status.nvim'},

    -- Note Taking
    {'alohaia/vim-hexowiki'},
    {'dkarter/bullets.vim', ft = { 'text', 'markdown'}},
    {'dhruvasagar/vim-table-mode', ft = { 'text', 'markdown'}},

    -- Useful Functionalities
    {'voldikss/vim-floaterm'},
    {'voldikss/fzf-floaterm'},
    {'t9md/vim-choosewin'},
    -- Tasks
    {'skywind3000/asyncrun.vim'},
    {'skywind3000/asyncrun.extra'},
    {'skywind3000/asynctasks.vim'},
    -- Helper
    -- {'liuchengxu/vim-which-key', cmd = {'WhichKey', 'WhichKeyVisual'}},
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
    -- Starting interface
    {'mhinz/vim-startify'},

    -- Vim Documentation
    {'wsdjeg/vimdoc-cn'},

    -- Disabled Plugins ( Need :PackerCompile to make this work )
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
