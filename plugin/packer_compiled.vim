" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif
try

lua << END
  local package_path_str = "/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
  local install_cpath_pattern = "/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
  if not string.find(package.path, package_path_str, 1, true) then
    package.path = package.path .. ';' .. package_path_str
  end

  if not string.find(package.cpath, install_cpath_pattern, 1, true) then
    package.cpath = package.cpath .. ';' .. install_cpath_pattern
  end

_G.packer_plugins = {
  ["agit.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/agit.vim"
  },
  ["any-jump.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/any-jump.vim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/asyncrun.vim"
  },
  ["asynctasks.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/asynctasks.vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/auto-pairs"
  },
  ["clever-f.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/clever-f.vim"
  },
  ["completion-nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/completion-nvim"
  },
  ["defx-git"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/defx-git"
  },
  ["defx-icons"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/defx-icons"
  },
  ["defx.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/defx.nvim"
  },
  ["far.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/far.vim"
  },
  ["fzf.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/fzf.vim"
  },
  indentLine = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/indentLine"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/lsp-status.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/markdown-preview.nvim"
  },
  nerdcommenter = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/nerdcommenter"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/onedark.vim"
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
  rainbow = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/rainbow"
  },
  ["thesaurus_query.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/thesaurus_query.vim"
  },
  ultisnips = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/ultisnips"
  },
  undotree = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/undotree"
  },
  ["vim-after-object"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-after-object"
  },
  ["vim-airline"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-airline"
  },
  ["vim-capslock"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-capslock"
  },
  ["vim-choosewin"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-choosewin"
  },
  ["vim-colors-solarized"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-colors-solarized"
  },
  ["vim-devicons"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-easymotion"
  },
  ["vim-endwise"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-endwise"
  },
  ["vim-floaterm"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-fugitive"
  },
  ["vim-glsl"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-glsl"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-hexokinase"
  },
  ["vim-illuminate"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-illuminate"
  },
  ["vim-markdown-toc"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-markdown-toc"
  },
  ["vim-repeat"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-repeat"
  },
  ["vim-startify"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-startify"
  },
  ["vim-subversive"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-subversive"
  },
  ["vim-surround"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-surround"
  },
  ["vim-translator"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-translator"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-visual-multi"
  },
  ["vim-which-key"] = {
    commands = { "WhichKey", "WhichKeyVisual" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-which-key"
  },
  ["vim-yoink"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-yoink"
  },
  vimtex = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vimtex"
  },
  vimwiki = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vimwiki"
  },
  ["vista.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/vista.vim"
  },
  ["zeavim.vim"] = {
    loaded = true,
    only_sequence = true,
    only_setup = false,
    path = "/home/aloha/.config/nvim/pack/packer/start/zeavim.vim"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = packer_plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
        return
      end
    end
  end
end

local packer_load = nil
local function handle_after(name, before)
  local plugin = packer_plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    packer_load({name}, {})
  end
end

packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not packer_plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if packer_plugins[name].commands then
      for _, cmd in ipairs(packer_plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if packer_plugins[name].keys then
      for _, key in ipairs(packer_plugins[name].keys) do
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
    if not packer_plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      if packer_plugins[name].config then
        for _i, config_line in ipairs(packer_plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if packer_plugins[name].after then
        for _, after_name in ipairs(packer_plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      packer_plugins[name].loaded = true
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
      local prefix = vim.v.count ~= 0 and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    local escaped_keys = vim.api.nvim_replace_termcodes(cause.keys .. extra, true, true, true)
    vim.api.nvim_feedkeys(escaped_keys, 'm', true)
  elseif cause.event then
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

_packer_load_wrapper = function(names, cause)
  success, err_msg = pcall(packer_load, names, cause)
  if not success then
    vim.cmd('echohl ErrorMsg')
    vim.cmd('echomsg "Error in packer_compiled: ' .. vim.fn.escape(err_msg, '"') .. '"')
    vim.cmd('echomsg "Please check your config for correctness"')
    vim.cmd('echohl None')
  end
end

-- Runtimepath customization

-- Pre-load configuration
-- Post-load configuration
-- Conditional loads
-- Load plugins in order defined by `after`
END

function! s:load(names, cause) abort
  call luaeval('_packer_load_wrapper(_A[1], _A[2])', [a:names, a:cause])
endfunction


" Command lazy-loads
command! -nargs=* -range -bang -complete=file WhichKey call s:load(['vim-which-key'], { "cmd": "WhichKey", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file WhichKeyVisual call s:load(['vim-which-key'], { "cmd": "WhichKeyVisual", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType c ++once call s:load(['opengl.vim'], { "ft": "c" })
  au FileType wiki ++once call s:load(['markdown-preview.nvim', 'vim-markdown-toc', 'thesaurus_query.vim'], { "ft": "wiki" })
  au FileType glsl ++once call s:load(['vim-glsl'], { "ft": "glsl" })
  au FileType cpp ++once call s:load(['opengl.vim'], { "ft": "cpp" })
  au FileType python ++once call s:load(['indentLine'], { "ft": "python" })
  au FileType markdown ++once call s:load(['markdown-preview.nvim', 'vim-markdown-toc', 'thesaurus_query.vim'], { "ft": "markdown" })
  au FileType text ++once call s:load(['markdown-preview.nvim', 'thesaurus_query.vim'], { "ft": "text" })
  " Event lazy-loads
  " Function lazy-loads
augroup END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
