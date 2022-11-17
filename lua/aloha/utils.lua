local M = {}

M.info = function (s, ...)
    vim.notify(string.format(s, ...), vim.log.levels.INFO)
end
M.warn = function (s, ...)
    vim.notify(string.format(s, ...), vim.log.levels.WARN)
end
M.err = function (s, ...)
    vim.notify(string.format(s, ...), vim.log.levels.ERROR)
end

M.getlistedbufs = function ()
    local bufs = {}
    for b=1,vim.fn.bufnr('$') do
        if vim.fn.buflisted(b) ~= 0 then
            table.insert(bufs, b)
        end
    end
    return bufs
end

M.bufdelete = function ()
    local bufs = M.getlistedbufs()
    local buf = vim.fn.bufnr()
    local wins = vim.fn.win_findbuf(buf)

    local buf_idx = vim.fn.index(bufs, buf) + 1
    table.remove(bufs, buf_idx)
    local new_buf = bufs[buf_idx] or bufs[buf_idx-1]
    if new_buf == nil then
        new_buf = vim.api.nvim_create_buf(false, false)
    end

    for _,w in ipairs(wins) do
        vim.api.nvim_win_set_buf(w, new_buf)
    end

    vim.cmd('bd ' .. tostring(buf))
end

M.meta_tbl_add = function(tbl_o, tbl_n)
    local new_table = vim.deepcopy(tbl_o)
    if tbl_n ~= nil then
        vim.validate{
            tbl_n = {tbl_n, 't'}
        }
        for k,v in pairs(tbl_n) do
            new_table[k] = v
        end
    end
    return new_table
end

return M
