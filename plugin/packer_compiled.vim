" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

lua << END
local plugins = {
  ["bullets.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/bullets.vim"
  },
  indentLine = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/indentLine"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/markdown-preview.nvim"
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
  ["vim-markdown-toc"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-markdown-toc"
  },
  ["vim-table-mode"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-table-mode"
  },
  ["vim-which-key"] = {
    commands = { "WhichKey", "WhichKeyVisual" },
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
loadstring("\27LJ\2\n—\2\0\0\3\1\f\0\0256\0\0\0'\2\1\0B\0\2\1-\0\0\0'\1\3\0=\1\2\0-\0\0\0'\1\5\0=\1\4\0-\0\0\0'\1\a\0=\1\6\0-\0\0\0)\1\1\0=\1\b\0-\0\0\0)\1\0\0=\1\t\0-\0\0\0)\1\1\0=\1\n\0-\0\0\0)\1\1\0=\1\v\0K\0\1\0\1À\19AutoPairsMapCR\22AutoPairsMapSpace\19AutoPairsMapCh\19AutoPairsMapBs\5\26AutoPairsShortcutJump\n<M-e>\30AutoPairsShortcutFastWrap\bM-o\28AutoPairsShortcutToggle\22[Config]autopairs\nprint\0")()
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
  au FileType cpp ++once call s:load(['opengl.vim'], { "ft": "cpp" })
  au FileType text ++once call s:load(['markdown-preview.nvim', 'vim-table-mode', 'thesaurus_query.vim', 'bullets.vim'], { "ft": "text" })
  au FileType wiki ++once call s:load(['markdown-preview.nvim', 'vim-markdown-toc', 'vim-table-mode', 'thesaurus_query.vim', 'bullets.vim'], { "ft": "wiki" })
  au FileType markdown ++once call s:load(['markdown-preview.nvim', 'vim-markdown-toc', 'vim-table-mode', 'thesaurus_query.vim', 'bullets.vim'], { "ft": "markdown" })
  au FileType glsl ++once call s:load(['vim-glsl'], { "ft": "glsl" })
  au FileType c ++once call s:load(['opengl.vim'], { "ft": "c" })
  " Event lazy-loads
augroup END
