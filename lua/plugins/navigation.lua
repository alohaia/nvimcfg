local setmap = _G.vim.keymap.set

local _cfg_telescope = {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local telescope = require('telescope')
        -- telescope.load_extension('fzy_native')
        -- telescope.load_extension('fzf')
        telescope.setup {
            -- extensions = {
            --     fzy_native = {
            --         override_generic_sorter = false,
            --         override_file_sorter = true,
            --     },
            --     fzf = {
            --         fuzzy = true,                    -- false will only do exact matching
            --         override_generic_sorter = true,  -- override the generic sorter
            --         override_file_sorter = true,     -- override the file sorter
            --         case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
            --     },
            -- },
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case'
                },
                prompt_prefix = '   ', -- 🔍
                selection_caret = '> ', -- 
                entry_prefix = '  ',
                initial_mode = 'insert',
                sorting_strategy = 'ascending',
                selection_strategy = 'reset',
                layout_strategy = 'horizontal',
                scroll_strategy = 'cycle',
                layout_config = {
                    horizontal = {
                        prompt_position = 'top',
                        preview_width = 0.55,
                        results_width = 0.8,
                    },
                    vertical = {
                        mirror = false,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },
                file_sorter =  require'telescope.sorters'.get_fuzzy_file,
                file_ignore_patterns = { 'node_modules' },
                generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
                border = true,
                color_devicons = true,
                use_less = true,
                path_display = {},
                set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
                file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
                grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
                qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

                -- Developer configurations: Not meant for general override
                buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
                mappings = {
                    n = { ['q'] = require('telescope.actions').close },
                },
            },
        }

        -- keybindings
        setmap('n', ',r', '<Cmd>Telescope resume<CR>', {
            noremap = true, desc = "Telescope: [R]esume last searching"
        })
        setmap('n', ',f', '<Cmd>Telescope find_files<CR>', {
            noremap = true, desc = "Telescope: search [F]iles"
        })
        setmap('n', ',b', '<Cmd>Telescope buffers<CR>', {
            noremap = true, desc = "Telescope: search [B]uffers"
        })
        setmap('n', ',j', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', {
            noremap = true, desc = "Telescope: fuzzy find and [J]ump in current buffer"
        })
        setmap('n', ',g', '<Cmd>Telescope live_grep<CR>', {
            noremap = true, desc = "Telescope: live [G]rep for contents of files"
        })
        setmap('n', ',h', '<Cmd>Telescope command_history<CR>', {
            noremap = true, desc = "Telescope: search Vim command [H]istory"
        })
        setmap('n', ',H', '<Cmd>Telescope help_tags<CR>', {
            noremap = true, desc = "Telescope: search Vim [H]elp tags"
        })
        setmap('n', ',d', '<Cmd>Telescope diagnostics<CR>', {
            noremap = true, desc = "Telescope: search LSP [D]iagnostics"
        })
        setmap('n', ',sb', '<Cmd>Telescope lsp_document_symbols<CR>', {
            noremap = true, desc = "Telescope: search document [S]ymbols in current [B]uffer"
        })
        setmap('n', ',sp', '<Cmd>Telescope lsp_workspace_symbols<CR>', {
            noremap = true, desc = "Telescope: search workspace [S]ymbols in current [P]roject"
        })
    end
}

local _cfg_fzf = {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    ---@module 'fzf-lua'
    ---@type fzf-lua.Config|{}
    ---@diagnostic disable: missing-fields
    opts = {},
    ---@diagnostic enable: missing-fields
    config = function ()
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
}

return {
    -- _cfg_telescope,
    _cfg_fzf,
}
