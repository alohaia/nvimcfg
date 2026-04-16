local setmap = vim.keymap.set
local api = vim.api

local augid_load_optional_plugins = api.nvim_create_augroup('load.optional.plugins', { clear = true })

local gh = function(repo)
    return "https://github.com/" .. repo
end


---------------------------------------
--- Condition and config of plugins ---
---------------------------------------
local spc_onedarkpro = { src = gh('olimorris/onedarkpro.nvim'), data = {
    config = function()
        require('onedarkpro').setup({
            colors = {},
            highlights = {
                Conceal = { link = 'Normal' },
                -- Keyword = { gui = 'italic' }
            },
            styles = {},
            filetypes = {},
            plugins = {
                all = false,
                nvim_lsp = true,
                polygot = false,
                treesitter = true
            },
            options = {
                underline = true,
                cursorline = true,
                transparency = true,
                lualine_transparency = true,
                terminal_colors = true,
                window_unfocussed_color = false,
            }
        })
        vim.cmd.colorscheme('onedark')
    end
}}

local spc_alpha = { src = gh('goolord/alpha-nvim'), data = {
    config = require('config.plugins.setup_ui').alpha
}}
local spc_lualine = { src = gh('nvim-lualine/lualine.nvim'), data = {
    config = require('config.plugins.setup_ui').lualine
}}
local spc_bufferline = { src = gh('akinsho/bufferline.nvim'), data = {
    config = require('config.plugins.setup_ui').bufferline
}}

local spc_indent_blankline = { src = gh('lukas-reineke/indent-blankline.nvim'), data = {
    config = function()
        require'ibl'.setup {
            exclude = {
                filetypes = {
                    "startify", "dashboard", "dotooagenda", "log", "fugitive",
                    "gitcommit", "packer", "vimwiki", "markdown", "json", "txt",
                    "vista", "help", "todoist", "NvimTree", "peekaboo", "git",
                    "TelescopePrompt", "undotree", "flutterToolsOutline", "lspinfo",
                    "checkhealth",  "man",
                    "" -- for all buffers without a file type
                },
                buftypes = {"terminal", "nofile", "quickfix", "prompt"},
            },
            scope = {
                enabled = true,
                highlight = { "Function", "Label" },
            }
        }
    end
}}

local spc_fidget = { src = gh('j-hui/fidget.nvim'), data = {
    config = function()
        require("fidget").setup {
            notification = {
                override_vim_notify = true,
                view = {
                    reflow = true
                },
                window = {
                    normal_hl = "Comment",
                    winblend = 0,
                    avoid = { "NvimTree", "Outline", "aerial-nav", "aerial" },
                }
            },
        }
    end
}}

local spc_colorizer = { src = gh('norcalli/nvim-colorizer.lua'), data = {
    config = function()
        require 'colorizer'.setup {
            '*',
            css = { rgb_fn = true, },
            html = { names = false, },
            -- '!vim' -- Exclude vim from highlighting.
        }
    end
}}

local spc_illuminate = { src = gh('RRethy/vim-illuminate'), data = {
    config = function()
        require('illuminate').configure({
            providers = {'lsp', 'treesitter', 'regex'},
            delay = 100,
            filetypes_denylist = {'dashboard', 'NvimTree', 'markdown', 'rmd', 'tex', ''},
            under_cursor = true,
            modes_denylist = {},
            large_file_cutoff = 5000,
            large_file_overrides = nil, -- disabled for large files.
            large_file_config = {},
        })
        setmap('n', '<M-n>', '<Cmd>lua require"illuminate".next_reference{wrap=true}<CR>', {noremap=true})
        setmap('n', '<M-p>', '<Cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<CR>', {noremap=true})
        setmap('n', '<M-i>', '<Cmd>lua require("illuminate").textobj_select()<CR>', {noremap=true})
        api.nvim_set_hl(0, "IlluminatedWordText", {italic=true, bg="#53565d"})
        api.nvim_set_hl(0, "IlluminatedWordRead", {link="IlluminatedWordText"})
        api.nvim_set_hl(0, "IlluminatedWordWrite", {link="IlluminatedWordText"})
    end
}}

local spc_rainbow_delimiters = { src = gh('HiPhish/rainbow-delimiters.nvim'), data = {
    config = function()
        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = 'rainbow-delimiters.strategy.global',
                vim = 'rainbow-delimiters.strategy.local',
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            priority = {
                [''] = 110,
                lua = 210,
            },
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow',
                'RainbowDelimiterBlue',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        }
    end
}}

