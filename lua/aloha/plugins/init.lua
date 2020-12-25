local settings = aloha.settings

aloha.plugins = {}
local plugins = aloha.plugins

function plugins:init()
    require('aloha.plugins.list'):init()
    require('aloha.plugins.config')
end

return plugins
