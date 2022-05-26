

return {
    { 'BufWritePre', {
        pattern = {
            '*.c', '*.cpp', '*.h', '*.py', '*.lua', '*.sh',
            '*.md', '*.markdown', '*.Rmd', '*.Rmarkdown', '*.txt',
            '*.js', '*.html', '*.css', '*.scss'
        },
        callback = function ()
            local save_cursor = vim.fn.getpos('.')
            local save_query = vim.fn.getreg('/')
            vim.cmd[[silent! %s/\s\+$//e]]
            vim.fn.setpos('.', save_cursor)
            vim.fn.setreg('/', save_query)
        end
    }},
    { 'FileType', {
        pattern = {'cpp', 'c'},
        command = [[setlocal path+=./include]]
    }},
    { 'FileType', {
        pattern = {'markdown', 'rmd', 'text'},
        command = [[setlocal spell]]
    }},
    { 'TextYankPost', {
        pattern = '*',
        callback = function ()
            vim.highlight.on_yank {higroup='IncSearch', timeout=150, on_visual=true}
        end
    }},
}
