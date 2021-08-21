require("aloha")({
    -- disable unnecessary operations
    minimal = true,
    -- 'minimal' is overrided by the options below
    create_dirs = false,
    install_plugins = false,
    sync_plugins = false,
})

vim.cmd("source " .. vim.env.HOME .. "/.config/nvim/remain.vim")
