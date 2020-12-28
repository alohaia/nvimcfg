----------------------------------------------------------------------------------------
--                        \ Preparations for Initialization /                         --
----------------------------------------------------------------------------------------
_G.aloha = {}
local tree = _G.aloha.tree

function env:init()
    -- mounting
    self.utils   = require('aloha/env/utils')
    self.wim     = require('aloha/env/wim')
    self.globals = require('aloha/env/globals')
    self.prepare = reauire('aloha/env/prepare')
    return self
end

return _G.aloha.tree
