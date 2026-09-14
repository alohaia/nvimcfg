-- filetypes
vim.filetype.add({
    pattern = {
        [".*/0/.*%.gz"] = "foam",
        [".*/[0-9.]+/.*%.gz"] = "foam",
        [".*/constant/.*%.gz"] = "foam",
    },
})


-- Neovim native settings
require('config.settings')

-- Plugins
require('config.plugins')
