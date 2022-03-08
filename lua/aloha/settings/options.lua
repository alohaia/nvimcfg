return {
    termguicolors  = true;
    formatoptions  = "1jcroql";
    cpoptions      = 'aABceFsI';
    lazyredraw     = true,
    timeout        = true,
    timeoutlen     = 500,
    autochdir      = false,
    virtualedit    = "block",
    hidden         = true,
    tags           = './tags;,tags,./.tags',
    wildcharm      = 26,  -- wildchar for cmap, <c-z>, `set wildcharm          = <C-z> | echo &wildcharm`
    wildmode       = 'longest:full,full',
    wildignore     = '*.o,*~,*.pyc',
    fileformats    = 'unix,dos,mac',
    ignorecase     = true,
    smartcase      = true,
    hlsearch       = true,
    incsearch      = true,
    magic          = true,
    completeopt    = 'noinsert,menuone,noselect',
    backspace      = 'start,eol,indent',
    whichwrap      = 'b,s,<,>,h,l',
    sidescroll     = 1,
    sidescrolloff  = 5,
    scrolloff      = 3,
    linebreak      = false,
    breakindent    = false,
    listchars      = "tab:«·»,nbsp:+,trail:·,extends:→,precedes:←"; -- trail:˽
    fillchars      = 'vert:▏', -- ┆
    fileencodings  = 'utf-8,ucs-bom,gb18030,gbk,gb2312,cp936',
    emoji          = true,
    equalalways    = false,
    switchbuf      = 'useopen,usetab,newtab',
    showtabline    = 2,
    shortmess      = "atAFc",
    mouse          = 'a',
    grepprg        = 'rg -n',
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
    -- backup swap undo
    backup         = true,
    swapfile       = true,
    undofile       = true,
    undodir        = vim.fn.stdpath('data')..'/undo',
    backupdir      = vim.fn.stdpath('data')..'/backup',
    directory      = vim.fn.stdpath('data')..'/swap',
    -- fold
    foldmethod = 'expr',
    foldexpr   = 'nvim_treesitter#foldexpr()',
    foldcolumn = 'auto:1',
    -- tab, see :h tabstop
    shiftwidth = 4,
    tabstop    = 4,
    expandtab  = true,
    smarttab   = true,  -- softtabstop = 4,
    -- indent(use treesitter instead)
    -- autoindent  = true,
    -- smartindent = true, -- !cindent | !indentexpr
    -- cindent  = true,
    -- cinwords = 'if,else,while,do,for,switch', -- smartindent | cindent
    -- cinkeys  = '0{,0},0),0],:,0#,!^F,o,O,e', -- cindent & !indentexpr
    -- indentkeys        = ':,0#,!^F,o,O,e', -- indentexpr
    -- set indentexpr = Get{Vim|Lua|Cpp}Indent -- Xcindent Xsmartindent !lisp
    spelllang    = 'en_us,cjk',
    spellfile    = vim.fn.expand('~/.config/nvim/spell/en.utf-8.add'),
    spelloptions = 'camel',
    inccommand   = 'split',
}
