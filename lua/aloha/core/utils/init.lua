local aloha = _G.aloha
aloha.utils = {}
local utils = aloha.utils

function utils:init()
    self.global = require('aloha/env/utils/global')
    self.tool = require('aloha/env/utils/tool')
    return self
end

return _G.aloha.utils
