""======================= environment variables ==========================
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

if has('nvim')
    let g:config_file_path = expand('$HOME/.config/nvim/nvimrcs/')
    let g:main_runtimepath = expand('$HOME/.config/nvim/')
else
    let g:config_file_path = expand('$HOME/vimrcs/')
    let g:main_runtimepath = expand('$HOME/.vim/')
endif


""======================= Automatically Install ==========================
if glob(g:main_runtimepath."autoload/plug.vim") == ''
    if glob(g:main_runtimepath."plugins/vim-plug/plug.vim") == ''
        execute("!git clone https://github.com/junegunn/vim-plug.git ".g:main_runtimepath."plugins/vim-plug/")
    endif
    silent execute("!ln -s ~/.config/nvim/plugins/vim-plug/plug.vim ".g:main_runtimepath."autoload/plug.vim")
    autocmd VimEnter * PlugUpdate | source $MYVIMRC
endif


"============================ Config files ===============================
execute("source ".g:config_file_path."functions.vim")
execute("source ".g:config_file_path."basic.vim")
execute("source ".g:config_file_path."filetypes.vim")
execute("source ".g:config_file_path."plugins_config.vim")

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
" if &diffopt !~# 'internal'
"   set diffexpr=MyDiff()
" endif
" function MyDiff()
"   let opt = '-a --binary '
"   if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"   if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"   let arg1 = v:fname_in
"   if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"   let arg1 = substitute(arg1, '!', '\!', 'g')
"   let arg2 = v:fname_new
"   if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"   let arg2 = substitute(arg2, '!', '\!', 'g')
"   let arg3 = v:fname_out
"   if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"   let arg3 = substitute(arg3, '!', '\!', 'g')
"   if  =~ ' '
"     if &sh =~ '\<cmd'
"       if empty(&shellxquote)
"         let l:shxq_sav = ''
"         set shellxquote&
"       endif
"       let cmd = '"' .  . '\diff"'
"     else
"       let cmd = substitute(, ' ', '" ', '') . '\diff"'
"     endif
"   else
"     let cmd =  . '\diff'
"   endif
"   let cmd = substitute(cmd, '!', '\!', 'g')
"   silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
"   if exists('l:shxq_sav')
"     let &shellxquote=l:shxq_sav
"   endif
" endfunction
