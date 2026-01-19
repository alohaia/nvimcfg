return {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes
        -- #sorting-files-naturally-respecting-numbers-within-files-names
        local function natural_cmp(left, right)
            if left.type == 'directory' and right.type ~= 'directory' then
                return true  -- folders_first
            end
            if left.type ~= 'directory' and right.type == 'directory' then
                return false -- files_last
            end

            left = left.name:lower()
            right = right.name:lower()

            if left == right then
                return false
            end

            for i = 1, math.max(string.len(left), string.len(right)), 1 do
                local l = string.sub(left, i, -1)
                local r = string.sub(right, i, -1)

                if
                    type(tonumber(string.sub(l, 1, 1))) == 'number'
                    and type(tonumber(string.sub(r, 1, 1))) == 'number'
                then
                    local l_number = tonumber(string.match(l, '^[0-9]+'))
                    local r_number = tonumber(string.match(r, '^[0-9]+'))

                    if l_number ~= r_number then
                        return l_number < r_number
                    end
                elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
                    return l < r
                end
            end
        end

        -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
        local function tab_win_closed(winnr)
            local api = require'nvim-tree.api'
            local tabnr = vim.api.nvim_win_get_tabpage(winnr)
            local bufnr = vim.api.nvim_win_get_buf(winnr)
            local buf_info = vim.fn.getbufinfo(bufnr)[1]
            local tab_wins = vim.tbl_filter(
                function(w)
                    return w~=winnr
                end,
                vim.api.nvim_tabpage_list_wins(tabnr)
            )
            local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
            if buf_info.name:match('.*NvimTree_%d*$') then
                -- Close all nvim tree on :q
                if not vim.tbl_isempty(tab_bufs) then
                    api.tree.close()
                end
            else
                if #tab_bufs == 1 then
                    local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
                    if last_buf_info.name:match('.*NvimTree_%d*$') then
                        vim.schedule(function ()
                            if #vim.api.nvim_list_wins() == 1 then
                                vim.cmd 'quit'
                            else
                                vim.api.nvim_win_close(tab_wins[1], true)
                            end
                        end)
                    end
                end
            end
        end
        vim.api.nvim_create_autocmd('WinClosed', {
            callback = function ()
                local winnr = tonumber(vim.fn.expand('<amatch>'))
                vim.schedule_wrap(tab_win_closed(winnr))
            end,
            nested = true
        })

        -- vim.g.loaded_netrw = 1
        -- vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup {
            renderer = {
                group_empty = true,
                full_name = true,
                hidden_display = 'all',
                highlight_git = 'icon',
                highlight_diagnostics = 'name',
                indent_markers = {
                    enable = true,
                    inline_arrows = false,
                },
                icons = {
                    glyphs = {
                        git = {
                            unstaged  = '󰄱',
                            staged    = '󰱒',
                            untracked = '?',
                        },
                    },
                },
            },
            sort = {
                sorter = function(nodes)
                    table.sort(nodes, natural_cmp)
                end,
            },
            update_focused_file = {
                enable = true,
                update_root = {
                    enable = true,
                },
                ignore_list = {
                    'help'
                }
            },
            diagnostics = {
                enable = true,
                icons = {
                    hint = 'H',
                    info = 'I',
                    warning = 'W',
                    error = 'E'
                },
            },
            git = { enable = true },
            modified = { enable = true },
        }

        vim.api.nvim_set_keymap(
            'n', '<C-CR>', '<Cmd>NvimTreeToggle<CR>',
            {silent = true, noremap = true}
        )

        -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes
        -- #workaround-when-using-rmagattiauto-session
        vim.api.nvim_create_autocmd({ 'BufEnter' }, {
            pattern = 'NvimTree*',
            callback = function()
                local api = require('nvim-tree.api')

                if not api.tree.is_visible() then
                api.tree.open()
                end
            end,
        })
    end
}
