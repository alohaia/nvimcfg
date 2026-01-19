local _cfg_gitsigns = {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('gitsigns').setup {
            numhl              = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 200,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            }
        }
    end
}

local _cfg_fugitive = {
    'tpope/vim-fugitive'
}

return {
    _cfg_gitsigns,
    _cfg_fugitive,
}
