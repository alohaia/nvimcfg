local g = _G.vim.g

local _cfg_kitty_scrollback = {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
    event = { 'User KittyScrollbackLaunch' },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function()
      require('kitty-scrollback').setup()
    end,
}

local _cfg_hugowiki = {
    'alohaia/hugowiki.nvim',
    config = function()
        g.hugowiki_home = '/home/qihuan/homepage/'
        g.hugowiki_try_init_file = 1
        g.hugowiki_follow_after_create = 0
        g.hugowiki_use_imaps = 1
        g.hugowiki_disable_fold = 0
        g.markdown_fenced_languages = {
            'lua',  'c', 'cpp', 'r', 'javascript', 'python',
            'sh', 'bash', 'zsh', 'yaml', 'tex'
        }
        g.hugowiki_wrap = 0
        g.hugowiki_auto_save = 0
        g.hugowiki_auto_update_lastmod = 1
        g.hugowiki_lastmod_under_date = 1
        g.hugowiki_rmd_auto_knit = {
            enable = true,
            cwd = g.hugowiki_home,
            r_script = g.hugowiki_home .. 'utils/R/build_one.R',
        }
        g.hugowiki_spellcheck_ignore_upcase = 1
        g.hugowiki_snippy_integration = 1
    end
}


return {
    _cfg_kitty_scrollback,
    _cfg_hugowiki,
}
