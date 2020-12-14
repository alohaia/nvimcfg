if exists('g:loaded_nvim_tools') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_nvim_tools = 1
