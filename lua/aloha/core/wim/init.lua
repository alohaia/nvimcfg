----------------------------------------------------------------------------------------
--                                  \ Wrapped Vim /                                   --
----------------------------------------------------------------------------------------
_G.aloha.wim = {}
local wim = _G.aloha.wim

-- mount
require('aloha/core/wim/map')
require('aloha/core/wim/au')
require('aloha/core/wim/option')

function wim:init()
    self.map:init()
    self.au:init()
    self.option:init()
    return self
end

return _G.aloha.wim
