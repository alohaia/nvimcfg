local g = vim.g
local setmap = vim.keymap.set

local _cfg_flash =  {
    'folke/flash.nvim',
    config = function ()
        require('flash').setup {
            modes = {
                search = { enabled = true },
                char = {
                    enabled = true,
                    keys = { "f", "F", "t", "T" },
                    char_actions = function(motion)
                        return {
                            ["<M-n>"] = "next",
                            ["<M-p>"] = "prev",
                        }
                    end,
                }
            },
            prompt = {
                enabled = true,
                prefix = { { "Flash.nvim: ", "FlashPromptIcon" } }
            }
        }

        setmap({'n', 'x', 'o'}, 's', function()
            require("flash").jump()
        end, {desc = "Flash: jump"})

        setmap({'n', 'x', 'o'}, 'S', function()
            require("flash").treesitter {
            label = {
                rainbow = {
                    enabled = true,
                    shade = 5,
                },
            }
        }
        end, {desc = "Flash: treesitter"})

        setmap({'n', 'x', 'o'}, '<M-s>', function()
            require("flash").remote()
        end, {desc = "Flash: remote"})

        setmap({'n', 'x', 'o'}, '<C-s>c', function()
            require("flash").jump({continue = true})
        end, {desc = "Flash: continue last searching"})

        setmap({'n', 'x', 'o'}, '<C-s>d', function()
            require("flash").jump({
                matcher = function(win)
                    ---@param diag Diagnostic
                    return vim.tbl_map(function(diag)
                        return {
                            pos = { diag.lnum + 1, diag.col },
                            end_pos = { diag.end_lnum + 1, diag.end_col - 1 },
                        }
                    end, vim.diagnostic.get(vim.api.nvim_win_get_buf(win)))
                end,
                action = function(match, state)
                    vim.api.nvim_win_call(match.win, function()
                    vim.api.nvim_win_set_cursor(match.win, match.pos)
                    vim.diagnostic.open_float()
                    end)
                    state:restore()
                end,
            })
        end, {desc = "Flash: jump to LSP diagnostics"})
    end
}

local _cfg_hugowiki = {
    'alohaia/hugowiki.nvim',
    config = function()
        g.hugowiki_home = '~/Documents/blog/'
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

local _cfg_accelerated_jk = {
    'rainbowhxch/accelerated-jk.nvim',
    config = function()
        setmap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
        setmap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
    end
}

local _cfg_comment = {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()

        local cmt = require('Comment.api')
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.keymap.set({'n', 'x'}, '<C-/>', function()
            if vim.fn.mode() == "\22" then
                vim.api.nvim_feedkeys(esc, 'nx', false)
                cmt.toggle.blockwise("v")
            elseif vim.fn.mode() == "V" or vim.fn.mode() == "v" then
                vim.api.nvim_feedkeys(esc, 'nx', false)
                cmt.toggle.linewise("V")
            else
                cmt.toggle.linewise()
            end
        end, { noremap = true })
    end
}

local _cfg_multicursor = {
    'jake-stewart/multicursor.nvim',
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<S-Up>", function() mc.lineAddCursor(-1) end, {
            desc = "multicursor.nvim: previous line",
        })
        set({"n", "x"}, "<S-Down>", function() mc.lineAddCursor(1) end, {
            desc = "multicursor.nvim: next line",
        })
        set({"n", "x"}, "<M-Up>", function() mc.lineSkipCursor(-1) end, {
            desc = "multicursor.nvim: skip previous line",
        })
        set({"n", "x"}, "<M-Down>", function() mc.lineSkipCursor(1) end, {
            desc = "multicursor.nvim: skip next line",
        })

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<C-n>", function() mc.matchAddCursor(1) end, {
            desc = "multicursor.nvim: next match",
        })
        set({"n", "x"}, "<C-p>", function() mc.matchAddCursor(-1) end, {
            desc = "multicursor.nvim: previous match",
        })
        set({"n", "x"}, "<C-M-n>", function() mc.matchSkipCursor(1) end, {
            desc = "multicursor.nvim: skip next match",
        })
        set({"n", "x"}, "<C-M-p>", function() mc.matchSkipCursor(-1) end, {
            desc = "multicursor.nvim: skip previous match",
        })

        -- Add and remove cursors with control + left click.
        set("n", "<C-LeftMouse>", mc.handleMouse, {
            desc = "multicursor.nvim: handleMouse"
        })
        set("n", "<C-LeftDrag>", mc.handleMouseDrag, {
            desc = "multicursor.nvim: handleMouseDrag"
        })
        set("n", "<C-LeftRelease>", mc.handleMouseRelease, {
            desc = "multicursor.nvim: handleMouseRelease"
        })

        -- Disable and enable cursors.
        set({"n", "x"}, "<C-q>", mc.toggleCursor, {
            desc = "multicursor.nvim: toggle cursors"
        })

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- Select a different cursor as the main one.
            layerSet({"n", "x"}, "<Left>", mc.prevCursor, {
            desc = "multicursor.nvim: goto previous cursor"
        })
            layerSet({"n", "x"}, "<Right>", mc.nextCursor, {
            desc = "multicursor.nvim: goto next cursor"
        })

            -- Delete the main cursor.
            layerSet({"n", "x"}, "<C-x>", mc.deleteCursor, {
            desc = "multicursor.nvim: delete current main cursor_row"
        })

            -- Enable and clear cursors using escape.
            layerSet("n", "<Esc>",
                function()
                    if not mc.cursorsEnabled() then
                        mc.enableCursors()
                    else
                        mc.clearCursors()
                    end
                end,
                { desc = "multicursor.nvim: enable/clear cursors" }
            )
        end)

        -- Customize how cursors look.
        local hl = vim.api.nvim_set_hl
        hl(0, "MultiCursorCursor", { reverse = true })
        hl(0, "MultiCursorVisual", { link = "Visual" })
        hl(0, "MultiCursorSign", { link = "SignColumn"})
        hl(0, "MultiCursorMatchPreview", { link = "Search" })
        hl(0, "MultiCursorDisabledCursor", { reverse = true })
        hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
        hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
}

local _cfg_fcitx = {
    'alohaia/fcitx.nvim',
    ft = 'rmd,markdown,text,tex',
    config = function ()
        require 'fcitx' {
            enable = {
                select = "insert",
            },
        }
    end
}

return {
    _cfg_flash,
    _cfg_hugowiki,
    _cfg_accelerated_jk,
    _cfg_comment,
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'cohama/lexima.vim', -- auto pairs
    _cfg_fcitx,
    { 'fladson/vim-kitty', ft='kitty' },
}
