local api = vim.api
local lspconfig = require 'lspconfig'
local format = require('aloha.plugin_configs.format')

-- lspsaga.nvim
if not vim.g.pack_lspsaga_loaded then
    vim.cmd [[packadd lspsaga.nvim]]
    vim.g.packer_plugins_loaded = true

    local saga = require 'lspsaga'
    saga.init_lsp_saga({
        code_action_icon = '💡'
    })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.cmd [[edit]]
end

function _G.open_lsp_log()
    local path = vim.lsp.get_log_path()
    vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = true,
        signs = {
          enable = true,
          priority = 20
        },
        -- Disable a feature
        update_in_insert = false,
    }
)

local enhance_attach = function(client,bufnr)
    if client.resolved_capabilities.document_formatting then
        format.lsp_before_save()
    end
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            hi LspReferenceRead cterm=bold ctermbg=red gui=underline guibg=LightGrey
            hi LspReferenceText cterm=bold ctermbg=red gui=underline guibg=LightGrey
            hi LspReferenceWrite cterm=bold ctermbg=red gui=underline guibg=LightGrey
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    -- for 'RRethy/vim-illuminate'
    require 'illuminate'.on_attach(client)
    -- for 'nvim-lua/completion-nvim'
    require('completion').on_attach(client, bufnr)
end

lspconfig.gopls.setup {
    cmd = {"gopls","--remote=auto"},
    on_attach = enhance_attach,
    capabilities = capabilities,
    init_options = {
        usePlaceholders=true,
        completeUnimported=true,
    }
}

lspconfig.sumneko_lua.setup {
    on_attach = require('completion').on_attach,
    cmd = {
        "lua-language-server",
        "-E",
        "/usr/share/lua-language-server/main.lua"
    };
    settings = {
        Lua = {
            diagnostics = {
                enable = true,
                globals = {"vim","packer_plugins"}
            },
            runtime = {version = "LuaJIT"},
            workspace = {
                library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true},{}),
            },
        },
    }
}

lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        enhance_attach(client)
        require('completion').on_attach(client, bufnr)
    end
}

lspconfig.clangd.setup {
    on_attach = require('completion').on_attach,
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
    },
}

lspconfig.rust_analyzer.setup {
    on_attach = require('completion').on_attach,
    capabilities = capabilities,
}

local servers = {
    'dockerls','bashls','pyright', 'r_language_server'
}

for _,server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = enhance_attach
    }
end