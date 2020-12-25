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
    {'n', '_', '<Cmd>tabprevious<cr>'},
    {'n', '+', '<Cmd>tabnext<cr>'},
    {'x', '-', '<Cmd>bp<cr>'},
    {'x', '=', '<Cmd>bn<cr>'},
    {'x', '_', '<Cmd>tabprevious<cr>'},
    {'x', '+', '<Cmd>tabnext<cr>'},

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

    {'n', '<leader>p', ':lua print(vim.o.<C-r><C-w>)<CR>', {silent = false}},
    {'n', '<leader>b', ':lua print(vim.bo.<C-r><C-w>)<CR>', {silent = false}},
    {'n', '<leader>w', ':lua print(vim.wo.<C-r><C-w>)<CR>', {silent = false}},

    {'c', '<M-p>', "getcmdtype()==':' ? expand('%:p:h').'/' : '%%'", {silent = false, expr = true}},
    -- {'n', '<leader><leader>', ':<C-u>WhichKey ""<Left>', {silent = false}},
}

function mappings:init()
    vim.g.mapleader = settings.mapleader
    self.keymappings = utils.merge(self.keymappings, _G.aloha.mapping_addition)
    for _,map in pairs(self.keymappings) do
        vim.api.nvim_set_keymap(map[1], map[2], map[3], utils.merge(self.default_args, map[4]))
    end
end

return mappings
