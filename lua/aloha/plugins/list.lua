aloha.plugins.list = {}
local list = aloha.plugins.list

list.packages = {
    {'wbthomason/packer.nvim', opt = true},
    'tpope/vim-surround',
    {'AndrewRadev/splitjoin.vim'},
    {'Chiel92/vim-autoformat'},
    {'KabbAmine/zeavim.vim'},
    {'RRethy/vim-hexokinase', run = 'make hexokinase' },
    {'RRethy/vim-illuminate'},
    {'Shougo/defx.nvim'},
    {'SirVer/ultisnips'},
    {'Yggdroot/indentLine', ft = { 'python' }},
    {'airblade/vim-rooter'},
    {'brooth/far.vim'},
    {'chrisbra/NrrwRgn'},
    {'cohama/agit.vim'},
    {'dhruvasagar/vim-table-mode', cmd = 'TableModeToggle', ft = { 'text', 'markdown', 'wiki' }},
    {'dkarter/bullets.vim'},
    {'dracula/vim', as = 'dracula' },
    {'easymotion/vim-easymotion'},
    {'fatih/vim-go', ft = { 'go' }},
    {'flazz/vim-colorschemes'},
    {'fszymanski/fzf-gitignore'},
    {'godlygeek/tabular'},
    {'guns/xterm-color-table.vim'},
    {'hotoo/pangu.vim'},
    {'iamcco/markdown-preview.nvim', ft = { 'markdown', 'pandoc.markdown', 'rmd' }, run = 'sh -c "cd app && yarn install"' },
    {'itchyny/calendar.vim'},
    {'jiangmiao/auto-pairs'},
    {'joshdick/onedark.vim'},
    {'junegunn/fzf.vim'},
    {'junegunn/goyo.vim'},
    {'junegunn/vim-after-object'},
    {'kevinhwang91/rnvimr'},
    {'kristijanhusak/defx-git'},
    {'kristijanhusak/defx-icons'},
    {'lervag/vimtex'},
    {'liuchengxu/vim-which-key'},
    {'liuchengxu/vista.vim'},
    {'luochen1990/rainbow'},
    {'mbbill/undotree'},
    {'mg979/vim-visual-multi', options = { rev = 'master' }},
    {'mhinz/vim-signify'},
    {'mhinz/vim-startify'},
    {'mzlogin/vim-markdown-toc', ft = { 'markdown', 'wiki' }},
    {'neoclide/coc.nvim', rev = 'release' },
    {'octol/vim-cpp-enhanced-highlight', on_ft = { 'c', 'cpp' }},
    {'pangloss/vim-javascript'},
    {'pechorin/any-jump.vim'},
    {'plasticboy/vim-markdown'},
    {'preservim/nerdcommenter'},
    {'puremourning/vimspector'},
    {'rafalbromirski/vim-airlineish'},
    {'rhysd/clever-f.vim'},
    {'ron89/thesaurus_query.vim'},
    {'ryanoasis/vim-devicons'},
    {'sheerun/vim-polyglot'},
    {'skywind3000/asyncrun.vim'},
    {'skywind3000/asynctasks.vim'},
    {'svermeulen/vim-subversive'},
    {'svermeulen/vim-yoink'},
    {'t9md/vim-choosewin'},
    {'tikhomirov/vim-glsl'},
    {'tpope/vim-abolish'},
    {'tpope/vim-capslock'},
    {'tpope/vim-commentary'},
    {'tpope/vim-endwise'},
    {'tpope/vim-fugitive'},
    {'tpope/vim-repeat'},
    {'vim-airline/vim-airline'},
    {'vim-airline/vim-airline-themes'},
    {'vimwiki/vimwiki'},
    {'voldikss/vim-floaterm'},
    {'voldikss/vim-translator'},
    {'alohaia/md-img-paste.vim'},
    {'arcticicestudio/nord-vim'},
    {'beyondmarc/opengl.vim'},
    -- {'wincent/terminus'},
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
}


--{{ Plugin List
function list:init()
    vim.cmd[[packadd packer.nvim]]
    require('packer').startup({function()
        for _,package in ipairs(self.packages) do
            use(package)
        end
    end, config = aloha.settings.packer_config})
end

return list
