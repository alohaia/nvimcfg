local _cfg_vimtex = {
    "lervag/vimtex",
    lazy = false,
    init = function ()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_delim_toggle_mod_list = {
            {'\\left', '\\right'},
            {'\\big', '\\big'},
        }
        vim.g.vimtex_syntax_conceal_disable = false
        vim.g.vimtex_syntax_conceal = {
          -- accents = 1,
          -- ligatures = 1,
          -- cites = 1,
          -- fancy = 1,
          -- texTabularChar = 1,
          -- spacing = 1,
          -- greek = 1,
          math_bounds = 0,
          -- math_delimiters = 1,
          math_delimiters = 0,
          -- math_fracs = 1,
          -- math_super_sub = 1,
          -- math_symbols = 1,
          sections = 1,
          -- styles = 1,
        }

        vim.g.vimtex_toc_config = {
            mode = 1,
            fold_enable = 1,
            resize = 1,
        }

        vim.g.vimtex_view_automatic = 0
        local vimtex_group = vim.api.nvim_create_augroup("VimtexSync", { clear = true })
        vim.api.nvim_create_autocmd("User", {
            pattern = "VimtexEventCompileSuccess",
            group = vimtex_group,
            command = "VimtexView",
        })
    end
}


return {
    _cfg_vimtex,
}
