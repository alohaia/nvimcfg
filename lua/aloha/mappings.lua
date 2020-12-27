local settings = aloha.settings
local utils = aloha.utils

aloha.mappings = {}
local mappings = aloha.mappings

-- abbreviate

-- See :map-arguments
mappings.default_args = {
    noremap    = true,
    silent     = true,
}


--+---------------------------------------------------------------------------+
--| Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
--+------------------+--------+--------+---------+--------+--------+----------+
--| map  / noremap   |    @   |   -    |    -    |   @    |   @    |     @    |
--| nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |     -    |
--| vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |     -    |
--| omap / onoremap  |    -   |   -    |    -    |   -    |   -    |     @    |
--| xmap / xnormap   |    -   |   -    |    -    |   @    |   -    |     -    |
--| smap / snoremap  |    -   |   -    |    -    |   -    |   @    |     -    |
--| map! / noremap!  |    -   |   @    |    @    |   -    |   -    |     -    |
--| imap / inoremap  |    -   |   @    |    -    |   -    |   -    |     -    |
--| cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |     -    |
--+------------------+--------+--------+---------+--------+--------+----------+

mappings.keymappings = {
    -- mode keys content extra
    {'n', ';', ':', {silent = false, nowait = true }},
    {'n', ':', ';'},
    {'x', ';', ':', {silent = false, nowait = true }},
    {'x', ':', ';'},

    {'n', 'J', '5j'},
    {'n', 'K', '5k'},
    {'x', 'J', '5j'},
    {'x', 'K', '5k'},

    -- {'x', '*', '/\<<C-r><C-w>\><Cr>'}
    {'n', 'n', 'nzz'},
    {'n', 'N', 'Nzz'},

    {'n', '<esc>', '<Cmd>nohl<cr>'},

    {'n', 'Y', 'y$'},

    {'i', '<M-BS>', '<Del>'},

    {'n', '<C-h>', '<C-w><C-h>'},
    {'n', '<C-j>', '<C-w><C-j>'},
    {'n', '<C-k>', '<C-w><C-k>'},
    {'n', '<C-l>', '<C-w><C-l>'},
    {'x', '<C-h>', '<C-w><C-h>'},
    {'x', '<C-j>', '<C-w><C-j>'},
    {'x', '<C-k>', '<C-w><C-k>'},
    {'x', '<C-l>', '<C-w><C-l>'},

    {'n', '-', '<Cmd>bp<cr>'},
    {'n', '=', '<Cmd>bn<cr>'},
    {'n', '<c-b>n',     '<Cmd>bnext<cr>'},
    {'n', '<c-b><c-n>', '<Cmd>bnext<cr>'},
    {'n', '<c-b>p',     '<Cmd>bprevious<cr>'},
    {'n', '<c-b><c-p>', '<Cmd>bprevious<cr>'},
    {'x', '-', '<Cmd>bp<cr>'},
    {'x', '=', '<Cmd>bn<cr>'},
    {'x', '_', '<Cmd>tabprevious<cr>'},
    {'x', '+', '<Cmd>tabnext<cr>'},
    {'n', '<leader>ba', '<Cmd>bufdo bd<cr>'},

    -- gt gT
    {'n', '<leader>tn', '<Cmd>tabnew<cr>'},
    {'n', '<leader>tc', '<Cmd>tabclose<cr>'},
    {'n', '<leader>to', '<Cmd>tabonly<cr>'},
    {'n', '<leader>tm', '<Cmd>tabmove<space>'},
    {'n', ']T', '<Cmd>tablast<cr>'},
    {'n', '[T', '<Cmd>tabfirst<cr>'},

    {'i', '<UP>',    '<Nul>'},
    {'i', '<DOWN>',  '<Nul>'},
    {'i', '<Left>',  '<Nul>'},
    {'i', '<Right>', '<Nul>'},

    {'n', '<UP>',    '<Cmd>res +5<CR>'},
    {'n', '<DOWN>',  '<Cmd>res -5<CR>'},
    {'n', '<Left>',  '<Cmd>vertical resize-5<CR>'},
    {'n', '<Right>', '<Cmd>vertical resize+5<CR>'},

    {'i', '<M-h>',   '<Left>'},
    {'i', '<M-l>',   '<Right>'},
    {'i', '<M-k>',   '<Up>'},
    {'i', '<M-j>',   '<Down>'},
    {'i', '<M-a>',   '<Home>'},
    {'i', '<M-d>',   '<End>'},

    {'n', '<UP>',    '<Cmd>res +1<CR>'},
    {'n', '<DOWN>',  '<Cmd>res -1<CR>'},
    {'n', '<Left>',  '<Cmd>vert res +1<CR>'},
    {'n', '<Right>', '<Cmd>vert res -1<CR>'},

    {'n', '<M-k>', [[mz:m-2<cr>`z]]},
    {'n', '<M-j>', [[mz:m+<cr>`z]]},
    {'x', '<M-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]]},
    {'x', '<M-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]]},
    {'n', '<M-l>', [["zxl"zP]]},
    {'n', '<M-h>', [["zxh"zP]]},
    {'x', '<M-l>', [["zxl"z`<v`>P]]},
    {'x', '<M-h>', [["zxh"zP`<v`>]]},

    -- c_Ctrl-A is built-in to "Get all"
    {'c', '<C-p>', '<Up>'},
    {'c', '<C-n>', '<Down>'},
    {'c', '<M-h>', '<Left>'},
    {'c', '<M-l>', '<Right>'},
    -- Besides <M-v>
    -- Use <C-q> instead
    {'c', '<C-v>', '<C-r>"', {silent = false}},
    -- {'c', '<C-p>', '<Up>'},
    -- {'c', '<C-n>', '<Down>'},

    {'n', '<leader>o', 'mzo<esc>`z'},
    {'n', '<leader>O', 'mzO<esc>`z'},

    {'n', '<leader>H', ':vert h<space>'},
    {'n', '<leader>o', 'mzo<esc>`z'},
    {'n', '<leader>O', 'mzO<esc>`z'},

    {'n', '<leader>e', ':cd '..settings.config_dir..'/lua/aloha<cr>:e<space><C-z>', {silent = false}},

    {'c', '<M-e>', "getcmdtype()==':' ? expand('%:p:h').'/' : '%%'", {silent = false, expr = true}},
    {'c', '<C-e>', "getcmdtype()==':' ? 'e ' . expand('%:p:h').'/' : '%%'", {silent = false, expr = true}},

    {'i', '<C-s>', "<c-g>u<Esc>[s1z=`]a<c-g>u"},

    {'n', '<C-c>', [["+yW""yW]]},
    {'v', '<C-c>', [["+ygv""y]]},

    {'n', '<leader>p', ':lua print(vim.o.<C-r><C-w>)<CR>', {silent = false}},
    {'n', '<leader>b', ':lua print(vim.bo.<C-r><C-w>)<CR>', {silent = false}},
    {'n', '<leader>w', ':lua print(vim.wo.<C-r><C-w>)<CR>', {silent = false}},
}

function mappings:init()
    vim.g.mapleader = settings.mapleader
    self.keymappings = utils.merge(self.keymappings, _G.aloha.mapping_addition)
    for _,map in pairs(self.keymappings) do
        -- print(map[2])
        vim.api.nvim_set_keymap(map[1], map[2], map[3], utils.merge(self.default_args, map[4]))
    end
end

return mappings
