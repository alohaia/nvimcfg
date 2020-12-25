local settings = aloha.settings
local merge = aloha.utils.merge

aloha.options = {}
local options = aloha.options

-- option-list lua-vim-options

options.g_options = {
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
    -- wildchar for cmap, <c-i>
    wildcharm   = 9,

    backup      = true,
    directory   = settings.cache_dirs.swap,
    undodir     = settings.cache_dirs.undo,
    backupdir   = settings.cache_dirs.backup,

    completeopt = 'noinsert,menuone,noselect,preview',

    backspace = 'start,eol,indent', whichwrap='b,s,<,>,h,l',
    sidescroll = 1, sidescrolloff = 5, scrolloff = 3,
    listchars = 'trail:˽,tab:>-', fillchars = 'vert:▏',

    fileencodings = 'utf-8,ucs-bom,gb18030,gbk,gb2312,cp936',
    emoji = true,

    equalalways = false,
}

options.w_options = {
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
    foldmethod     = 'expr',
    foldexpr       = 'nvim_treesitter#foldexpr()',
    foldcolumn     = '1',
}

options.b_options = {
    swapfile    = true,
    undofile    = true,
    -- see :h tabstop
    -- tabstop = 8, softtabstop = 4, shiftwidth = 4, expandtab = false,
    -- tabstop = 4, shiftwidth = 4, -- plus a modeline
    expandtab,
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
    indentkeys = '0{,0},0),0],:,0#,!^F,o,O,e', -- indentexpr
    -- set indentexpr = Get{Vim|Lua|Cpp}Indent -- Xcindent Xsmartindent !lisp
}

function options:init()
    for o,v in pairs(self.g_options) do
        vim.o[o] = v
    end
    -- vim.cmd[[ set indentexpr = cindent() ]]
    for o,v in pairs(self.w_options) do
        vim.wo[o] = v
        vim.o[o] = v
    end
    for o,v in pairs(self.b_options) do
        vim.bo[o] = v
        vim.o[o] = v
    end
end

return options
