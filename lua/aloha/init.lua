-- require('zephyr').get_zephyr_color()
-- print(vim.api.nvim_eval('1+1'))
local global = require('aloha.global')
local optimization = require('aloha.optimization').init()
-- local plugins = require('aloha/plugins')
local toolset = require('aloha/toolset')
local fs = require('aloha.fs')

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end

local init = {}

function init.createdir()
    local data_dir = {
        global.cache_dir..'backup',
        global.cache_dir..'session',
        global.cache_dir..'swap',
        global.cache_dir..'undo'
        -- global.cache_dir..'tags',
    }
    -- There only check once that If cache_dir exists
    -- Then I don't want to check subs dir exists
    if not fs.isdir(global.cache_dir) then
        os.execute("mkdir -p " .. global.cache_dir)
        for _,v in pairs(data_dir) do
            if not global.isdir(v) then
                os.execute("mkdir -p " .. v)
            end
        end
    end
end

------------------------------ set options ------------------------------
init.options = {}
init.options.plain = {
    compatible     = false,
    ttyfast        = true,
    timeout        = true,
    timeoutlen     = 200,
    ttimeout       = false,
    lazyredraw     = true,
    regexpengine   = 1,
    autochdir      = true,
    virtualedit    = 'block',
    number         = true,
    relativenumber = true,
    cursorline     = true,
    textwidth      = 500,
    showmatch      = true,
    matchtime      = 2,
    foldlevel      = 999,
    history        = 500,
    tags           = './.tags',
    hidden         = true,
    splitbelow     = true,
    splitright     = true,
    completeopt    = 'noinsert,menuone,noselect,preview',
    equalalways    = false,
    conceallevel   = 2,
    concealcursor  = '',
    updatetime     = 200,
    wrap           = false,
    sidescroll     = 1,
    sidescrolloff  = 5,
    scrolloff      = 3,
    list           = true,
    -- listchars=tab:<->,trail:•,extends:>,precedes:<
    listchars      = 'trail:˽,tab:>-',
    fillchars      = 'vert:▏',
    autoread       = true,
    autowrite      = true,
    autoindent     = true,
    smartindent    = true,
    cinkeys        = '0{,0},0),0],:,0#,!^F,o,O,e',
    indentexpr     = '',
    cpoptions      = 'aABceFs_',
    expandtab      = true,
    shiftwidth     = 4,
    tabstop        = 4,
    softtabstop    = 4,
    smarttab       = true,
    backup         = true,
    backupdir      = global.cache_dir..'backup',
    undofile       = true,
    undodir        = global.cache_dir..'undo',
    swapfile       = true,
    directory      = global.cache_dir..'swap',
    errorbells     = false,
    visualbell     = false,
    timeoutlen     = 500,
    foldcolumn     = '0',
    fileencodings  = 'utf-8,ucs-bom,gb18030,gbk,gb2312,cp936',
    encoding       = 'utf-8',
    fileformats    = 'unix,dos,mac',
    emoji          = true,
    backspace      = 'eol,start,indent',
    whichwrap      = 'b,s,<,>,h,l',
    termguicolors  = true,
    ignorecase     = true,
    smartcase      = true,
    hlsearch       = true,
    incsearch      = true,
    magic          = true,
    switchbuf      = 'useopen,usetab,newtab',
    showtabline    = 2,
}

init.options.gui = {
    mousehide = true,
}

function init:setopts()
    for k,v in pairs(self.options.plain) do
        vim.api.nvim_set_option(k, v)
    end
    -- other options
    -- au FocusGained,BufEnter * checktime
    -- au FileType cpp    setlocal cindent | setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
    -- au FileType python setlocal cindent | setlocal cinkeys=0{,0},0),0],:,0#,!^F,o,O,e
end

function init:setautocommands()
    -- not available now
end

function init:nvim_cmds()
    -- not available now
end

------------------------------ set mappings ------------------------------
init.mappings = {
    nov = {
        {'j', [[gj]]},
    },
    n = {
        {';', ':'},
        {':', ';'},
        {'<esc>', [[:nohl<cr>]]},
        {'n', [[nzz]], {noremap = true}},
        {'N', [[Nzz]]},
        {'J', [[5gj]]},
        {'K', [[5gk]]},
        {'Y', [[y$]]},
        -- {'^', [[g^]]},
        -- {'0', [[g0]]},
        -- {'g^', [[^]]},
        -- {'g0', [[0]]},
        -- Move between windows
        {'<C-h>', [[<C-w>h]]},
        {'<C-l>', [[<C-w>l]]},
        {'<C-j>', [[<C-w>j]]},
        {'<C-k>', [[<C-w>k]]},
        -- Movw between buffer
        {']b', [[:bnext<cr>]]},
        {'<C-b><C-n>', [[:bnext<cr>]]},
        {'[b', [[:bprevious<cr>]]},
        {'<C-b><C-p>', [[:bprevious<cr>]]},
        {']B', [[:blast<cr>]]},
        {'<C-b><C-N>', [[:blast<cr>]]},
        {'[B', [[:bfirst<cr>]]},
        {'<C-b><C-P>', [[:bfirst<cr>]]},
        -- Move between tabs
        {'<C-t><C-n>', [[]]},
        -- Move lines
        {'<M-k>', [[mz:m-2<cr>`z]]},
    },
    v = {
        {'J', [[5gj]]},
        {'K', [[5gk]]},
        -- {'*', [[:<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>]]},
        -- {'#', [[:<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>]]},
    },
    i = {
        {'<M-BS>', [[<del>]]},
    },
    c = {
        {'%%', [[getcmdtype()==':' ? expand('%:p:h').'/' : '%%']]},
    },
    filetype = {
        c = {},
        python = {},
        lua = {},
        vim = {},
    }
  }

init.map_default_options = {
    noremap = true,
    silent = true,
}

function init:setmapings()
    vim.api.nvim_set_var('mapleader', [[ ]])
    for mode,mappings in pairs(self.mappings) do
        if mode == 'nov' then
            mode = ''
        end
        for _,mapping in ipairs(mappings) do
            if mapping[3] == nil then
                vim.api.nvim_set_keymap(mode, mapping[1], mapping[2], self.map_default_options)
            else
                vim.api.nvim_set_keymap(mode, mapping[1], mapping[2], mapping[3])
            end
        end
    end
end

function init:setcolor()
    vim.cmd('colorscheme molokai')
    vim.api.nvim_set_var('airline_theme', 'airlineish')
end

function init:load_config()
    init:createdir()
    init:setopts()
    init:setmapings()
    init:setcolor()
end
init:load_config()
