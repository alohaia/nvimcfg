local _cfg_ts = {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context'
    },
    config = function()
        local ts_langs = {
            'vim', 'lua', 'c', 'cpp', 'cmake', 'bash', 'rust',
            'python', 'r', 'rnoweb',
            'yaml', 'toml', 'json', 'markdown', 'latex',
            'html', 'javascript', 'css',
        }
        require'nvim-treesitter'.install(ts_langs)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = ts_langs,
            callback = function ()
                vim.treesitter.start()
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[0][0].foldmethod = 'expr'
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end

        })
    end
}

return {
    _cfg_ts,
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main'
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        config = function ()
            require'treesitter-context'.setup {
                enable = false,
                multiwindow = true
            }
            vim.keymap.set("n", "<Leader>tc", function()
                require"treesitter-context".toggle()
            end, { desc = "Toggle treesitter-context" })
        end
    }
}