local spc_ufo = { src = gh('kevinhwang91/nvim-ufo'), data = {
    config = function()
        -- vim.o.foldcolumn = '1' -- '0' is not bad
        -- vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        -- vim.o.foldlevelstart = 99
        -- vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

        local ufo_vt_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d Lines ...'):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, {chunkText, hlGroup})
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, {suffix, 'UfoFoldedEllipsis'}) -- highlight group
            return newVirtText
        end

        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return {'treesitter', 'indent'}
            end,
            fold_virt_text_handler = ufo_vt_handler,
        })

        vim.api.nvim_set_hl(0, "Folded", { bg = "#006040" })
    end
}}

local spc_lspconfig = { src = gh('neovim/nvim-lspconfig'), data = {
    config = require('config.plugins.setup_lsp').lspconfig
}}
local spc_blink_cmp = { src = gh('saghen/blink.cmp'), version = 'v1', data = {
    config = require('config.plugins.setup_lsp').blink_cmp
}}
local spc_tiny_inline_diagnostic = { src = gh('rachartier/tiny-inline-diagnostic.nvim'), data = {
    config = require('config.plugins.setup_lsp').tiny_inline_diagnostic
}}
local spc_trouble = { src = gh('folke/trouble.nvim'), data = {
    config = require('config.plugins.setup_lsp').trouble
}}

local spc_r = { src = gh('R-nvim/r.nvim'), data = {
    config = function()
        require("r").setup({
            pipe_version = "native",
            hook = {
                on_filetype = function()
                vim.api.nvim_buf_set_keymap(0, "i", "<M-->", "<Plug>RInsertAssign", { noremap = true })
                vim.api.nvim_buf_set_keymap(0, "i", "<M-.>", "<Plug>RInsertPipe", { noremap = true })
                if vim.bo.filetype == "rnoweb" then
                    vim.api.nvim_buf_set_keymap(0, "i", "<", "<Plug>RnwInsertChunk", { noremap = true })
                elseif vim.bo.filetype == "rmd" or vim.bo.filetype == "quarto" then
                    vim.api.nvim_buf_set_keymap(0, "i", "`", "<Plug>RmdInsertChunk", { noremap = true })
                end
                end,
                after_R_start = function()
                    vim.api.nvim_buf_set_keymap(0, "n", "<M-Enter>", "<Plug>RDSendLine", {noremap = true})
                    vim.api.nvim_buf_set_keymap(0, "v", "<M-Enter>", "<Plug>RSendSelection", {noremap = true})
                end
            },
            -- register_treesitter = false
        })
    end
}}

