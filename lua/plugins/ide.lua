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

local _cfg_auto_session = {
    "rmagatti/auto-session",
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        auto_restore = false,
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        -- log_level = 'debug',
    }
}

local _cfg_which_key = {
    'folke/which-key.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        vim.keymap.set("n", "<leader>?", function()
            require("which-key").show({ global = false })
        end, { desc = "Buffer Local Keymaps (which-key)" })
    end,
}

local _cfg_outline = {
    'hedyhli/outline.nvim',
    config = function()
        vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
        require("outline").setup {
            auto_close = true,
        }
    end
}


return {
    _cfg_r,
    _cfg_dap,
    { 'fladson/vim-kitty', ft='kitty' },
    _cfg_auto_session,
    _cfg_which_key,
    _cfg_outline,
}
