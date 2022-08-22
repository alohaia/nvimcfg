return {
    -- mode keys content extra
    {'n', ';', ':', {silent = false, nowait = true }},
    {'n', ':', ';'},
    {'x', ';', ':', {silent = false, nowait = true }},
    {'x', ':', ';'},

    {'n', 'j', 'gj'},
    {'n', 'gj', 'j'},
    {'n', 'k', 'gk'},
    {'n', 'gk', 'k'},
    {'x', 'j', 'gj'},
    {'x', 'gj', 'j'},
    {'x', 'k', 'gk'},
    {'x', 'gk', 'k'},

    {'n', 'J', '5gj'},
    {'n', 'K', '5gk'},
    {'x', 'J', '5gj'},
    {'x', 'K', '5gk'},

    {'n', '<leader>n', 'nzz'},
    {'n', '<leader>N', 'Nzz'},

    {'n', '<esc>', '<Cmd>nohl<CR>'},

    {'n', 'Y', 'y$'},

    {'i', '<M-BS>', '<Del>'},
    {'i', '<M-CR>', '<ESC>o'},

    {'n', '<C-h>', '<C-w><C-h>'},
    {'n', '<C-j>', '<C-w><C-j>'},
    {'n', '<C-k>', '<C-w><C-k>'},
    {'n', '<C-l>', '<C-w><C-l>'},
    {'x', '<C-h>', '<C-w><C-h>'},
    {'x', '<C-j>', '<C-w><C-j>'},
    {'x', '<C-k>', '<C-w><C-k>'},
    {'x', '<C-l>', '<C-w><C-l>'},

    {'n', '-', '<Cmd>bp<CR>'},
    {'x', '-', '<Cmd>bp<CR>'},
    {'n', '=', '<Cmd>bn<CR>'},
    {'x', '=', '<Cmd>bn<CR>'},
    {'n', '_', '<Cmd>tabprevious<CR>'},
    {'x', '_', '<Cmd>tabprevious<CR>'},
    {'n', '+', '<Cmd>tabnext<CR>'},
    {'x', '+', '<Cmd>tabnext<CR>'},

    -- {'n', '<leader>bd', '<Cmd>let _bd_nr = bufnr() | b# | sp | exec "bd "._bd_nr<CR>'},
    -- {'n', '<leader>bd', '<Cmd>bp|sp|bn|bd<CR>'},
    {'n', '<leader>bd', '<Cmd>lua aloha.utils.bufdelete()<CR>'},
    {'n', '<leader>ba', '<Cmd>bufdo bd<CR>'},
    {'n', '<leader>bo', '<Cmd>%bd|e#|bd#<CR>'},

    -- gt gT
    {'n', '<leader>tn', '<Cmd>tabnew<CR>'},
    {'n', '<leader>tc', '<Cmd>tabclose<CR>'},
    {'n', '<leader>to', '<Cmd>tabonly<CR>'},
    {'n', ']t', '<Cmd>tablast<CR>'},
    {'n', '[t', '<Cmd>tabfirst<CR>'},

    {'n', '<UP>',    '<Cmd>res +5<CR>'},
    {'n', '<DOWN>',  '<Cmd>res -5<CR>'},
    {'n', '<Left>',  '<Cmd>vertical resize-5<CR>'},
    {'n', '<Right>', '<Cmd>vertical resize+5<CR>'},

    {'i', '<M-h>',   '<Left>'},
    {'i', '<M-l>',   '<Right>'},
    {'i', '<M-k>',   '<Up>'},
    {'i', '<M-j>',   '<Down>'},

    {'n', '<M-k>', [[mz<Cmd>m-2<CR>`z]]},
    {'n', '<M-j>', [[mz<Cmd>m+<CR>`z]]},
    -- {'v', '<M-j>', [[:'<,'>m'>+<CR>`<my`>mzgv`yo`z]]},
    -- {'v', '<M-k>', [[:'<,'>m'<-2<CR>`>my`<mzgv`yo`z]]},
    {'v', '<M-j>', [[:'<,'>m'>+<CR>gv]]},
    {'v', '<M-k>', [[:'<,'>m'<-2<CR>gv]]},
    {'n', '<M-l>', [[5zh]]},
    {'n', '<M-h>', [[5zl]]},
    -- {'x', '<M-l>', [["zxl"z`<v`>P]]},
    -- {'x', '<M-h>', [["zxh"zP`<v`>]]},

    -- c_Ctrl-A is built-in to "Get all"
    -- Use <C-q> instead
    -- {'c', '<C-v>', '<C-r>"', {silent = false}},
    -- {'c', '<C-p>', '<Up>', {silent = false}},
    -- {'c', '<C-h>', '<Left>', {silent = false}},
    -- {'c', '<C-l>', '<Right>', {silent = false}},
    -- {'c', '<C-n>', '<Down>', {silent = false}},

    {'n', '<leader>o', 'mzo<esc>`z'},
    {'n', '<leader>O', 'mzO<esc>`z'},

    {'n', '<leader>e', ':e $HOME/.config/nvim/lua/aloha/<C-z>', {silent = false}},

    {'c', '<M-e>', "getcmdtype()==':' ? expand('%:p:h').'/' : ''", {silent = false, expr = true}},
    {'i', '<C-s>', "<c-g>u<Esc>[s1z=ea<c-g>u"},

    {'n', '<C-c>', [["+yW""yW]]},
    {'v', '<C-c>', [["+ygv""y]]},

    -- {'i', '<M-i>', '<C-r>=Ocr()<CR>'},

    {'t', '<M-q>', '<C-\\><C-n>'},

    {'i', '<M-a>', '<ESC>^i'},
    {'i', '<M-e>', '<END>'},

    {'n', '<Leader>ws', [[i<Space><Esc>ea<Space><Esc>]]},
    {'x', 'as', [[<ESC>`<lt>i<Space><Esc>`>la<Space><Esc>]]}
}
