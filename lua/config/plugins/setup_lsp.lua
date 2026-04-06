local setmap = vim.keymap.set

local servers = {
    lua_ls = {
        on_init = function(client)
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                if
                    path ~= vim.fn.stdpath('config')
                        and (vim.uv.fs_stat(path .. '/.luarc.json')
                        or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                then
                    return
                end
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = {
                    version = 'LuaJIT',
                    -- Tell the language server how to find Lua modules same way as Neovim
                    -- (see `:h lua-module-load`)
                    path = {
                        'lua/?.lua',
                        'lua/?/init.lua',
                    },
                },
                -- Make the server aware of Neovim runtime files
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                    -- library = vim.api.nvim_get_runtime_file('', true)
                }
            })
        end,
        settings = {
            Lua = {}
        }
    },
    vimls = {},
    clangd = {
        -- https://clangd.llvm.org/config#files
        -- specific standard in ~/.config/clangd/config.yaml
        -- or project-specific <project-root>/.clangd
        --
        -- CompileFlags:
        --   Add: [-std=c++23]
        --
        capabilities = {
            offsetEncoding = { "utf-8", "utf-16" },
            textDocument = {
                completion = {
                    editsNearCursor = true
                }
            }
        },
        on_attach = function (_, bufnr)
            vim.api.nvim_buf_set_keymap(
                bufnr, 'n', '<C-s><C-h>',
                '<Cmd>ClangdSwitchSourceHeader<cr>', {noremap=true}
            )
        end,
        cmd = {
            "clangd",
            "--background-index",
            "--suggest-missing-includes",
            "--clang-tidy",
            "--header-insertion=iwyu",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" }
    },
    pyright = {
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true
                }
            }
        }
    },
    racket_langserver = {}, -- For SICP
    -- JavaScript / Typescript & HTML & CSS
    -- paru -S extra/vscode-css-languageserver extra/vscode-html-languageserver extra/typescript-language-server
    ts_ls = {},
    html = {},
    cssls = {},
    -- Misc.
    jsonls = {},
}

local lspconfig_setup =  function()
    for lang, cfg in pairs(servers) do
        cfg.capabilities = require('blink.cmp').get_lsp_capabilities(cfg.capabilities)
        vim.lsp.config(lang, cfg)
        vim.lsp.enable(lang)
    end

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('user-lsp-config', { clear = true }),
        callback = function(event)
            -- https://github.com/hendrikmi/neovim-kickstart-config/blob/main/lua/plugins/lsp.lua
            local map = function(keys, func, desc, mode)
                mode = mode or 'n'
                setmap(
                    mode, keys, func,
                    { buffer = event.buf, desc = 'LSP: ' .. desc }
                )
            end

            local fzf = require("fzf-lua")

            map('gd', fzf.lsp_definitions, '[G]oto [D]efinition')
            map('gr', fzf.lsp_references, '[G]oto [R]eferences')
            map('gI', fzf.lsp_implementations, '[G]oto [I]mplementation')
            map('gt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
            map('<leader>ca', vim.lsp.buf.code_action,
                '[C]ode [A]ction', { 'n', 'x' })
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            map('<M-i>', vim.lsp.buf.hover, 'Show Hover [I]nformation')

            map("]d", function () vim.diagnostic.jump({count = 1}) end,
                "Next Diagnostic")
            map("[d", function () vim.diagnostic.jump({count = -1}) end,
                "previous Diagnostic")
            map("]e",
                function ()
                    vim.diagnostic.jump({
                        count = 1,
                        severity = vim.diagnostic.severity.ERROR
                    })
                end,
                "Next Error")
            map("[e", function ()
                    vim.diagnostic.jump({
                        count = -1,
                        severity = vim.diagnostic.severity.ERROR
                    })
                end,
                "Next Error")

            -- toggle inlay hints
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
            then
                map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(
                            not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
                        )
                    end, '[T]oggle Inlay [H]ints')
            end
        end,
    })
end

local blink_cmp_setup = function()
    require('blink.cmp').setup({
        keymap = {
            preset = 'default',
            ['<C-n>'] = { 'select_next', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<C-p>'] = { 'select_prev', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<CR>'] = { 'accept', 'fallback' },
        },
        cmdline = { enabled = false },
        completion = {
            accept = { auto_brackets = { enabled = true }, },
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            ghost_text = { enabled = true },
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'omni' },
            -- for friendly-snippets
            providers = {
                snippets = {
                    opts = {
                        friendly_snippets = true, -- default
                        -- see the list of frameworks in: https://github.com/rafamadriz/friendly-snippets/tree/main/snippets/frameworks
                        -- and search for possible languages in: https://github.com/rafamadriz/friendly-snippets/blob/main/package.json
                        -- the following is just an example, you should only enable the frameworks that you use
                        extended_filetypes = {
                            markdown = { 'jekyll' },
                            sh = { 'shelldoc' },
                            php = { 'phpdoc' },
                            cpp = { 'unreal' }
                        }
                    }
                }
            }
        },
        signature = { enabled = true }
    })
end

local tiny_inline_diagnostic_setup = function()
    vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    require('tiny-inline-diagnostic').setup {
        preset = "modern",
        show_all_diags_on_cursorline = false,
        use_icons_from_diagnostic = true,
        set_arrow_to_diag_color = true,
        multilines = {
            enabled = false
        }
    }
end

local trouble_setup = function()
    require('trouble').setup {
        use_diagnostic_signs = true
    }
    setmap('n', "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",
        { desc = "Diagnostics (Trouble)" }
    )
    setmap('n', "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        { desc = "Buffer Diagnostics (Trouble)" }
    )
    setmap('n', "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",
        {  desc = "Symbols (Trouble)" }
    )
    setmap('n', "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        { desc = "LSP Definitions / references / ... (Trouble)" }
    )
    setmap('n', "<leader>xL", "<cmd>Trouble loclist toggle<cr>",
        { desc = "Location List (Trouble)" }
    )
    setmap('n', "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",
        { desc = "Quickfix List (Trouble)" }
    )
end

return {
    lspconfig = lspconfig_setup,
    blink_cmp = blink_cmp_setup,
    tiny_inline_diagnostic = tiny_inline_diagnostic_setup,
    trouble = trouble_setup,
}
