aloha.utils = {}
local utils = aloha.utils

----------------------------------------------------------------------------------------
--                                 \ Tool Functions /                                 --
----------------------------------------------------------------------------------------

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

function utils.len(t)
  local leng=0
  for k, v in pairs(t) do
    leng=leng+1
  end
  return leng;
end

function utils.mkdir(dir)
    if aloha.settings.os_name == 'Darwin' or aloha.settings.os_name == 'Linux' then
        os.execute('mkdir -p '..dir)
    elseif aloha.settings.os_name == "Windows" then
        os.execute('mkdir -p '..dir)
    end
end

function utils.join_paths(path1, path2, ...)
    local path_sep = aloha.settings.os_name == 'Windows' and '\\' or '/'
    local joined = path1 .. path_sep .. path2
    for _,path in ipairs({...}) do
        joined = joined .. path_sep .. path
    end
    return joined
end

_G.aloha.mapping_addition = {}
-- Must be called before 
-- eg. Use in lua/aloha/plugins/config.lua for plugin mappings
-- @map_list: {{'x', ';', ':', {silent = false, nowait = true }}, ...},
function utils.add_maps(...)
    _G.aloha.mapping_addition = utils.merge(_G.aloha.mapping_addition, {...})
end

-- Must be called before 
-- eg. Use in lua/aloha/plugins/config.lua for plugin mappings
-- @map: {'x', ';', ':', {silent = false, nowait = true }},
function utils.add_map(...)
    table.insert(_G.aloha.mapping_addition, {...})
end

----------------------------------------------------------------------------------------
--                                \ Debug Functions /                                 --
----------------------------------------------------------------------------------------

function utils.var2str(var)
    if type(var) == 'string' then
        return '"' .. var .. '"'
    else
        return tostring(var)
    end
end

local indent = '    '
function utils.showtab(tab, level)
    level = level or 0
    if type(tab) ~= 'table' then
        print(string.rep(indent, level+1)..utils.var2str(tab))
    else
        for k,v in pairs(tab) do
            print(string.rep(indent, level)..k..' = {')
            utils.showtab(v, level + 1)
            print(string.rep(indent, level)..'}')
        end
    end
end

return utils
