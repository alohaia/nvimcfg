----------------------------------------------------------------------------------------
--                           \ Provide Some Tools for Lua /                           --
----------------------------------------------------------------------------------------
_G.aloha.utils.tools = {}
local tools = _G.aloha.utils.tools = {}

-------------------------\ merge without change original tabs /-------------------------
function tools.merge(...)
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
function tools.len(t)
  local leng=0
  for k, v in pairs(t) do
    leng=leng+1
  end
  return leng;
end

---------------------------------------\ mkdir /----------------------------------------
-- function tools.mkdir(dir)
--     if aloha.settings.os_name == 'Darwin' or aloha.settings.os_name == 'Linux' then
--         os.execute('mkdir -p '..dir)
--     elseif aloha.settings.os_name == "Windows" then
--         os.execute('mkdir '..dir)
--     end
-- end
function tools.mkdir(dir)
    os.execute('mkdir -p '..dir)
end

-------------------------------------\ join paths /-------------------------------------
function tools.join_paths(path1, path2, ...)
    local path_sep = aloha.global.os_name == 'Windows' and '\\' or '/'
    local joined = path1 .. path_sep .. path2
    for _,path in ipairs({...}) do
        joined = joined .. path_sep .. path
    end
    return joined
end

-------------------\ add mappings at any time bofore initialization /-------------------
_G.aloha.mapping_addition = {}
-- Must be called before 
-- eg. Use in lua/aloha/plugins/config.lua for plugin mappings
-- @map_list: {{'x', ';', ':', {silent = false, nowait = true }}, ...},
function tools.add_maps(...)
    _G.aloha.mapping_addition = tools.merge(_G.aloha.mapping_addition, {...})
end
-- Must be called before 
-- eg. Use in lua/aloha/plugins/config.lua for plugin mappings
-- @map: {'x', ';', ':', {silent = false, nowait = true }},
function tools.add_map(...)
    table.insert(_G.aloha.mapping_addition, {...})
end

return _G.aloha.utils.tools
