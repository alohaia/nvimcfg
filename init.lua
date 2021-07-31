require("aloha")

vim.cmd[[
command PackInstall lua aloha.packer:download()
command PackUpdate  lua aloha.packer:download('update')
command PackClean   lua aloha.packer:clean()
command PackSync    lua aloha.packer:clean(); aloha.packer:download('update')
]]
