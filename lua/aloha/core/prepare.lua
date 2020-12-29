----------------------------------------------------------------------------------------
--                             \ Check and Preparation /                              --
----------------------------------------------------------------------------------------
_G.aloha.prepare = {}
local prepare = _G.aloha.prepare

local utils = aloha.utils
local global = aloha.global
local g = vim.g

-------------------------------------\ check dirs /-------------------------------------
function prepare.check_dirs()
    ----------------
    -- cache dirs --
    ----------------
    for _,cache_dir in ipairs(global.paths.caches) do
        utils.mkdir(utils.join_paths(global.cache_base, cache_dir))
    end
end

----------------------------------\ neovim providers /----------------------------------
function prepare.set_providers()
    g.python_host_prog = global.providers.python
    g.python3_host_prog = global.providers.python3
    g.clipboard = global.providers.clipboard
end

----------------------------------------\ init /----------------------------------------
function prepare:init()
    self.check_dirs()
    self.set_providers()
end

return _G.aloha.prepare
