----------------------------------------------------------------------------------------
--                                 \ Auto Commands /                                  --
----------------------------------------------------------------------------------------
_G.aloha.wim.au = {}
local au = _G.aloha.wim.au

local global = _G.aloha.global

function au:init()
    vim.cmd('source '..global.paths.config..'/lua/aloha/remain/autocommands.vim')
end

return _G.aloha.wim.au
