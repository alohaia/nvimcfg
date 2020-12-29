----------------------------------------------------------------------------------------
--                            \ Config: mount fill init /                             --
----------------------------------------------------------------------------------------
_G.aloha = {}

function aloha:init()
    -- test mode
    self.test_mode = false
    require'aloha/test'

    --------------
    -- mounting --
    --------------
    require('aloha/core')
    -- treat as separate module, but at the same level of utils/wim/...
    require('aloha/plugin')

    -------------
    -- filling --
    -------------
    require('aloha/fill')       -- mappings, options, plugins ...

    --------------------
    -- initialization --
    --------------------
    -- global variables
    -- self.global:init()
    -- base to initialization
    -- self.utils:init()
    -- test and debug functionalities
    -- self.test:init()
    -- base to config
    self.prepare:init()
    -- vim internal configs
    self.wim:init()
	vim.cmd('source '..aloha.global.paths.config..'/lua/aloha/remain/remain.vim')
    -- add and config plugins
    self.plugin:init()

    -------------------
    -- user addition --
    -------------------
    require('aloha/mine'):init()

    return self
end

return _G.aloha
