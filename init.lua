require("aloha")({
    -- disable unnecessary operations
    minimal = true,
    -- 'minimal' is overrided by the options below
    create_dirs = false,
    install_plugins = false,
    sync_plugins = false,
})

vim.cmd[[
command PackInstall lua aloha.packer:download()
command PackUpdate  lua aloha.packer:download('update')
command PackClean   lua aloha.packer:clean()
command PackSync    lua aloha.packer:clean(); aloha.packer:download('update')
]]
