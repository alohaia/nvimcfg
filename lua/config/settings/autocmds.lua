local aus =  {
    {'TextYankPost', {
        pattern = '*',
        desc = 'Highlight just yanked text',
        callback = function ()
            vim.highlight.on_yank {higroup='IncSearch', timeout=150, on_visual=true}
        end
    }},
    -- https://www.reddit.com/r/neovim/comments/1lyuz6k/comment/n32ymm8/
    {'BufWinEnter', {
        pattern = '*',
        desc = 'Restore last position after reopened a file',
        callback = function(ev)
            if
                vim.wo.diff              -- exclude diff
                or ({                    -- exclude filetypes below
                    gitcommit = true,
                    gitrebase = true,
                    xxd = true,
                })[vim.bo[ev.buf].filetype]
            then
                return
            end

            local lastpos = vim.api.nvim_buf_get_mark(ev.buf, '"')
            if pcall(vim.api.nvim_win_set_cursor, 0, lastpos) then
                vim.cmd("normal! zz")
            end
        end,
    }}
}

-------------------
-- set autocmds ---
-------------------
local aug = vim.api.nvim_create_augroup('init_autocmds', { clear = true })
for _,au in ipairs(aus) do
    vim.api.nvim_create_autocmd(au[1], {
        group = aug,
        pattern = au[2].pattern,
        callback = au[2].callback
    })
end

