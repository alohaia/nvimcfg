local plugins = {}

plugins.list = [[
call plug#begin("~/.config/nvim/plugins/")
Plug 'junegunn/vim-plug'
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
if has('nvim')
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 't9md/vim-choosewin'
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'liuchengxu/vista.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'wincent/terminus'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rafalbromirski/vim-airlineish'
Plug 'guns/xterm-color-table.vim'
let g:polyglot_disabled = ['markdown']
Plug 'sheerun/vim-polyglot'
Plug 'nvim-tree-sitter/nvim-tree-sitter'
Plug 'glepnir/zephyr-nvim'
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
Plug 'pangloss/vim-javascript'
Plug 'flazz/vim-colorschemes'
Plug 'RRethy/vim-illuminate'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
Plug 'pechorin/any-jump.vim'
Plug 'brooth/far.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/completion-nvim'
 Plug 'neovim/nvim-lspconfig'
Plug 'SirVer/ultisnips'            " improved vim-snipmate
Plug 'puremourning/vimspector'
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
Plug 'tpope/vim-capslock'
Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'easymotion/vim-easymotion'
Plug 'svermeulen/vim-subversive'
Plug 'tpope/vim-abolish'
Plug 'svermeulen/vim-yoink'
Plug 'rhysd/clever-f.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
Plug 'dkarter/bullets.vim'
Plug 'alohaia/md-img-paste.vim'
Plug 'lervag/vimtex'
Plug 'hotoo/pangu.vim'
Plug 'voldikss/vim-floaterm'
Plug 'tpope/vim-fugitive'
Plug 'cohama/agit.vim'
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'KabbAmine/zeavim.vim'        " <LEADER>z to find doc offline with zeal.
Plug 'Yggdroot/indentLine', {'for' : ['python']}
Plug 'luochen1990/rainbow'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/goyo.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'ron89/thesaurus_query.vim'
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'itchyny/calendar.vim'
Plug 'voldikss/vim-translator'
Plug 'beyondmarc/opengl.vim'
Plug 'tikhomirov/vim-glsl'
call plug#end()
]]

-- vim.api.nvim_exec(plugins.list)

return plugins
