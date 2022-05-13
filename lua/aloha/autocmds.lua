local newau = vim.api.nvim_create_autocmd

newau("BufWritePre", {
    pattern = {"*.c", "*.cpp", "*.h", "*.txt", "*.js", "*.py", "*.wiki", "*.sh", "*.coffee"},
    callback = function ()
        local save_cursor = vim.fn.getpos(".")
        local save_query = vim.fn.getreg("/")
        vim.cmd[[silent! %s/\s\+$//e]]
        vim.fn.setpos(".", save_cursor)
        vim.fn.setreg("/", save_query)
    end
})

newau("FileType", {
    pattern = {"cpp", "c"},
    command = [[setlocal path+=./include]]
})

newau("FileType", {
    pattern = {"markdown", "rmd", "text"},
    command = [[setlocal wrap spell]]
})

newau("FileType", {
    pattern = {"markdown", "rmd", "text"},
    command = [[setlocal wrap spell]]
})

newau("TextYankPost", {
    pattern = "*",
    callback = function ()
        vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
    end
})
