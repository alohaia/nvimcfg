----------------------------------------------------------------------------------------
--                                    \ Mappings /                                    --
----------------------------------------------------------------------------------------
_G.aloha.wim.map = {}
local map = _G.aloha.wim.map

local utils = _G.aloha.utils

map.list = {}
map.leader = ' '
map.default_args = {
    silent = true,
    noremap = true
}

-------------------\ add mappings at any time bofore initialization /-------------------
-- @map_list: {{'x', ';', ':', {silent = false, nowait = true }}, ...}
function map.add_maps(...)
    map.list = utils.merge(map.list, {...})
end
-- @map: 'x', ';', ':', {silent = false, nowait = true }
function map.add_map(...)
    table.insert(map.list, {...})
end

function map:init()
    vim.g.mapleader = map.leader
    for _,map in pairs(self.list) do
        vim.api.nvim_set_keymap(map[1], map[2], map[3], aloha.utils.merge(self.default_args, map[4]))
    end
end

return _G.aloha.wim.map
