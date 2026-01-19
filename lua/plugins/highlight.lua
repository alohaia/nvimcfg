local _cfg_treesitter = {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context'
    },
    config = function()
        -- required by R.nvim
        -- r, markdown, markdown_inline, rnoweb, yaml, latex, and csv.
        local ts_langs = {
            'vim', 'lua', 'c', 'cpp', 'cmake', 'bash', 'rust',
            'python', 'r', 'rnoweb', 'csv',
            'yaml', 'toml', 'json', 'markdown', 'markdown_inline', 'latex',
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

local _cfg_log_highlight = {
    'fei6409/log-highlight.nvim',
    config = function()
        require('log-highlight').setup {
            ---@type string|string[]: File extensions. Default: 'log'
            extension = 'log',

            ---@type string|string[]: File names or full file paths. Default: {}
            filename = {
                'syslog',
            },

            ---@type string|string[]: File name/path glob patterns. Default: {}
            pattern = {
                -- Use `%` to escape special characters and match them literally.
                '%/var%/log%/.*',
                'console%-ramoops.*',
                'log.*%.txt',
                'logcat.*',
            },

            ---@type table<string, string|string[]>: Custom keywords to highlight.
            ---This allows you to define custom keywords to be highlighted based on
            ---the group.
            ---
            ---The following highlight groups are supported:
            ---    'error', 'warning', 'info', 'debug' and 'pass'.
            ---
            ---The value for each group can be a string or a list of strings.
            ---All groups are empty by default. Keywords are case-sensitive.
            keyword = {
                error = 'ERROR_MSG',
                warning = { 'WARN_X', 'WARN_Y' },
                info = { 'INFORMATION' },
                debug = {},
                pass = {},
            },
        }
    end
}

return {
    _cfg_treesitter,
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
    },
    _cfg_log_highlight,
}


