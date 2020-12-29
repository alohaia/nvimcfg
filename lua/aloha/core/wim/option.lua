----------------------------------------------------------------------------------------
--                                    \ Options /                                     --
----------------------------------------------------------------------------------------
_G.aloha.wim.option = {}
local option = _G.aloha.wim.option

function option:init()
    for o,v in pairs(self.g_options) do
        vim.o[o] = v
    end
    for o,v in pairs(self.w_options) do
        vim.wo[o] = v
        vim.o[o] = v
    end
    for o,v in pairs(self.b_options) do
        vim.bo[o] = v
        vim.o[o] = v
    end
    return self
end

return _G.aloha.option
