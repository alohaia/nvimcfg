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
local package_path_str = "/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/aloha/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, err = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(err)
  end
end

_G.packer_plugins = {
  ["agit.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/agit.vim"
  },
  ["any-jump.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/any-jump.vim"
  },
  ["asyncrun.extra"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/asyncrun.extra"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/asyncrun.vim"
  },
  ["asynctasks.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/asynctasks.vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/auto-pairs"
  },
  ["clever-f.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/clever-f.vim"
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
  ["far.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/far.vim"
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
    loaded = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/indentLine"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/markdown-preview.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/nerdcommenter"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/nvim-web-devicons"
  },
  ["onedark.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/onedark.vim"
  },
  ["opengl.vim"] = {
    loaded = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/opengl.vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/packer.nvim"
  },
  rainbow = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/rainbow"
  },
  ["thesaurus_query.vim"] = {
    loaded = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/thesaurus_query.vim"
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
  ["vim-colors-solarized"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-colors-solarized"
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
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-illuminate"
  },
  ["vim-markdown-toc"] = {
    loaded = false,
    path = "/home/aloha/.config/nvim/pack/packer/opt/vim-markdown-toc"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vim-repeat"
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
  vimtex = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vimtex"
  },
  vimwiki = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vimwiki"
  },
  ["vista.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/vista.vim"
  },
  ["zeavim.vim"] = {
    loaded = true,
    path = "/home/aloha/.config/nvim/pack/packer/start/zeavim.vim"
  }
}

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType c ++once lua require("packer.load")({'opengl.vim'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'indentLine'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType wiki ++once lua require("packer.load")({'vim-markdown-toc', 'thesaurus_query.vim', 'markdown-preview.nvim'}, { ft = "wiki" }, _G.packer_plugins)]]
vim.cmd [[au FileType text ++once lua require("packer.load")({'thesaurus_query.vim', 'markdown-preview.nvim'}, { ft = "text" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown-toc', 'thesaurus_query.vim', 'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'opengl.vim'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
