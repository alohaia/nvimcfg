-- https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-13933645
local alpha_setup = function()
    local alpha = require 'alpha'
    local utils = require('alpha.utils')
    local dashboard = require 'alpha.themes.dashboard'

    local logo = [[










                                              
       ███████████           █████      ██
      ███████████             █████ 
      ████████████████ ███████████ ███   ███████
     ████████████████ ████████████ █████ ██████████████
    █████████████████████████████ █████ █████ ████ █████
  ██████████████████████████████████ █████ █████ ████ █████
 ██████  ███ █████████████████ ████ █████ █████ ████ ██████
 ██████   ██  ███████████████   ██ █████████████████

    ]]

    -- Highlight groups configuration for each segment
    local header_hl = {
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },
        { { "Red", 1, 1 } },              -- Empty lines
        { { "AlphaHeader0_0", 46, 48 } }, -- Line 10
        {                                 -- Line 11
            { "AlphaHeader1_0", 7,  22 },
            { "AlphaHeader1_1", 33, 40 },
            { "AlphaHeader1_2", 40, 50 }
        },
        { -- Line 12
            { "AlphaHeader2_0", 6,  21 },
            { "AlphaHeader2_1", 33, 45 },
        },
        { -- Line 13
            { "AlphaHeader3_0", 6,  19 },
            { "AlphaHeader3_1", 19, 20 },
            { "AlphaHeader3_2", 20, 35 },
            { "AlphaHeader3_3", 35, 45 },
            { "AlphaHeader3_4", 45, 90 },
        },
        { -- Line 14
            { "AlphaHeader4_0", 5,  18 },
            { "AlphaHeader4_1", 18, 36 },
            { "AlphaHeader4_2", 36, 45 },
            { "AlphaHeader4_3", 45, 90 }
        },
        { -- Line 15
            { "AlphaHeader5_0", 4,  17 },
            { "AlphaHeader5_1", 17, 24 },
            { "AlphaHeader5_2", 24, 28 },
            { "AlphaHeader5_3", 28, 37 },
            { "AlphaHeader5_4", 37, 46 },
            { "AlphaHeader5_5", 46, 90 },
        },
        { -- Line 16
            { "AlphaHeader6_0", 2,  17 },
            { "AlphaHeader6_1", 17, 38 },
            { "AlphaHeader6_2", 38, 45 },
            { "AlphaHeader6_3", 46, 90 },
        },
        { -- Line 17
            { "AlphaHeader7_0", 1,  17 },
            { "AlphaHeader7_1", 17, 38 },
            { "AlphaHeader7_2", 38, 45 },
            { "AlphaHeader7_3", 46, 90 },
        },
        { -- Line 18
            { "AlphaHeader8_0", 1,  37 },
            { "AlphaHeader8_1", 37, 91 },
        }
    }

    vim.api.nvim_set_hl(0, "AlphaHeader0_0", { fg = "#a6c9ab" })
    vim.api.nvim_set_hl(0, "AlphaHeader1_0", { fg = "#bb7744" })
    vim.api.nvim_set_hl(0, "AlphaHeader1_1", { fg = "#386c3f" })
    vim.api.nvim_set_hl(0, "AlphaHeader1_2", { fg = "#a6c9ab" })
    vim.api.nvim_set_hl(0, "AlphaHeader2_0", { fg = "#be7d46" })
    vim.api.nvim_set_hl(0, "AlphaHeader2_1", { fg = "#3d7344" })
    vim.api.nvim_set_hl(0, "AlphaHeader3_0", { fg = "#c18250" })
    vim.api.nvim_set_hl(0, "AlphaHeader3_1", { fg = "#5c441e" })
    vim.api.nvim_set_hl(0, "AlphaHeader3_2", { fg = "#d6c383" })
    vim.api.nvim_set_hl(0, "AlphaHeader3_3", { fg = "#407b48" })
    vim.api.nvim_set_hl(0, "AlphaHeader3_4", { fg = "#98c09c" })
    vim.api.nvim_set_hl(0, "AlphaHeader4_0", { fg = "#c38950" })
    vim.api.nvim_set_hl(0, "AlphaHeader4_1", { fg = "#e0c785" })
    vim.api.nvim_set_hl(0, "AlphaHeader4_2", { fg = "#44844b" })
    vim.api.nvim_set_hl(0, "AlphaHeader4_3", { fg = "#a0c4a3" })
    vim.api.nvim_set_hl(0, "AlphaHeader5_0", { fg = "#c58f56" })
    vim.api.nvim_set_hl(0, "AlphaHeader5_1", { fg = "#e2cb85" })
    vim.api.nvim_set_hl(0, "AlphaHeader5_2", { fg = "#5c441e" })
    vim.api.nvim_set_hl(0, "AlphaHeader5_3", { fg = "#e2cb85" })
    vim.api.nvim_set_hl(0, "AlphaHeader5_4", { fg = "#488c51" })
    vim.api.nvim_set_hl(0, "AlphaHeader5_5", { fg = "#a6c9ab" })
    vim.api.nvim_set_hl(0, "AlphaHeader6_0", { fg = "#c7955b" })
    vim.api.nvim_set_hl(0, "AlphaHeader6_1", { fg = "#e3cf88" })
    vim.api.nvim_set_hl(0, "AlphaHeader6_2", { fg = "#4d9356" })
    vim.api.nvim_set_hl(0, "AlphaHeader6_3", { fg = "#aecdb3" })
    vim.api.nvim_set_hl(0, "AlphaHeader7_0", { fg = "#c89b62" })
    vim.api.nvim_set_hl(0, "AlphaHeader7_1", { fg = "#e5d38a" })
    vim.api.nvim_set_hl(0, "AlphaHeader7_2", { fg = "#509b59" })
    vim.api.nvim_set_hl(0, "AlphaHeader7_3", { fg = "#b7d1b9" })
    vim.api.nvim_set_hl(0, "AlphaHeader8_0", { fg = "#5c441e" })
    vim.api.nvim_set_hl(0, "AlphaHeader8_1", { fg = "#2e4e2a" })

    local header_val = vim.split(logo, '\n')
    header_hl = utils.charhl_to_bytehl(header_hl, header_val, false)

    dashboard.section.header.opts.hl = header_hl
    dashboard.section.header.val = header_val
    -- Split logo into lines
    local logoLines = {}
    for line in logo:gmatch('[^\r\n]+') do
        table.insert(logoLines, line)
    end

    local init_path = vim.fn.stdpath('config')
    dashboard.section.buttons.val = {
        dashboard.button('e', '  New file', '<Cmd>ene <BAR> startinsert<CR>'),
        dashboard.button('r', '󱋡  Recent files', '<Cmd>FzfLua oldfiles<CR>'),
        dashboard.button('s', '󰁯  Restore session', '<Cmd>SessionRestore<CR>'),
        dashboard.button(
            'f', '󰈞  Find files',
            '<Cmd>silent FzfLua files<CR>'
        ),
        dashboard.button(
            'c', '  Config', '<Cmd>cd ' .. init_path .. '<CR><Cmd>e init.lua<CR>'
        ),
        dashboard.button('q', '󰿅  Quit', '<Cmd>q<CR>'),
    }

    dashboard.section.buttons.opts.hl = 'AlphaHeader1_0'

    -- footer: fortune
    dashboard.section.footer.val = require'alpha.fortune'()

    dashboard.opts.opts.noautocmd = true

    alpha.setup(dashboard.opts)
