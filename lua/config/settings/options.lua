local global_options = {
    termguicolors  = true,
    -- use two spaces after . where a sentence ends.
    formatoptions  = 'tcro/qj1p',
    cpoptions      = 'aABceFsI',
    lazyredraw     = false,
    timeout        = true,
    timeoutlen     = 500,
    autochdir      = false,
    virtualedit    = 'block',
    hidden         = true,
    tags           = './tags;,tags,./.tags',
    wildcharm      = 26,  -- wildchar for cmap, <c-z>
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
    -- tab:«·» ⏎ ␤ ␍ ↵  ↩
    -- nbsp: <C-k><Space><Space>
    listchars      = 'tab:»·,nbsp:~,trail:˽,eol:↩,extends:›,precedes:‹',
    fillchars      = 'vert:┆', -- ┆ ▏
    showbreak      = '↪',
    fileencodings  = 'utf-8,ucs-bom,gb18030,gbk,gb2312,cp936',
    emoji          = true,
    equalalways    = false,
    switchbuf      = 'useopen,usetab,newtab',
    showtabline    = 2,
    cmdheight      = 1,
    shortmess      = 'atAIFc',
    mouse          = 'a',
    grepprg        = 'rg -n',
    foldlevel      = 999,
    conceallevel   = 2,
    wrap           = false,
    list           = true,
    number         = true,
    relativenumber = true,
    cursorline     = true,
    colorcolumn    = '88,100,120',
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
    shiftround = true,
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

    inccommand   = 'nosplit',

    splitbelow   = true,
    splitright   = true,
}

local filetype_options = {
    ['markdown,rmd,tex'] = {
        wrap = true,
        spell = true,
        spelllang    = 'en_us,cjk',
        spellfile    = vim.fn.expand('~/.config/nvim/spell/en.utf-8.add'),
        -- spelloptions = 'camel',
        colorcolumn = '100',
        textwidth = 100,
        formatoptions = 'twan2mBp',
    },
    ['r,rmd'] = {
        colorcolumn = '120'
    },
    ['r'] = {
        -- foldmethod = 'marker',
        -- foldmarker = '{{{,}}}'
        foldmethod = 'expr',
        foldmarker = function (lnum)
            local line = vim.fn.getline(lnum)

            -- 匹配 RStudio 风格标题: # Section ----
            if string.match(line, '^#+%s+.*(----|####)%s*$') then
                -- 统计 # 的数量作为折叠层级
                local hashes = string.match(line, '^(#+)')
                return #hashes   -- 返回 1, 2, 3...
            end

            -- 其它行：继承上一行折叠
            return '='
        end
    },
    ['c,cpp'] = {
        path = {
            behavior = 'append',
            content = {'./include'}
        }
    },
    ['python'] = {
        expandtab  = true,
        colorcolumn = '88',
        shiftwidth = 4,
        tabstop    = 4,
        textwidth  = 88,
        formatoptions = 'c1jroqp',
    },
}

-------------------------
-- set global options ---
-------------------------
if type(global_options) == 'table' then
   for o,v in pairs(global_options) do
       vim.opt[o] = v
   end
end

---------------------------
-- Set filetype options ---
---------------------------
local aug_ft_options = vim.api.nvim_create_augroup('init_ft_options', {clear=true})
if type(filetype_options) == 'table' then
    for filetypes,options in pairs(filetype_options) do
        vim.api.nvim_create_autocmd('FileType', {
        group = aug_ft_options,
        pattern = filetypes,
        callback = function ()
            for o,v in pairs(options) do
                vim.opt[o] = v
            end
        end
        })
    end
end

