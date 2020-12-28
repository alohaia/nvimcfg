----------------------------------------------------------------------------------------
--                                \ Global Variables /                                --
----------------------------------------------------------------------------------------
_G.aloha.global = {}
local global = aloha.global

-- Mac:'Darwin' Linux:'Linux' Windows:'Windows'
local os_name = vim.loop.os_uname().sysname

-- Detect gui
global.is_gui = vim.fn.has('gui_running') == 1

---------------------------------------\ paths /----------------------------------------
global.paths = {
    home = os.getenv('HOME'),
    config = vim.fn.stdpath("config")
    cache_base  = vim.fn.stdpath("cache"),
    caches = { 'swap', 'undo', 'backup' },
}

return _G.aloha.global
