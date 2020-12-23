local settings = require("aloha.settings")

local options = {}

options.g_options = {
    -- compatible = false,
    lazyredraw = true,
    timeout = true,
    timeoutlen=200,
    autochdir=false,
    virtualedit="block",
    shiftround=true,
    backspace='start,eol,indent',
    hidden=true,
    tags='./tags;,tags,./.tags',
    completeopt='noinsert,menuone,noselect,preview',
    sidescroll=1,
    sidescrolloff=5,
    scrolloff=3,
    listchars='trail:˽,tab:>-',
    fillchars='vert:▏',
    shiftwidth=4,
    tabstop=4,
    undofile=true,
    number=true,
    relativenumber=true,
    cursorline=true,
    colorcolumn='76',
    foldlevel=999,
    conceallevel=2,
    wrap=false,
    list=true,
    -- wildchar foe cmap, <c-i>
    wildcharm=9
}

options.w_options = {
    number=true,
    relativenumber=true,
    cursorline=true,
    colorcolumn='76',
    foldlevel=999,
    conceallevel=2,
    wrap=false,
    sidescrolloff=5,
    scrolloff=3,
    list=true,
    listchars='trail:˽,tab:>-',
    fillchars='vert:▏'
}

options.b_options = {
    shiftwidth=4,
    tabstop=4,
    tags='./tags;,tags,./.tags',
    undofile=true
}

function options:init()
    for k,v in pairs(self.g_options) do
        vim.o[k] = v
    end
    for k,v in pairs(self.w_options) do
        vim.wo[k] = v
    end
    for k,v in pairs(self.b_options) do
        vim.bo[k] = v
    end
end

return options
