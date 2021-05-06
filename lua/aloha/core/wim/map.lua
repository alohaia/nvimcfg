----------------------------------------------------------------------------------------
--                                    \ Mappings /                                    --
----------------------------------------------------------------------------------------
_G.aloha.wim.map = {}
local map = _G.aloha.wim.map

map.list = {}
map.leader = ' '
map.default_args = setmetatable({
    silent = true,
    noremap = true
}, {
    __add = function(tbl_o, tbl_n)
        if tbl_n ~= nil then
            vim.validate{
                tbl_n = {tbl_n, 't'}
            }
            for k,v in pairs(tbl_n) do
                tbl_o[k] = v
            end
        end
        return tbl_o
    end
}

)


-------------------\ add mappings at any time bofore initialization /-------------------
-- @map_list: {'x', ';', ':', {silent = false, nowait = true }}, ...
function map.add_maps(...)
    vim.list_extend(map.list, {...})
end
-- @map: 'x', ';', ':', {silent = false, nowait = true }
function map.add_map(...)
    table.insert(map.list, {...})
end

function map:init()
    vim.g.mapleader = map.leader
    for _,map in pairs(self.list) do
        vim.api.nvim_set_keymap(map[1], map[2], map[3], self.default_args + map[4])
    end
end

return _G.aloha.wim.map
