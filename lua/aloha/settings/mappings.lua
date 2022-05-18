return {
    -- mode keys content extra
    {'n', ';', ':', {silent = false, nowait = true }},
    {'n', ':', ';'},
    {'x', ';', ':', {silent = false, nowait = true }},
    {'x', ':', ';'},

    {'n', 'J', '5j'},
    {'n', 'K', '5k'},
    {'x', 'J', '5j'},
    {'x', 'K', '5k'},

    {'n', '<leader>n', 'nzz'},
    {'n', '<leader>N', 'Nzz'},

    {'n', '<esc>', '<Cmd>nohl<cr>'},

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

    {'n', '-', '<Cmd>bp<cr>'},
    {'x', '-', '<Cmd>bp<cr>'},
    {'n', '=', '<Cmd>bn<cr>'},
    {'x', '=', '<Cmd>bn<cr>'},
    {'n', '_', '<Cmd>tabprevious<cr>'},
    {'x', '_', '<Cmd>tabprevious<cr>'},
    {'n', '+', '<Cmd>tabnext<cr>'},
    {'x', '+', '<Cmd>tabnext<cr>'},

    {'n', '<leader>bd', '<Cmd>bd<cr>'},
    {'n', '<leader>ba', '<Cmd>bufdo bd<cr>'},
    {'n', '<leader>bo', '<Cmd>%bd|e#|bd#<cr>'},

    -- gt gT
    {'n', '<leader>tn', '<Cmd>tabnew<cr>'},
    {'n', '<leader>tc', '<Cmd>tabclose<cr>'},
    {'n', '<leader>to', '<Cmd>tabonly<cr>'},
    {'n', ']t', '<Cmd>tablast<cr>'},
    {'n', '[t', '<Cmd>tabfirst<cr>'},

    {'n', '<UP>',    '<Cmd>res +5<CR>'},
    {'n', '<DOWN>',  '<Cmd>res -5<CR>'},
    {'n', '<Left>',  '<Cmd>vertical resize-5<CR>'},
    {'n', '<Right>', '<Cmd>vertical resize+5<CR>'},

    {'i', '<M-h>',   '<Left>'},
    {'i', '<M-l>',   '<Right>'},
    {'i', '<M-k>',   '<Up>'},
    {'i', '<M-j>',   '<Down>'},

    {'n', '<M-k>', [[mz:m-2<cr>`z]]},
    {'n', '<M-j>', [[mz:m+<cr>`z]]},
    {'x', '<M-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]]},
    {'x', '<M-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]]},
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
    {'x', '<C-c>', [["+ygv""y]]},

    -- {'i', '<M-i>', '<C-r>=Ocr()<cr>'},

    {'t', '<M-q>', '<C-\\><C-n>'},

    {'i', '<M-a>', '<ESC>^i'},
    {'i', '<M-e>', '<END>'},

    {'n', '<Leader>ws', [[i<Space><Esc>ea<Space><Esc>]]},
    {'x', 'as', [[<ESC>`<lt>i<Space><Esc>`>la<Space><Esc>]]}
}
