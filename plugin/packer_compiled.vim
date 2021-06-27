" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time("Luarocks path setup", true)
local package_path_str = "/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time("Luarocks path setup", false)
time("try_loadstring definition", true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

time("try_loadstring definition", false)
time("Defining packer_plugins", true)
_G.packer_plugins = {
  ["agit.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/agit.vim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/asyncrun.vim"
  },
  ["asynctasks.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/asynctasks.vim"
  },
  ["bullets.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/bullets.vim"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/coc.nvim"
  },
  ["defx-git"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/defx-git"
  },
  ["defx-icons"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/defx-icons"
  },
  ["defx.nvim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/defx.nvim"
  },
  ["fzf-floaterm"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/fzf-floaterm"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/fzf.vim"
  },
  indentLine = {
    after_files = { "/home/aloha/.config/nvim/pack/packer/opt/indentLine/after/plugin/indentLine.vim" },
    loaded = false,
    needs_bufread = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/indentLine"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/nerdcommenter"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/nvim-treesitter"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/onedark.vim"
  },
  ["opengl.vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/opengl.vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/packer.nvim"
  },
  rainbow = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/rainbow"
  },
  ["thesaurus_query.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/thesaurus_query.vim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/ultisnips"
  },
  undotree = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/undotree"
  },
  ["vim-after-object"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-after-object"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-airline"
  },
  ["vim-capslock"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-capslock"
  },
  ["vim-choosewin"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-choosewin"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-devicons"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-easymotion"
  },
  ["vim-endwise"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-endwise"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-fugitive"
  },
  ["vim-glsl"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-glsl"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-hexokinase"
  },
  ["vim-hexowiki"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-hexowiki"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-illuminate"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-repeat"
  },
  ["vim-signify"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-signify"
  },
  ["vim-startify"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-startify"
  },
  ["vim-subversive"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-subversive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-surround"
  },
  ["vim-table-mode"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-table-mode"
  },
  ["vim-translator"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-translator"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-visual-multi"
  },
  ["vim-yoink"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-yoink"
  },
  ["vimdoc-cn"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vimdoc-cn"
  },
  vimtex = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vimtex"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vista.vim"
  }
}

time("Defining packer_plugins", false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time("Defining lazy-load filetype autocommands", true)
vim.cmd [[au FileType c ++once lua require("packer.load")({'opengl.vim'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'opengl.vim'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType text ++once lua require("packer.load")({'vim-table-mode', 'bullets.vim'}, { ft = "text" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-table-mode', 'bullets.vim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'indentLine'}, { ft = "python" }, _G.packer_plugins)]]
time("Defining lazy-load filetype autocommands", false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