end

local lualine_setup = function()
    local function spelllang()
        return string.upper(table.concat(vim.opt.spelllang:get(), ','))
    end
    require('lualine').setup {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = { left = '┆', right = '┆'},
            section_separators = { left = '┆', right = '┆'},
            disabled_filetypes = { 'toggleterm' },
            always_divide_middle = true,
            globalstatus = false,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                { 'filetype', color = { bg='#2c323c' } },
                { 'filename' },
                -- { require('r.utils').get_lang } -- TODO
            },
            lualine_x = {
                'encoding',
                { 'fileformat', color = { bg='#2c323c' } }
            },
            lualine_y = {
                {
                    spelllang,
                    cond = function() return vim.opt.spell:get() end
                },
                'progress'
            },
            lualine_z = { 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        -- https://github.com/nvim-lualine/lualine.nvim#extensions
        extensions = {'lazy', 'fzf', 'man', 'neo-tree', 'oil', 'toggleterm'}
    }
end

local bufferline_setup = function()
    local colors = {
        white = "#ABB2BF",
        gray = "#3E4452",
        dark_gray = "#2C323C",
        green = "#98C379",
    }
    local hls_style = {
        normal = { bg=colors.dark_gray, italic=true, bold=false },
        selected = { bg=colors.white, italic=false, bold=true },
        visible = { bg=colors.gray, italic=false, bold=true }
    }
    local hls = {
        normal = { bg=colors.dark_gray },
        selected = { bg=colors.white },
        visible = { bg=colors.gray }
    }
    local expand_name = {
        ['index.md'] = {prefix = '(i)'},
        ['index.Rmd'] = {prefix = '(i.r)'},
        ['_index.md'] = {prefix = '(I)'},
        ['_index.Rmd'] = {prefix = '(I.r)'},
        ['init.lua'] = true,
    }
    require('bufferline').setup {
        highlights = {
            fill = { bg='NONE' },

            background = hls_style.normal,
            buffer_selected = vim.tbl_extend('force', hls_style.selected, { fg=colors.dark_gray }),
            buffer_visible = hls_style.visible,

            hint = hls_style.normal,
            hint_selected = vim.tbl_extend('force', hls_style.selected, { fg=colors.dark_gray }),
            hint_visible = hls_style.visible,
            info = hls_style.normal, info_selected = hls_style.selected, info_visible = hls_style.visible,
            warning = hls_style.normal, warning_selected = hls_style.selected, warning_visible = hls_style.visible,
            error = hls_style.normal, error_selected = hls_style.selected, error_visible = hls_style.visible,
            hint_diagnostic = hls.normal,
            hint_diagnostic_selected = vim.tbl_extend('force', hls_style.selected, { fg=colors.dark_gray }),
            hint_diagnostic_visible = hls.visible,
            info_diagnostic = hls.normal, info_diagnostic_selected = hls.selected, info_diagnostic_visible = hls.visible,
            warning_diagnostic = hls.normal, warning_diagnostic_selected = hls.selected, warning_diagnostic_visible = hls.visible,
            error_diagnostic = hls.normal, error_diagnostic_selected = hls.selected, error_diagnostic_visible = hls.visible,

            duplicate = { bg=colors.dark_gray },
            duplicate_selected = { fg=colors.dark_gray, bg=colors.white },
            duplicate_visible = { bg=colors.gray },

            separator = { bg=colors.dark_gray },
            separator_selected = { fg=colors.dark_gray, bg=colors.white },
            separator_visible = { bg=colors.gray },

            indicator_selected = { fg=colors.dark_gray, bg=colors.white },
            indicator_visible = { bg=colors.gray },

            numbers = { bg=colors.dark_gray, italic=hls_style.normal.italic },
            numbers_selected = { fg=colors.dark_gray, bg=colors.white, italic=hls_style.selected.italic },
            numbers_visible = { bg=colors.gray, italic=hls_style.visible.italic },

            tab = { bg=colors.dark_gray },
            tab_selected = { fg=colors.dark_gray, bg=colors.white },

            tab_separator = { fg=colors.dark_gray, bg=colors.dark_gray },
            tab_separator_selected = { fg=colors.white, bg=colors.white },

            modified = { fg=colors.green, bg=colors.dark_gray },
            modified_selected = { fg=colors.dark_gray, bg=colors.white },
            modified_visible = { fg=colors.green, bg=colors.gray },

            pick = { fg=colors.green, bg=colors.dark_gray },
            pick_visible = { fg=colors.dark_gray, bg=colors.white },
            pick_selected = { fg=colors.green, bg=colors.gray },

            diagnostic = { bg=colors.dark_gray },
            diagnostic_visible = { fg=colors.dark_gray, bg=colors.white },
            diagnostic_selected = { bg=colors.gray },

            offset_separator = { bg=colors.dark_gray },
        },
        options = {
            mode = 'buffers',
            numbers = 'buffer_id',
            close_command = 'bdelete! %d',
            right_mouse_command = 'bdelete! %d',
            left_mouse_command = 'buffer %d',
            middle_mouse_command = nil,
            show_buffer_icons = true,
            show_buffer_close_icons = false,
            show_tab_indicators = true,
            show_close_icon = false,
            indicator = { style = 'none' },
            modified_icon = 'M', -- ✥ ●
            left_trunc_marker = '<', -- 
            right_trunc_marker = '>', -- 
            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            name_formatter = function(buf)
                if expand_name[buf.name] then
                    local path_slices = vim.split(buf.path, '/')
                    local basename = path_slices[#path_slices-1]
                    if type(expand_name[buf.name]) == 'string' then
                        return basename .. expand_name[buf.name]
                    elseif type(expand_name[buf.name]) == 'table' then
                        local bufname
                        if expand_name[buf.name].prefix then
                            bufname = expand_name[buf.name].prefix .. basename
                        end
                        if expand_name[buf.name].suffix then
                            bufname = basename .. expand_name[buf.name].suffix
                        end
                        return bufname
                    else
                        return basename .. '/' .. buf.name
                    end
                else
                    return buf.name
                end
            end,
            tab_size = 18,
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(count, level, _, context)
                local sym = level == 'error' and 'E'
                    or (level == 'warning' and 'W' or (level == 'hint' and 'H' or 'I'))
                return sym..' ('..count..')'
            end,
            offsets = {
                {
                    filetype = 'vista_markdown',
                    text = 'Vista Tags',
                    highlight = 'Title',
                    text_align = 'left',
                }
            },
            persist_buffer_sort = true,
            separator_style = { '', '' },
            enforce_regular_tabs = false,
            always_show_bufferline = true,
            sort_by = 'id',
        }
    }
    vim.keymap.set('n', 'gb', '<Cmd>BufferLinePick<CR>', {
        noremap = true, silent = true
    })
end

return {
    alpha = alpha_setup,
    lualine = lualine_setup,
    bufferline = bufferline_setup
}
