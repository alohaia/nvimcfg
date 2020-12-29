----------------------------------------------------------------------------------------
--                           \ Provide Some Tools for Lua /                           --
----------------------------------------------------------------------------------------
_G.aloha.utils = {}
local utils = _G.aloha.utils

local global = aloha.global

-------------------------\ merge without change original tabs /-------------------------
function utils.merge(...)
    local tabs = {...}
    if not tabs then
        return {}
    end
    local sum = {}
    for i = 1,#tabs do
        if tabs[i] then
            for k,v in pairs(tabs[i]) do
                if type(k) == 'number' then
                    table.insert(sum, v)
                else
                    sum[k] = v
                end
            end
        end
    end
    return sum
end

------------------------------------\ len of table /------------------------------------
-- see :h vim.tbl_count
-- function utils.len(t)
--   local leng=0
--   for k, v in pairs(t) do
--     leng=leng+1
--   end
--   return leng;
-- end
utils.len = vim.tbl_count

---------------------------------------\ mkdir /----------------------------------------
utils.mkdir = vim.fn.mkdir
-- function utils.mkdir(dir)
--     if global.os_name == 'Darwin' or global.os_name == 'Linux' then
--         os.execute('mkdir -p '..dir)
--     elseif global.os_name == "Windows" then
--         os.execute('mkdir '..dir)
--     end
-- end

-------------------------------------\ join paths /-------------------------------------
function utils.join_paths(path1, path2, ...)
    local path_sep = global.os_name == 'Windows' and '\\' or '/'
    local joined = path1 .. path_sep .. path2
    for _,path in ipairs({...}) do
        joined = joined .. path_sep .. path
    end
    return joined
end

return _G.aloha.utils
