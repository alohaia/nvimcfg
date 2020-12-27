local settings = aloha.settings

aloha.plugins = {}
local plugins = aloha.plugins

function plugins:init()
    require('aloha.plugins.config')
    require('aloha.plugins.list'):init()
end

return plugins
