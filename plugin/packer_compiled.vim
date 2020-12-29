" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

lua << END
local plugins = {
  indentLine = {
    config = { "\27LJ\2\nÇ\2\0\0\2\0\n\0\0256\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\2\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0)\1Ô\0=\1\5\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0005\1\t\0=\1\b\0K\0\1\0\1\2\0\0\vpython\24indentLine_fileType\b‚îÜ\20indentLine_char\26indentLine_color_term\25indentLine_setColors\30indent_guides_start_level\29indent_guides_guide_size\6g\bvim\0" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/indentLine"
  },
  ["opengl.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/opengl.vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/packer.nvim"
  },
  ["thesaurus_query.vim"] = {
    config = { "\27LJ\2\nÚ\2\0\0\5\0\16\0\0256\0\0\0009\0\1\0009\0\2\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\a\0009\0\b\0)\1\0\0=\1\t\0006\0\a\0009\0\b\0'\1\v\0=\1\n\0006\0\a\0009\0\b\0'\1\r\0=\1\f\0006\0\a\0009\0\b\0'\1\15\0=\1\14\0K\0\1\0'~/.config/nvim/thesaurus/cilin.txt\22tq_cilin_txt_file*~/.config/nvim/thesaurus/mthesaur.txt\21tq_mthesaur_file*~/.config/nvim/thesaurus/th_en_US_new\26tq_openoffice_en_file\16tq_map_keys\6g\bvim.<Cmd>ThesaurusQueryReplaceCurrentWord<CR>\15<Leader>cw\6n\fadd_map\bmap\bwim\naloha\0" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/thesaurus_query.vim"
  },
  ["vim-glsl"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-glsl"
  },
  ["vim-which-key"] = {
    commands = { "WhichKey", "WhichKeyVisual" },
    config = { "\27LJ\2\n√\1\0\0\6\0\r\0\0196\0\0\0009\0\1\0009\0\2\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0005\5\a\0B\0\5\0016\0\b\0009\0\t\0004\1\0\0=\1\n\0006\0\b\0009\0\t\0009\0\n\0005\1\f\0=\1\v\0K\0\1\0\1\0\1\tname\n+file\6j\18which_key_map\6g\bvim\1\0\1\vsilent\1\28:<C-u>WhichKey \"\"<Left>\21<leader><leader>\6n\fadd_map\bmap\bwim\naloha\0" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-which-key"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra, '<[cC][rR]>', '\r'))
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Post-load configuration
-- Config for: auto-pairs
loadstring("\27LJ\2\nì\2\0\0\2\0\f\0\0296\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0)\1\1\0=\1\b\0006\0\0\0009\0\1\0)\1\0\0=\1\t\0006\0\0\0009\0\1\0)\1\1\0=\1\n\0006\0\0\0009\0\1\0)\1\1\0=\1\v\0K\0\1\0\19AutoPairsMapCR\22AutoPairsMapSpace\19AutoPairsMapCh\19AutoPairsMapBs\5\26AutoPairsShortcutJump\n<M-e>\30AutoPairsShortcutFastWrap\bM-o\28AutoPairsShortcutToggle\6g\bvim\0")()
-- Config for: agit.vim
loadstring("\27LJ\2\n:\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\0\0=\1\2\0K\0\1\0\29agit_no_default_mappings\6g\bvim\0")()
-- Config for: vim-startify
loadstring("\27LJ\2\n«\t\0\0\a\0-\0`6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0)\1\3\0=\1\5\0006\0\0\0009\0\1\0006\1\a\0009\1\b\0019\1\t\0016\3\a\0009\3\n\0039\3\v\0039\3\f\3'\4\r\0B\1\3\2=\1\6\0006\0\0\0009\0\1\0)\1\0\0=\1\14\0006\0\0\0009\0\1\0)\1\1\0=\1\15\0006\0\0\0009\0\1\0005\1\17\0=\1\16\0006\0\0\0009\0\1\0)\1\n\0=\1\18\0006\0\0\0009\0\1\0005\1\20\0=\1\19\0006\0\0\0009\0\1\0004\1\4\0005\2\23\0005\3\22\0=\3\24\2>\2\1\0015\2\26\0005\3\25\0=\3\27\2>\2\2\0015\2\29\0005\3\28\0=\3\30\2>\2\3\1=\1\21\0006\0\0\0009\0\1\0004\1\6\0005\2 \0005\3!\0=\3\"\2>\2\1\0015\2#\0005\3$\0=\3\"\2>\2\2\0015\2%\0005\3&\0=\3\"\2>\2\3\0015\2'\0004\3\3\0'\4(\0006\5\0\0009\5)\0059\5*\5B\5\1\2&\4\5\4>\4\1\3=\3\"\2>\2\4\0015\2+\0005\3,\0=\3\"\2>\2\5\1=\1\31\0K\0\1\0\1\2\0\0\17   Bookmarks\1\0\1\ttype\14bookmarks\vgetcwd\afn\r   PWD: \1\0\1\ttype\bdir\1\2\0\0\16   Sessions\1\0\1\ttype\rsessions\1\2\0\0\27   Recent Opened Files\1\0\1\ttype\nfiles\vheader\1\2\0\0\16   Commands\1\0\1\ttype\rcommands\19startify_lists\6d\1\0\0\1\3\0\0'Open Index page for Vimwiki Diary.\22VimwikiDiaryIndex\6w\1\0\0\1\3\0\0!Open Index page for Vimwiki.\17VimwikiIndex\6t\1\0\0\1\3\0\0\"Press t to open coc-explorer.\24CocCommand explorer\22startify_commands\1\3\0\0I~/.config/nvim/plugins/vimspector/docs/schema/vimspector.schema.jsonF~/.config/nvim/plugins/vimspector/docs/schema/gadgets.schema.json\23startify_bookmarks\26startify_files_number\1\2\0\0\n\\.git\22startify_skiplist\30startify_session_autoload!startify_session_persistence\rstartify\15cache_base\npaths\vglobal\15join_paths\nutils\naloha\25startify_session_dir\26startify_padding_left!startify_fortune_use_unicode\27startify_change_to_dir\31startify_change_to_vcs_dir\6g\bvim\0")()
-- Config for: undotree
loadstring("\27LJ\2\nè\3\0\0\5\0\18\0!6\0\0\0009\0\1\0009\0\2\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\a\0009\0\b\0'\1\n\0=\1\t\0006\0\a\0009\0\b\0'\1\f\0=\1\v\0006\0\a\0009\0\b\0)\1\1\0=\1\r\0006\0\a\0009\0\b\0'\1\15\0=\1\14\0006\0\a\0009\0\b\0)\1\0\0=\1\16\0006\0\a\0009\0\b\0)\1\0\0=\1\17\0K\0\1\0\22undotree_HelpLine\31undotree_RelativeTimestamp\b‚öë\27undotree_TreeNodeShape undotree_SetFocusWhenToggle\20botright 10 new undotree_CustomDiffpanelCmd\28topleft vertical 30 new\31undotree_CustomUndotreeCmd\6g\bvim\28<Cmd>UndotreeToggle<CR>\15<leader>ut\6n\fadd_map\bmap\bwim\naloha\0")()
-- Config for: vim-choosewin
loadstring("\27LJ\2\n¯\5\0\0\5\0\31\0E6\0\0\0009\0\1\0009\0\2\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\a\0009\0\b\0005\1\v\0005\2\n\0=\2\f\0015\2\r\0=\2\14\1=\1\t\0006\0\a\0009\0\b\0005\1\17\0005\2\16\0=\2\f\0015\2\18\0=\2\14\1=\1\15\0006\0\a\0009\0\b\0006\1\a\0009\1\b\0019\1\t\1=\1\19\0006\0\a\0009\0\b\0006\1\a\0009\1\b\0019\1\15\1=\1\20\0006\0\a\0009\0\b\0005\1\23\0005\2\22\0=\2\f\0015\2\24\0=\2\14\1=\1\21\0006\0\a\0009\0\b\0)\1\0\0=\1\25\0006\0\a\0009\0\b\0)\1\0\0=\1\26\0006\0\a\0009\0\b\0)\1\0\0=\1\27\0006\0\a\0009\0\b\0)\1\0\0=\1\28\0006\0\a\0009\0\b\0)\1\1\0=\1\29\0006\0\a\0009\0\b\0)\1\1\0=\1\30\0K\0\1\0\28choosewin_overlay_shade\29choosewin_overlay_enable!choosewin_statusline_replace#choosewin_return_on_single_win\28choosewin_blink_on_land\25choosewin_label_fill\1\3\0\0\0033\3\15\1\0\0\1\4\0\0\f#00ffff\nBlack\19bold,underline\25choosewin_color_land$choosewin_color_overlay_current\28choosewin_color_overlay\1\4\0\0\3ì\1\3\15\tbold\1\0\0\1\4\0\0\f#afafff\nwhite\tbold\"choosewin_color_label_current\ncterm\1\4\0\0\3Å\1\3\16\tbold\bgui\1\0\0\1\4\0\0\f#af00ff\nblack\tbold\26choosewin_color_label\6g\bvim\23<Cmd>ChooseWin<CR>\15<C-w><C-i>\6n\fadd_map\bmap\bwim\naloha\0")()
-- Config for: vim-visual-multi
loadstring("\27LJ\2\nn\0\0\2\0\5\0\t6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0K\0\1\0\24VM_default_mappings\1\0\3\vbuffer\6,\vvisual\6,\fdefault\6,\14VM_leader\6g\bvim\0")()
-- Config for: ultisnips
loadstring("\27LJ\2\nÖ\2\0\0\2\0\v\0\0216\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0006\0\0\0009\0\1\0'\1\b\0=\1\a\0006\0\0\0009\0\1\0'\1\n\0=\1\t\0K\0\1\0\n<c-k>!UltiSnipsJumpBackwardTrigger\n<c-j> UltiSnipsJumpForwardTrigger\14<c-space>\27UltiSnipsExpandTrigger&UltiSnipsRemoveSelectModeMappings\rvertical\23UltiSnipsEditSplit\6g\bvim\0")()
-- Config for: vim-translator
loadstring("\27LJ\2\nà\2\0\0\5\0\r\0\0206\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\4\0005\3\5\0>\3\4\0025\3\6\0005\4\a\0>\4\4\3B\0\3\0016\0\b\0009\0\t\0)\1\1\0=\1\n\0006\0\b\0009\0\t\0'\1\f\0=\1\v\0K\0\1\0\npopup\27translator_window_type\30translator_history_enable\6g\bvim\1\0\1\vsilent\1\1\4\0\0\6x\14<Leader>t\23<Cmd>Translate<Cr>\1\0\1\vsilent\1\1\4\0\0\6n\14<Leader>t\24<Cmd>TranslateW<Cr>\radd_maps\bmap\bwim\naloha\0")()
-- Config for: rainbow
loadstring("\27LJ\2\n0\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0\19rainbow_active\6g\bvim\0")()
-- Config for: nvim-treesitter
loadstring("\27LJ\2\nù\2\0\0\5\0\v\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0004\4\0\0=\4\5\3=\3\6\0025\3\a\0=\3\b\0025\3\t\0=\3\n\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\fkeymaps\1\0\4\21node_incremental\bgrn\22scope_incremental\bgrc\19init_selection\bgnn\21node_decremental\bgrm\14highlight\20custom_captures\1\0\1\venable\2\1\0\1\21ensure_installed\15maintained\nsetup\28nvim-treesitter.configs\frequire\0")()
-- Config for: clever-f.vim
loadstring("\27LJ\2\n⁄\2\0\0\2\0\f\0\0296\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\1\0=\1\4\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0006\0\0\0009\0\1\0005\1\b\0=\1\a\0006\0\0\0009\0\1\0)\1\1\0=\1\t\0006\0\0\0009\0\1\0'\1\v\0=\1\n\0K\0\1\0\24CleverFDefaultLabel\31clever_f_mark_direct_color\25clever_f_mark_direct\1\3\0\0\n\\<CR>\v\\<Tab>%clever_f_repeat_last_char_inputs\5#clever_f_chars_match_any_signs\31clever_f_fix_key_direction\24clever_f_use_migemo\24clever_f_smart_case\6g\bvim\0")()
-- Config for: vim-floaterm
loadstring("\27LJ\2\nò\3\0\0\2\0\17\1)6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0'\1\a\0=\1\6\0006\0\0\0009\0\1\0'\1\t\0=\1\b\0006\0\0\0009\0\1\0'\1\v\0=\1\n\0006\0\0\0009\0\1\0)\1\1\0=\1\f\0006\0\0\0009\0\1\0*\1\0\0=\1\r\0006\0\0\0009\0\1\0*\1\0\0=\1\14\0006\0\0\0009\0\1\0)\1\1\0=\1\15\0006\0\0\0009\0\1\0)\1\1\0=\1\16\0K\0\1\0\23floaterm_autoclose\22floaterm_wintitle\20floaterm_height\19floaterm_width\24floaterm_autoinsert\rfloaterm\23floaterm_gitcommit\t<F4>\24floaterm_keymap_new\t<F3>\25floaterm_keymap_next\t<F2>\25floaterm_keymap_prev\t<F1>\27floaterm_keymap_toggle\6g\bvimµÊÃô\19ô≥¶ˇ\3\0")()
-- Config for: defx.nvim
loadstring("\27LJ\2\næ\a\0\0\5\0\"\1@6\0\0\0009\0\1\0009\0\2\0009\0\3\0'\2\4\0'\3\5\0'\4\6\0B\0\4\0016\0\a\0009\0\b\0009\0\t\0'\2\n\0005\3\v\0006\4\a\0009\4\f\0049\4\r\4\25\4\0\4=\4\14\3B\0\3\0016\0\a\0009\0\b\0009\0\15\0'\2\16\0'\3\17\0005\4\18\0B\0\4\0016\0\a\0009\0\b\0009\0\15\0'\2\19\0'\3\19\0'\4\20\0B\0\4\0016\0\a\0009\0\b\0009\0\15\0'\2\21\0005\3\22\0B\0\3\0016\0\a\0009\0\b\0009\0\23\0'\2\24\0005\3\25\0B\0\3\0016\0\a\0009\0\26\0)\1\1\0=\1\27\0006\0\a\0009\0\26\0'\1\29\0=\1\28\0006\0\a\0009\0\26\0'\1\31\0=\1\30\0006\0\a\0009\0\b\0009\0\15\0'\2 \0005\3!\0B\0\3\1K\0\1\0\1\0\2\18readonly_icon\bÔÄ£\18selected_icon\bÔêÆ\tmark\bÔêÅ\27defx_icons_parent_icon\bÔêÆ\25defx_icons_mark_icon\29defx_icons_column_length\6g\1\0\1\troot\tRoot\tfile\23defx#custom#source\1\0\3\19directory_icon\b‚ñ∏\14root_icon\6 \16opened_icon\b‚ñæ\ticon\a  \vindent\1\0\b\rUnmerged\6=\fRenamed\6R\fUnknown\6?\14Untracked\6U\fDeleted\6D\vStaged\6S\fIgnored\6~\rModified\6M\15indicators\bgit\23defx#custom#column\19preview_height\nlines\6o\1\0\f\16buffer_name\tDefx\fcolumns7mark:indent:git:icon:icons:filename:type:size:time\16root_marker\v[in]: \14direction\ftopleft\tsort\rfilename\rwinwidth\3(\nsplit\rvertical\nfocus\3\1\vtoggle\3\1\18ignored_files$.*,*.webp,*.png,*.jpg,*.o,*.exe\23show_ignored_files\3\0\vresume\3\1\6_\23defx#custom#option\afn\bvim\18<Cmd>Defx<Cr>\15<leader>df\6n\fadd_map\bmap\bwim\naloha\4\0")()
-- Config for: onedark.vim
vim.cmd('colorscheme onedark')
-- Config for: vim-hexokinase
loadstring("\27LJ\2\næ\1\0\0\2\0\a\0\r6\0\0\0009\0\1\0005\1\3\0=\1\2\0006\0\0\0009\0\1\0005\1\5\0=\1\4\0006\0\0\0009\0\1\0)\1\1\0=\1\6\0K\0\1\0\28Hexokinase_termDisabled\1\4\0\0\rBufWrite\fBufRead\16InsertLeave\29Hexokinase_refreshEvents\1\2\0\0\19backgroundfull\28Hexokinase_highlighters\6g\bvim\0")()
-- Config for: vim-yoink
loadstring("\27LJ\2\n≤\21\0\0$\0^\0û\0016\0\0\0009\0\1\0)\1(\0=\1\2\0006\0\0\0009\0\1\0)\1\1\0=\1\3\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\5\0009\0\6\0009\0\a\0009\0\b\0005\2\t\0005\3\n\0>\3\4\0025\3\v\0005\4\f\0>\4\4\0035\4\r\0005\5\14\0>\5\4\0045\5\15\0005\6\16\0>\6\4\0055\6\17\0005\a\18\0>\a\4\0065\a\19\0005\b\20\0>\b\4\a5\b\21\0005\t\22\0>\t\4\b5\t\23\0005\n\24\0>\n\4\tB\0\t\0016\0\0\0009\0\1\0)\1\0\0=\1\25\0006\0\0\0009\0\1\0)\1\1\0=\1\26\0006\0\0\0009\0\1\0)\1\1\0=\1\27\0006\0\5\0009\0\6\0009\0\a\0009\0\b\0005\2\28\0005\3\29\0>\3\4\0025\3\30\0005\4\31\0>\4\4\0035\4 \0005\5!\0>\5\4\0045\5\"\0005\6#\0>\6\4\0055\6$\0005\a%\0>\a\4\0065\a&\0005\b'\0>\b\4\a5\b(\0005\t)\0>\t\4\b5\t*\0005\n+\0>\n\4\t5\n,\0005\v-\0>\v\4\n5\v.\0005\f/\0>\f\4\v5\f0\0005\r1\0>\r\4\f5\r2\0005\0143\0>\14\4\r5\0144\0005\0155\0>\15\4\0145\0156\0005\0167\0>\16\4\0155\0168\0005\0179\0>\17\4\0165\17:\0005\18;\0>\18\4\0175\18<\0005\19=\0>\19\4\0185\19>\0005\20?\0>\20\4\0195\20@\0005\21A\0>\21\4\0205\21B\0005\22C\0>\22\4\0215\22D\0005\23E\0>\23\4\0225\23F\0005\24G\0>\24\4\0235\24H\0005\25I\0>\25\4\0245\25J\0005\26K\0>\26\4\0255\26L\0005\27M\0>\27\4\0265\27N\0005\28O\0>\28\4\0275\28P\0005\29Q\0>\29\4\0285\29R\0005\30S\0>\30\4\0295\30T\0005\31U\0>\31\4\0305\31V\0005 W\0> \4\0315 X\0005!Y\0>!\4 5!Z\0005\"[\0>\"\4!5\"\\\0005#]\0>#\4\"B\0\"\1K\0\1\0\1\0\1\fnoremap\1\1\4\0\0\6n\b\\ww!<Plug>(easymotion-overwin-w)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\wl$<Plug>(easymotion-overwin-line)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\wF\"<Plug>(easymotion-overwin-f2)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\wf!<Plug>(easymotion-overwin-f)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\nT\26<Plug>(easymotion-Tn)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\nt\26<Plug>(easymotion-tn)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\nF\26<Plug>(easymotion-Fn)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\nf\26<Plug>(easymotion-fn)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\ns\26<Plug>(easymotion-sn)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\2T\26<Plug>(easymotion-T2)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\2t\26<Plug>(easymotion-t2)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\2F\26<Plug>(easymotion-F2)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\2f\26<Plug>(easymotion-f2)\1\0\1\fnoremap\1\1\4\0\0\6n\b\\2s\26<Plug>(easymotion-s2)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\s\26 <Plug>(easymotion-s)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\N\26 <Plug>(easymotion-N)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\n\26 <Plug>(easymotion-n)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\k\26 <Plug>(easymotion-k)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\j\26 <Plug>(easymotion-j)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\g\27 <Plug>(easymotion-gE)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\g\27 <Plug>(easymotion-ge)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\E\26 <Plug>(easymotion-E)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\e\26 <Plug>(easymotion-e)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\B\26 <Plug>(easymotion-B)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\b\26 <Plug>(easymotion-b)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\W\26 <Plug>(easymotion-W)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\w\26 <Plug>(easymotion-w)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\T\26 <Plug>(easymotion-T)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\t\26 <Plug>(easymotion-t)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\F\26 <Plug>(easymotion-F)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\f\26 <Plug>(easymotion-f)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\.\31 <Plug>(easymotion-repeat)\1\0\1\fnoremap\1\1\4\0\0\6n\a\\'\31 <Plug>(easymotion-prefix)\25EasyMotion_smartcase\24EasyMotion_do_shade\26EasyMotion_do_mapping\1\0\2\vsilent\1\fnoremap\1\1\4\0\0\6x\6y,<plug>(YoinkYankPreserveCursorPosition)\1\0\2\vsilent\1\fnoremap\1\1\4\0\0\6n\6y,<plug>(YoinkYankPreserveCursorPosition)\1\0\2\vsilent\1\fnoremap\1\1\4\0\0\6n\a]y\31<plug>(YoinkRotateForward)\1\0\2\vsilent\1\fnoremap\1\1\4\0\0\6n\a[y\28<plug>(YoinkRotateBack)\1\0\2\vsilent\1\fnoremap\1\1\4\0\0\6n\6P\25<plug>(YoinkPaste_P)\1\0\2\vsilent\1\fnoremap\1\1\4\0\0\6n\6p\25<plug>(YoinkPaste_p)\1\0\2\vsilent\1\fnoremap\1\1\4\0\0\6n\n<c-p>&<plug>(YoinkPostPasteSwapForward)\1\0\2\vsilent\1\fnoremap\1\1\4\0\0\6n\n<c-n>#<plug>(YoinkPostPasteSwapBack)\radd_maps\bmap\bwim\naloha\25yoinkSwapClampAtEnds\26yoinkSavePersistently\18yoinkMaxItems\6g\bvim\0")()
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads
command! -nargs=* -range -bang -complete=file WhichKey call s:load(['vim-which-key'], { "cmd": "WhichKey", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WhichKeyVisual call s:load(['vim-which-key'], { "cmd": "WhichKeyVisual", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType python ++once call s:load(['indentLine'], { "ft": "python" })
  au FileType text ++once call s:load(['thesaurus_query.vim'], { "ft": "text" })
  au FileType wiki ++once call s:load(['thesaurus_query.vim'], { "ft": "wiki" })
  au FileType markdown ++once call s:load(['thesaurus_query.vim'], { "ft": "markdown" })
  au FileType cpp ++once call s:load(['opengl.vim'], { "ft": "cpp" })
  au FileType glsl ++once call s:load(['vim-glsl'], { "ft": "glsl" })
  au FileType c ++once call s:load(['opengl.vim'], { "ft": "c" })
  " Event lazy-loads
augroup END
