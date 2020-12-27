aloha.plugins.list = {}
local list = aloha.plugins.list

local config = aloha.plugins.config

list.packages = {
    {'wbthomason/packer.nvim', opt = true},

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
    {'tpope/vim-abolish'},
    {'tpope/vim-commentary'},
    {'preservim/nerdcommenter', disable = true},
    {'tpope/vim-capslock'},
    {'tpope/vim-endwise'},
    {'tpope/vim-repeat'},
    {'tpope/vim-surround'},
    {'easymotion/vim-easymotion'},
    {'svermeulen/vim-yoink'},
    {'jiangmiao/auto-pairs', config = config.auto_pairs},
    {'junegunn/vim-after-object'},
    {'chrisbra/NrrwRgn'},
    {'svermeulen/vim-subversive'},

    -- Visual Improvements
    {'RRethy/vim-hexokinase', run = 'make hexokinase' },
    {'vim-airline/vim-airline'},
    {'Yggdroot/indentLine', ft = { 'python' }},
    {'RRethy/vim-illuminate'},
    {'joshdick/onedark.vim'},
    {'luochen1990/rainbow'},
    {'ryanoasis/vim-devicons'},

    -- Syntax and Highlighting
    {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
    {'beyondmarc/opengl.vim', ft = { 'c', 'cpp' }},
    {'tikhomirov/vim-glsl', ft = 'glsl'},

    -- Linting and Grammar Checking
    {'neoclide/coc.nvim'},

    -- Note Taking
    {'vimwiki/vimwiki'},
    {'dhruvasagar/vim-table-mode', ft = { 'text', 'markdown', 'wiki' }},
    {'dkarter/bullets.vim', ft = { 'text', 'markdown', 'wiki' }},

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
    -- Snippet
    {'SirVer/ultisnips'},
    -- Beyond of Programming
    {'iamcco/markdown-preview.nvim',
        ft = { 'text', 'markdown', 'wiki' },
        run = 'sh -c "cd app && yarn install"' },
    {'mzlogin/vim-markdown-toc', ft = { 'markdown', 'wiki' }},
    {'lervag/vimtex'},
    -- Multi cursor
    {'mg979/vim-visual-multi', config = config.visual_nulti},
    -- Undotree
    {'mbbill/undotree'},

    -- Disabled Plugins ( Need :PackerCompile to make this work )
    {'airblade/vim-rooter', disable = true},
    {'wincent/terminus', disable = true},
    {'puremourning/vimspector', disable = true, ft = { 'c', 'cpp', 'python', 'rust', 'ruby', 'go' }},
    {'vim-airline/vim-airline-themes', disable = true},
    {'fatih/vim-go', disable = true, ft = { 'go' }},
    {'pangloss/vim-javascript', disable = true},
    {'octol/vim-cpp-enhanced-highlight', disable = true, ft = { 'c', 'cpp' }},
    {'plasticboy/vim-markdown', disable = true, ft = { 'markdown', 'wiki' }},
    {'alohaia/md-img-paste.vim', disable = true, ft = { 'markdown', 'wiki' }},
    {'arcticicestudio/nord-vim', disable = true},
    {'godlygeek/tabular', disable = true},
    {'hotoo/pangu.vim', disable = true},
    {'guns/xterm-color-table.vim', disable = true},
    {'itchyny/calendar.vim', disable = true},
    {'junegunn/goyo.vim', disable = true, ft = { 'text', 'markdown', 'wiki' }},
    {'Chiel92/vim-autoformat', disable = true},
    {'AndrewRadev/splitjoin.vim', disable = true},
    {'dracula/vim', disable = true, as = 'dracula' },
    {'flazz/vim-colorschemes', disable = true},
    {'fszymanski/fzf-gitignore', disable = true},
    {'rafalbromirski/vim-airlineish', disable = true},
    {'sheerun/vim-polyglot', disable = true},
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
