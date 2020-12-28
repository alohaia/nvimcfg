----------------------------------------------------------------------------------------
--                            \ Config: mount fill init /                             --
----------------------------------------------------------------------------------------
_G.aloha = {}

function aloha:init()
    -- test mode
    self.test_mode = false
    require'test'

    --------------
    -- mounting --
    --------------
    require'core'

    -------------
    -- filling --
    -------------
    require'data'       -- mappings, options ...
    require'plugins'    -- just fill, actuall works done by core/plugin(aloha.plugin)

    --------------------
    -- initialization --
    --------------------
    -- base to initialization
    self.utils:init()
    -- test and debug functionalities
    self.test:init()
    -- base to config
    self.prepare:init()
    -- vim internal configs
    self.wim:init()
    -- add and config plugins
    self.plugin:init()

    -------------------
    -- user addition --
    -------------------
    require'mine'
    self.mine:init()

    return self
end

return _G.aloha
