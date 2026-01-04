return {
    'mfussenegger/nvim-lint',
    config = function ()
        require('lint').linters_by_ft = {
            markdown = {'vale'},
            bash = {'bash'},
            zsh = {'zsh'},
            cpp = {'clang-tidy'},
            lua = {'luacheck'},
            python = {'ruff'}
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}
