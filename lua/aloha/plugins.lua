local settings = require'aloha.settings'

local plugins = {}

plugins.list = {
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
    {'alohaia/md-img-paste.vim'},
    {'arcticicestudio/nord-vim'},
    {'ayu-theme/ayu-vim'},
    {'beyondmarc/opengl.vim'},
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
    {'wincent/terminus'}
    -- Completion and linting
    -- use {
    -- 'neovim/nvim-lspconfig', '~/projects/personal/lsp-status.nvim', {
    -- 'nvim-lua/completion-nvim',
    -- event = 'InsertEnter *',
    -- config = function()
    -- local completion = require('completion')
    -- completion.addCompletionSource('vimtex', require('vimtex').complete_item)

    -- vim.cmd [[ augroup lsp_aucmds ]]
    -- vim.cmd [[ au BufEnter * lua require('completion').on_attach() ]]
    -- vim.cmd [[ augroup END ]]

    -- completion.on_attach()
    -- vim.cmd [[ doautoall FileType ]]
    -- end,
    -- requires = {
    -- 'norcalli/snippets.nvim',
    -- event = 'InsertEnter *',
    -- config = function() require('snippets').use_suggested_mappings() end
    -- }
    -- }, {'nvim-treesitter/completion-treesitter', opt = true},
    -- {
    -- 'nvim-treesitter/nvim-treesitter',
    -- requires = {
    -- { 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter'},
    -- { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }},
    -- config = 'require("treesitter")', event =
    -- 'VimEnter *'}
    -- }
}


--{{ Plugin List
function plugins:init()
    vim.cmd[[packadd packer.nvim]]
    require('packer').startup({function()
        for _,package in ipairs(self.list) do
            use(package)
        end
    end, 
    config = {
        -- package_root = util.join_paths(vim.fn.stdpath('config'), 'pack'),
        -- compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'packer_compiled.vim'),
        package_root = '~/.config/nvim/pack',
        compile_path = '~/.config/nvim/plugin/packer_compiled.vim',
        git = {
            timeout = 1000
        },
        max_jobs = 1
    }})
end

-- default config
-- {
--   ensure_dependencies   = true, -- Should packer install plugin dependencies?
--   package_root   = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack'),
--   compile_path = util.join_paths(vim.fn.stdpath('config'), 'plugin', 'packer_compiled.vim'),
--   plugin_package = 'packer', -- The default package for plugins
--   max_jobs = nil, -- Limit the number of simultaneous jobs. nil means no limit
--   auto_clean = true, -- During sync(), remove unused plugins
--   compile_on_sync = true, -- During sync(), run packer.compile()
--   disable_commands = false, -- Disable creating commands
--   opt_default = false, -- Default to using opt (as opposed to start) plugins
--   transitive_opt = true, -- Make dependencies of opt plugins also opt by default
--   transitive_disable = true, -- Automatically disable dependencies of disabled plugins
--   git = {
--     cmd = 'git', -- The base command for git operations
--     subcommands = { -- Format strings for git subcommands
--       update         = '-C %s pull --ff-only --progress --rebase=false',
--       install        = 'clone %s %s --depth %i --no-single-branch --progress',
--       fetch          = '-C %s fetch --depth 999999 --progress',
--       checkout       = '-C %s checkout %s --',
--       update_branch  = '-C %s merge --ff-only @{u}',
--       current_branch = '-C %s branch --show-current',
--       diff           = '-C %s log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD',
--       diff_fmt       = '%%h %%s (%%cr)',
--       get_rev        = '-C %s rev-parse --short HEAD',
--       get_msg        = '-C %s log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1',
--       submodules     = '-C %s submodule update --init --recursive --progress'
--     },
--     depth = 1, -- Git clone depth
--     clone_timeout = 60, -- Timeout, in seconds, for git clones
--   },
--   display = {
--     non_interactive = false, -- If true, disable display windows for all operations
--     open_fn  = nil, -- An optional function to open a window for packer's display
--     open_cmd = '65vnew [packer]', -- An optional command to open a window for packer's display
--     working_sym = '⟳', -- The symbol for a plugin being installed/updated
--     error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
--     done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
--     removed_sym = '-', -- The symbol for an unused plugin which was removed
--     moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
--     header_sym = '━', -- The symbol for the header line in packer's display
--     show_all_info = true, -- Should packer show all update details automatically?
--   }
-- }

return plugins
