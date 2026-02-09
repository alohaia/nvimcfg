local g = vim.g
local setmap = vim.keymap.set

local _cfg_flash =  {
    'folke/flash.nvim',
    config = function ()
        require('flash').setup {
            modes = {
                search = { enabled = false },
                char = {
                    enabled = true,
                    keys = { 'f', 'F', 't', 'T' },
                }
            },
            prompt = {
                enabled = true,
                prefix = { { 'Flash.nvim: ', 'FlashPromptIcon' } }
            }
        }

        setmap({'n', 'x', 'o'}, '<M-s>', function()
            require('flash').jump()
        end, {desc = 'Flash: jump'})
        setmap({'n', 'x', 'o'}, '<C-s>j', function()
            require('flash').jump()
        end, {desc = 'Flash: jump'})

        setmap({'n', 'x', 'o'}, '<C-s>t', function()
            require('flash').treesitter {
            label = {
                rainbow = {
                    enabled = true,
                    shade = 5,
                },
            }
        }
        end, {desc = 'Flash: treesitter'})

        setmap({'n', 'x', 'o'}, '<C-f>', function()
            require('flash').remote()
        end, {desc = 'Flash: remote'})

        setmap({'n', 'x', 'o'}, '<C-b>', function()
            require('flash').jump({continue = true})
        end, {desc = 'Flash: continue last searching'})

        setmap({'n', 'x', 'o'}, '<C-s>d', function()
            require('flash').jump({
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
        end, {desc = 'Flash: jump to LSP diagnostics'})
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

local _cfg_yoink = {
    'svermeulen/vim-yoink',
    config = function()
        setmap('n', 'p', '<plug>(YoinkPaste_p)', {noremap=false})
        setmap('n', 'P', '<plug>(YoinkPaste_P)', {noremap=false})
        setmap('n', 'gp', '<plug>(YoinkPaste_gp)', {noremap=false})
        setmap('n', 'gP', '<plug>(YoinkPaste_gP)', {noremap=false})
        setmap('n', '[s', '<plug>(YoinkPostPasteSwapBack)', {noremap=false})
        setmap('n', ']s', '<plug>(YoinkPostPasteSwapForward)', {noremap=false})
        setmap('n', '[y', '<plug>(YoinkRotateBack)', {noremap=false})
        setmap('n', ']y', '<plug>(YoinkRotateForward)', {noremap=false})
        setmap('n', 'y', '<plug>(YoinkYankPreserveCursorPosition)', {noremap=false})
        setmap('x', 'y', '<plug>(YoinkYankPreserveCursorPosition)', {noremap=false})
    end
}

local _cfg_subversive = {
    'svermeulen/vim-subversive',
    config = function()
        g.subversiveCurrentTextRegister = 1
        setmap('n', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
        setmap('x', 's',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
        setmap('x', 'p',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
        setmap('x', 'P',                  '<plug>(SubversiveSubstitute)',                 { noremap = false })
        setmap('n', 'ss',                 '<plug>(SubversiveSubstituteLine)',             { noremap = false })
        setmap('n', 'S',                  '<plug>(SubversiveSubstituteToEndOfLine)',      { noremap = false })
        setmap('n', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false })
        setmap('x', '<leader>s',          '<plug>(SubversiveSubstituteRange)',            { noremap = false })
        setmap('n', '<leader>ss',         '<plug>(SubversiveSubstituteWordRange)',        { noremap = false })
        setmap('n', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false })
        setmap('x', '<leader>cr',         '<plug>(SubversiveSubstituteRangeConfirm)',     { noremap = false })
        setmap('n', '<leader>crr',        '<plug>(SubversiveSubstituteWordRangeConfirm)', { noremap = false })
        setmap('n', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false })
        setmap('x', '<leader><leader>s',  '<plug>(SubversiveSubvertRange)',               { noremap = false })
        setmap('n', '<leader><leader>ss', '<plug>(SubversiveSubvertWordRange)',           { noremap = false })
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
    _cfg_multicursor,
    _cfg_fcitx,
    _cfg_yoink,
    _cfg_subversive,
}