local spc_lint = { src = gh('mfussenegger/nvim-lint'), data = {
    config = function()
        require('lint').linters_by_ft = {
            markdown = {'mado'},
            bash = {'bash'},
            zsh = {'zsh'},
            cpp = {'clang-tidy'},
            lua = {'luacheck'},
            python = {'ruff'}
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}}

local spc_dap = { src = gh('mfussenegger/nvim-dap'), data = {
    config = function()
        require('dap').adapters.debugpy = {
            type = 'executable',
            command = 'python',
            args = { '-m', 'debugpy.adapter' },
        }
    end
}}

local spc_flash = { src = gh('folke/flash.nvim'), data = {
    config = function()
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
}}

local spc_accelerated_jk = { src = gh('rainbowhxch/accelerated-jk.nvim'), data = {
    config = function()
        setmap('n', 'j', '<Plug>(accelerated_jk_gj)', {})
        setmap('n', 'k', '<Plug>(accelerated_jk_gk)', {})
    end
}}

local spc_comment = { src = gh('numToStr/Comment.nvim'), data = {
    config = function()
        local cmt = require('Comment.api')
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        setmap({'n', 'x'}, '<C-/>', function()
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
}}

local spc_multicursor = { src = gh('jake-stewart/multicursor.nvim'), data = {
    config = function()
        local mc = require("multicursor-nvim")
        mc.setup()

        -- Add or skip cursor above/below the main cursor.
        setmap({"n", "x"}, "<S-Up>", function() mc.lineAddCursor(-1) end, {
            desc = "multicursor.nvim: previous line",
        })
        setmap({"n", "x"}, "<S-Down>", function() mc.lineAddCursor(1) end, {
            desc = "multicursor.nvim: next line",
        })
        setmap({"n", "x"}, "<M-Up>", function() mc.lineSkipCursor(-1) end, {
            desc = "multicursor.nvim: skip previous line",
        })
        setmap({"n", "x"}, "<M-Down>", function() mc.lineSkipCursor(1) end, {
            desc = "multicursor.nvim: skip next line",
        })

        -- Add or skip adding a new cursor by matching word/selection
        setmap({"n", "x"}, "<C-n>", function() mc.matchAddCursor(1) end, {
            desc = "multicursor.nvim: next match",
        })
        setmap({"n", "x"}, "<C-p>", function() mc.matchAddCursor(-1) end, {
            desc = "multicursor.nvim: previous match",
        })
        setmap({"n", "x"}, "<C-M-n>", function() mc.matchSkipCursor(1) end, {
            desc = "multicursor.nvim: skip next match",
        })
        setmap({"n", "x"}, "<C-M-p>", function() mc.matchSkipCursor(-1) end, {
            desc = "multicursor.nvim: skip previous match",
        })

        -- Add and remove cursors with control + left click.
        setmap("n", "<C-LeftMouse>", mc.handleMouse, {
            desc = "multicursor.nvim: handleMouse"
        })
        setmap("n", "<C-LeftDrag>", mc.handleMouseDrag, {
            desc = "multicursor.nvim: handleMouseDrag"
        })
        setmap("n", "<C-LeftRelease>", mc.handleMouseRelease, {
            desc = "multicursor.nvim: handleMouseRelease"
        })

        -- Disable and enable cursors.
        setmap({"n", "x"}, "<C-q>", mc.toggleCursor, {
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
}}

local spc_fcitx = { src = gh('alohaia/fcitx.nvim'), data = {
    ft = 'rmd,markdown,tex,latex',
    config = function()
        require 'fcitx' {
            enable = {
                select = "insert",
            },
        }
    end
}}

local spc_yoink = { src = gh('svermeulen/vim-yoink'), data = {
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
}}

local spc_subversive = { src = gh('svermeulen/vim-subversive'), data = {
    config = function()
        vim.g.subversiveCurrentTextRegister = 1
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
}}


local spc_kitty_scrollback = { src = gh('mikesmithgh/kitty-scrollback.nvim'), data = {
    -- TODO
    -- cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
    -- event = { 'User KittyScrollbackLaunch' },
    config = function()
        require('kitty-scrollback').setup()
    end
}}

local spc_hugowiki = { src = gh('alohaia/hugowiki.nvim'), data = {
    config = function()
        local g = vim.g
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
}}

local spc_gitsigns = { src = gh('lewis6991/gitsigns.nvim'), data = {
    config = function()
        require('gitsigns').setup {
            numhl              = true,
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol',
                delay = 200,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
            }
        }
    end
}}

local spc_treesitter = { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main', data = {
    config = function()
        -- required by R.nvim
        -- r, markdown, markdown_inline, rnoweb, yaml, latex, and csv.
        local ts_langs = {
            'vim', 'lua', 'c', 'cpp', 'cmake', 'bash', 'rust',
            'python', 'r', 'rnoweb', 'csv',
            'yaml', 'toml', 'json',
            'markdown', 'markdown_inline', 'latex', 'mermaid',
            'html', 'javascript', 'css',
            'scheme', 'racket',
        }
        require'nvim-treesitter'.install(ts_langs)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = ts_langs,
            callback = function ()
                vim.treesitter.start()
                vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[0][0].foldmethod = 'expr'
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end

        })
    end
}}

local spc_log_highlight = { src = gh('fei6409/log-highlight.nvim'), data = {
    config = function()
        require('log-highlight').setup {
            ---@type string|string[]: File extensions. Default: 'log'
            extension = 'log',

            ---@type string|string[]: File names or full file paths. Default: {}
            filename = {
                'syslog',
            },

            ---@type string|string[]: File name/path glob patterns. Default: {}
            pattern = {
                -- Use `%` to escape special characters and match them literally.
                '%/var%/log%/.*',
                'console%-ramoops.*',
                'log.*%.txt',
                'logcat.*',
            },

            ---@type table<string, string|string[]>: Custom keywords to highlight.
            ---This allows you to define custom keywords to be highlighted based on
            ---the group.
            ---
            ---The following highlight groups are supported:
            ---    'error', 'warning', 'info', 'debug' and 'pass'.
            ---
            ---The value for each group can be a string or a list of strings.
            ---All groups are empty by default. Keywords are case-sensitive.
            keyword = {
                error = 'ERROR_MSG',
                warning = { 'WARN_X', 'WARN_Y' },
                info = { 'INFORMATION' },
                debug = {},
                pass = {},
            },
        }
    end
}}

