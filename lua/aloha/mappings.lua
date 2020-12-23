local settings = require"aloha.settings"
local functions = require"aloha.functions"

mappings = {}

-- abbreviate

-- See :map-arguments
mappings.default_args = {
    noremap    = true,
    silent     = true,
    unique     = true
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
    -- {'n', ';', ':', { nowait = true }},
    -- {'n', ':', ';'},
    -- {'x', ';', ':', { nowait = true }},
    -- {'x', ':', ';'},
    {'n', 'J', '5j'},
    {'n', 'K', '5k'},
    {'x', 'J', '5j'},
    {'x', 'K', '5k'},
    {'n', '<C-h>', '<C-w><C-h>'},
    {'n', '<C-j>', '<C-w><C-j>'},
    {'n', '<C-k>', '<C-w><C-k>'},
    {'n', '<C-l>', '<C-w><C-l>'},

    {'n', '-', '<Cmd>bp<cr>'},
    {'n', '=', '<Cmd>bn<cr>'},
    {'n', '_', '<Cmd>tabprevious<cr>'},
    {'n', '+', '<Cmd>tabnext<cr>'},

    {'i', '<UP>',    '<Nul>'},
    {'i', '<DOWN>',  '<Nul>'},
    {'i', '<Left>',  '<Nul>'},
    {'i', '<Right>', '<Nul>'},

    {'n', '<UP>',    '<Cmd>res +1<CR>'},
    {'n', '<DOWN>',  '<Cmd>res -1<CR>'},
    {'n', '<Left>',  '<Cmd>vert res +1<CR>'},
    {'n', '<Right>', '<Cmd>vert res -1<CR>'},

    {'n', '<leader>o', 'mzo<esc>`z'},
    {'n', '<leader>O', 'mzO<esc>`z'},

    {'n', '<leader>h', "<Cmd>h '<C-r>C-w>'<cr>"},

    {'c', '%%', "getcmdtype()==':' ? expand('%:p:h').'/' : '%%'", {expr = true}}
}

function mappings:init()
    vim.g.mapleader = settings.mapleader
    for _,map in pairs(self.keymappings) do
        -- eg. vim.api.nvim_set_keymap('n', '<leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
        vim.api.nvim_set_keymap(map[1], map[2], map[3], functions.merge(self.default_args, map[4]))
    end
end

return mappings
