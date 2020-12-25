local settings = aloha.settings
local mkdir = aloha.utils.mkdir

aloha.prepare = {}
local prepare = aloha.prepare

-- ensure cache dirs exists
function prepare:init()
    for _,dir in pairs(settings.cache_dirs) do
        mkdir(dir)
    end
end

return prepare