local spc_fzf_lua = { src = gh('ibhagwan/fzf-lua'), data = {
    config = function()
        setmap('n', ',r', '<Cmd>FzfLua resume<CR>', {
            noremap = true, desc = "FzfLua: [R]esume last searching"
        })
        setmap('n', ',f', '<Cmd>FzfLua files<CR>', {
            noremap = true, desc = "FzfLua: search [F]iles"
        })
        setmap('n', ',b', '<Cmd>FzfLua buffers<CR>', {
            noremap = true, desc = "FzfLua: search [B]uffers"
        })
        setmap('n', ',j', '<Cmd>FzfLua lgrep_curbuf<CR>', {
            noremap = true, desc = "FzfLua: fuzzy find and [J]ump in current buffer"
        })
        setmap('n', ',g', '<Cmd>FzfLua live_grep<CR>', {
            noremap = true, desc = "FzfLua: live [G]rep for current project"
        })
        setmap('n', ',h', '<Cmd>FzfLua command_history<CR>', {
            noremap = true, desc = "FzfLua: search Vim command [H]istory"
        })
        setmap('n', '<F1>', '<Cmd>FzfLua help_tags<CR>', {
            noremap = true, desc = "FzfLua: search Vim Help tags"
        })
        setmap('n', ',sb', '<Cmd>FzfLua lsp_document_symbols<CR>', {
            noremap = true, desc = "FzfLua: search document [S]ymbols in current [B]uffer"
        })
        setmap('n', ',sp', '<Cmd>FzfLua lsp_workspace_symbols<CR>', {
            noremap = true, desc = "FzfLua: search workspace [S]ymbols in current [P]roject"
        })
        setmap('n', ',db', '<Cmd>FzfLua lsp_document_diagnostics<CR>', {
            noremap = true, desc = "FzfLua: search LSP document [D]iagnostics in current [B]uffer"
        })
        setmap('n', ',dp', '<Cmd>FzfLua lsp_workspace_diagnostics<CR>', {
            noremap = true, desc = "FzfLua: search LSP workspace [D]iagnostics in current [P]roject"
        })
    end
}}

local spc_vimtex = { src = gh 'lervag/vimtex', data = {
    config = function()
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
}}

local spc_auto_session = { src = gh 'rmagatti/auto-session', data = {
    config = function()
        require('auto-session').setup {
            auto_restore = false,
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            -- log_level = 'debug',
        }
    end
}}

local spc_which_key = { src = gh 'folke/which-key.nvim', data = {
    config = function()
        vim.keymap.set("n", "<leader>?", function()
            require("which-key").show({ global = false })
        end, { desc = "Buffer Local Keymaps (which-key)" })
    end
}}

local spc_aerial = { src = gh 'stevearc/aerial.nvim', data = {
    config = function()
        require('aerial').setup {
            backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },
            filter_kind = {
                "Class",
                "Constructor",
                "Enum",
                "Function",
                "Interface",
                "Module",
                "Method",
                "Struct",
            },
        }
    end
}}

local spc_toggleterm = { src = gh 'akinsho/toggleterm.nvim', data = {
    config = function()
        require("toggleterm").setup {
            size = 20,
            open_mapping = [[<C-\>]],
            -- clear_env = true,
            autochdir = true,
            on_create = function (term)
                local conda_env = vim.env.CONDA_DEFAULT_ENV
                if conda_env and conda_env ~= "" then
                    term:send(string.format("mamba activate %s", conda_env))
                end
            end,
            winbar = {
                enabled = true,
                name_formatter = function(term)
                    return term.name
                end
            },
        }

        local Terminal  = require('toggleterm.terminal').Terminal
        local lazygit = nil
        vim.api.nvim_create_user_command('Lazygit', function(args)
            if lazygit == nil or args.bang then
                lazygit = Terminal:new({
                    cmd = table.concat({ 'lazygit', args.args ~= '' and args.args or nil }),
                    hidden = true,
                    display_name = "Lazygit",
                    direction = 'float',
                    float_opts = {
                        border = 'none'
                    },
                })
            end

            lazygit:toggle()
        end, {
            desc = "Open lazygit with toggleterm.nvim",
            nargs = "*",
            bang = true, -- add ! to restart lazygit
        })
        vim.api.nvim_set_keymap("n", "<leader>g", "<Cmd>Lazygit<CR>", {
            noremap = true, silent = true, desc = "Open lazygit with toggleterm.nvim"
        })
    end
}}

