local _cfg_r = {
    'R-nvim/r.nvim',
    config = function()
        require("r").setup({
            pipe_version = "native",
            hook = {
                on_filetype = function()
                vim.api.nvim_buf_set_keymap(0, "i", "<M-->", "<Plug>RInsertAssign", { noremap = true })
                vim.api.nvim_buf_set_keymap(0, "i", "<M-.>", "<Plug>RInsertPipe", { noremap = true })
                if vim.bo.filetype == "rnoweb" then
                    vim.api.nvim_buf_set_keymap(0, "i", "<", "<Plug>RnwInsertChunk", { noremap = true })
                elseif vim.bo.filetype == "rmd" or vim.bo.filetype == "quarto" then
                    vim.api.nvim_buf_set_keymap(0, "i", "`", "<Plug>RmdInsertChunk", { noremap = true })
                end
                end,
                after_R_start = function()
                    vim.api.nvim_buf_set_keymap(0, "n", "<M-Enter>", "<Plug>RDSendLine", {noremap = true})
                    vim.api.nvim_buf_set_keymap(0, "v", "<M-Enter>", "<Plug>RSendSelection", {noremap = true})
                end
            },
            -- register_treesitter = false
        })
    end
}

local _cfg_dap = {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')
        dap.adapters.debugpy = {
            type = 'executable',
            command = 'python',
            args = { '-m', 'debugpy.adapter' },
        }
    end
}

return {
    _cfg_r,
    _cfg_dap,
}
