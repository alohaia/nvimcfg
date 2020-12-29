----------------------------------------------------------------------------------------
--                                \ Global Variables /                                --
----------------------------------------------------------------------------------------
_G.aloha.global = {}
local global = _G.aloha.global

---------------------------
-- environment variables --
---------------------------
-- Windows Linux OSX BSD POSIX Other
global.os_name = jit.os
-- Detect gui
global.is_gui = vim.fn.has('gui_running') == 1

-----------
-- paths --
-----------
global.paths = {
    home = vim.loop.os_homedir(),
    -- home = os.getenv('HOME'),
    config = vim.fn.stdpath("config"),
    cache_base  = vim.fn.stdpath("cache"),
    -- cache dirs under cache base
    caches = {
        swap = 'swap',
        undo = 'undo',
        backup = 'backup'
    },
}

----------------------
-- neovim providers --
----------------------
global.providers = {
    python = '/usr/bin/python',
    python3 = '/usr/bin/python3',
    clipboard = {
        name = 'neovim-xclip',
        copy = {
            ['+'] = {'xclip', '-i', '-selection', 'clipboard'}, 
            ['*'] = {'xclip', '-i', '-selection', 'primary'},
        },
        copy = {
            ['+'] = {'xclip', '-o', '-selection', 'clipboard'}, 
            ['*'] = {'xclip', '-o', '-selection', 'primary'},
        }
    }
}

return _G.aloha.global