local spc_tree = { src = gh 'nvim-tree/nvim-tree.lua', data = {
    config = require('config.plugins.setup_tree')
}}

------------------------------
--- Plugins specifications ---
------------------------------
-- specifications of enabled plugins, **exlucding `data` field**
local plugin_spcs = {
    -- dependencies
    gh('nvim-tree/nvim-web-devicons'),
    gh('kevinhwang91/promise-async'), -- required by rainbow-delimiters.nvim
    gh('nvim-lua/plenary.nvim'),

    -- appearance
    spc_onedarkpro,
    spc_alpha,
    spc_lualine,
    spc_bufferline,
    spc_indent_blankline,
    spc_fidget,
    spc_colorizer,
    spc_illuminate,
    spc_rainbow_delimiters,
    spc_ufo,

    -- devtools
    spc_blink_cmp,
    spc_lspconfig,
    spc_tiny_inline_diagnostic,
    spc_trouble,
    spc_r,
    spc_lint,
    spc_dap,
    gh('gpanders/nvim-parinfer'),  -- for SICP

    -- workspace
    spc_auto_session,

    -- edit text
    spc_flash,
    spc_accelerated_jk,
    spc_comment,
    spc_multicursor,
    spc_fcitx,
    spc_yoink,
    spc_subversive,
    gh('tpope/vim-surround'),
    gh('tpope/vim-repeat'),
    gh('cohama/lexima.vim'), -- auto pairs
    gh('rafamadriz/friendly-snippets'),

    -- external
    spc_kitty_scrollback,
    spc_hugowiki,

    -- git
    spc_gitsigns,
    gh('tpope/vim-fugitive'),

    -- highlight
    spc_treesitter,
    spc_log_highlight,
    { src = gh('nvim-treesitter/nvim-treesitter-textobjects'), version = 'main'},
    { src = gh('nvim-treesitter/nvim-treesitter-context'), data = {
        config = function()
            require'treesitter-context'.setup {
                enable = false,
                multiwindow = true
            }
            vim.keymap.set("n", "<Leader>tc", function()
                require"treesitter-context".toggle()
            end, { desc = "Toggle treesitter-context" })
        end
    }},
    { src = gh 'fladson/vim-kitty', data = { ft='kitty' } },

    -- navigation
    spc_fzf_lua,

    -- widgets
    spc_which_key,
    spc_aerial,
    spc_toggleterm,
    spc_tree,

    -- LaTeX
    spc_vimtex,
}


--------------------
--- Load plugins ---
--------------------
local _load_plugin = function(plug_data)
    vim.cmd.packadd(plug_data.spec.name)
    if (plug_data.spec.data or {}).config then
        plug_data.spec.data.config()
    end
end
local selective_load = function(plug_data)
    if (plug_data.spec.data or {}).ft then
        vim.api.nvim_create_autocmd('FileType', {
            group = augid_load_optional_plugins,
            pattern = plug_data.spec.data.ft,
            callback = function()
                _load_plugin(plug_data)
            end
        })
    else
        _load_plugin(plug_data)
    end
end

vim.pack.add(plugin_spcs, { load = selective_load })

---------------------
-- builtin plugins --
---------------------
vim.cmd.packadd("nvim.difftool")
vim.cmd.packadd("nvim.undotree")
-- vim.g.editorconfig = false

-- UI2 (experimental): no more press Enter, see `:h ui2`
-- See also `:h g<`
require("vim._core.ui2").enable {
    enable = true,
    msg = { -- Options related to the message module.
        ---@type 'cmd'|'msg' Default message target, either in the
        ---cmdline or in a separate ephemeral message window.
        ---@type string|table<string, 'cmd'|'msg'|'pager'> Default message target
        ---or table mapping |ui-messages| kinds and triggers to a target.
        targets = "cmd",
        cmd = { -- Options related to messages in the cmdline window.
            height = 0.5, -- Maximum height while expanded for messages beyond 'cmdheight'.
        },
        dialog = { -- Options related to dialog window.
            height = 0.5, -- Maximum height.
        },
        msg = { -- Options related to msg window.
            height = 0.5, -- Maximum height.
            timeout = 4000, -- Time a message is visible in the message window.
        },
        pager = { -- Options related to message window.
            height = 0.5, -- Maximum height.
        },
    },
}


-------------------------
--- vim.pack mappings ---
-------------------------
vim.api.nvim_create_user_command("PackUpdate", function(args)
    vim.pack.update(nil, { force = args.bang })
end, {
    desc = "Update packages",
    force = true,
    bang = true,
})
