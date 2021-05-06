----------------------------------------------------------------------------------------
--                                    \ Options /                                     --
----------------------------------------------------------------------------------------
_G.aloha.wim.option.list = {}
local option = _G.aloha.wim.option
local cache_base = _G.aloha.global.paths.cache_base
local caches = _G.aloha.global.paths.caches
local config = _G.aloha.global.paths.config
local utils = _G.aloha.utils

option.g_options = {
    termguicolors  = true;
    cpoptions   = 'aABceFsI';
    lazyredraw  = true,
    timeout     = true,
    timeoutlen  = 500,
    autochdir   = false,
    virtualedit = "block",
    hidden      = true,
    tags        = './tags;,tags,./.tags',
    smarttab    = true,
    -- wildchar for cmap, <c-z>
    -- set wildcharm = <C-z> | echo &wildcharm
    wildcharm   = 26,
    wildmode    = 'longest:full,full',
    wildignore  = '*.o,*~,*.pyc',

    fileformats = 'unix,dos,mac',
    ignorecase  = true,
    smartcase   = true,
    hlsearch    = true,
    incsearch   = true,
    magic       = true,

    backup      = true,
    directory   = utils.join_paths(cache_base, caches.swap),
    undodir     = utils.join_paths(cache_base, caches.undo),
    backupdir   = utils.join_paths(cache_base, caches.backup),

    completeopt = 'noinsert,menuone,noselect',

    backspace = 'start,eol,indent', whichwrap='b,s,<,>,h,l',
    sidescroll = 1, sidescrolloff = 5, scrolloff = 3,
    listchars = 'trail:˽,tab:>-', fillchars = 'vert:▏',

    fileencodings = 'utf-8,ucs-bom,gb18030,gbk,gb2312,cp936',
    emoji = true,

    equalalways = false,

    switchbuf='useopen,usetab,newtab',

    showtabline=2,

    shortmess="atAF",

    mouse='a',
}

option.w_options = {
    foldlevel      = 999,
    conceallevel   = 2,
    wrap           = false,
    sidescrolloff  = 5,
    scrolloff      = 3,
    list           = true,
    number         = true,
    relativenumber = true,
    cursorline     = true,
    colorcolumn    = '88',
    signcolumn     = 'yes',
    foldmethod     = 'syntax',
    -- foldexpr       = 'nvim_treesitter#foldexpr()',
    foldcolumn     = '0',
}

option.b_options = {
    swapfile    = true,
    undofile    = true,
    -- see :h tabstop
    -- tabstop = 8, softtabstop = 4, shiftwidth = 4, expandtab = false,
    -- tabstop = 4, shiftwidth = 4, -- plus a modeline
    expandtab =true,
    tabstop = 4,
    shiftwidth = 4,
    -- 1.
    autoindent = true,
    -- 2.
    -- smartindent = true, -- !cindent | !indentexpr
    -- 3.
    -- cinwords = 'if,else,while,do,for,switch', -- smartindent | cindent
    -- cinkeys = '0{,0},0),0],:,0#,!^F,o,O,e', -- cindent & !indentexpr
    -- 4.
    indentkeys = ':,0#,!^F,o,O,e', -- indentexpr
    -- set indentexpr = Get{Vim|Lua|Cpp}Indent -- Xcindent Xsmartindent !lisp

    spelllang = 'en_us,cjk',
    spellfile = utils.join_paths(config, 'spell', 'en.utf-8.add'),
    spelloptions = 'camel',
}
