-- check and create dirs
for _,path in ipairs({vim.o.backupdir, vim.o.directory, vim.o.undodir}) do
    if path ~= nil and path ~= '' then
        path = string.gsub(path, '^~', vim.env.HOME)
        if vim.fn.glob(path) == '' then
            print('create dir: ' .. path)
            vim.fn.mkdir(path, 'p')
        end
    end
end

-- clean and update/install plugins
aloha.packer:uninstall()
aloha.packer:download('update')
