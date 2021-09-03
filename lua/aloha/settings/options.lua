return {
    termguicolors = true;
    formatoptions = "1jcroql";
    cpoptions   = 'aABceFsI';
    lazyredraw  = true,
    timeout     = true,
    timeoutlen  = 500,
    autochdir   = false,
    virtualedit = "block",
    hidden      = true,
    tags        = './tags;,tags,./.tags',
    smarttab    = true,
    wildcharm   = 26,  -- wildchar for cmap, <c-z>, `set wildcharm=<C-z> | echo &wildcharm`
    wildmode    = 'longest:full,full',
    wildignore  = '*.o,*~,*.pyc',
    fileformats = 'unix,dos,mac',
    ignorecase  = true,
    smartcase   = true,
    hlsearch    = true,
    incsearch   = true,
    magic       = true,
    backup      = true,
    undodir     = vim.fn.stdpath('data')..'/swap',
    backupdir   = vim.fn.stdpath('data')..'/undo',
    directory   = vim.fn.stdpath('data')..'/backup',
    completeopt = 'noinsert,menuone,noselect',
    backspace = 'start,eol,indent', whichwrap='b,s,<,>,h,l',
    sidescroll = 1, sidescrolloff = 5, scrolloff = 3,
    linebreak = false, breakindent = false,
    listchars = "tab:«·»,nbsp:+,trail:·,extends:→,precedes:←"; -- trail:˽
    fillchars = 'vert:▏', -- ┆
    fileencodings = 'utf-8,ucs-bom,gb18030,gbk,gb2312,cp936',
    emoji = true,
    equalalways = false,
    switchbuf='useopen,usetab,newtab',
    showtabline=2,
    shortmess="atAF",
    mouse='a',
    grepprg='rg -n',
    foldlevel      = 999,
    conceallevel   = 2,
    wrap           = false,
    showbreak      = "↳ ";
    list           = true,
    number         = true,
    relativenumber = true,
    cursorline     = true,
    colorcolumn    = '88',
    signcolumn     = 'yes',
    foldmethod     = 'marker',
    -- foldexpr       = 'nvim_treesitter#foldexpr()',
    foldcolumn = 'auto:1',

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
    spellfile = vim.fn.expand('~/.config/nvim/spell/en.utf-8.add'),
    spelloptions = 'camel',
    inccommand = 'split',
}
