_G.aloha = {}

function aloha:init()
    -- set aloha.settings and aloha.utils
    require('aloha.settings')
    require('aloha.utils')

    require('aloha.plugins'):init()
    require('aloha.prepare'):init()
    require('aloha.options'):init()
    require('aloha.mappings'):init()
    -- vim global variables
    vim.g.python_host_prog  = '/usr/bin/python'
    vim.g.python3_host_prog = '/usr/bin/python3'
end

return aloha
