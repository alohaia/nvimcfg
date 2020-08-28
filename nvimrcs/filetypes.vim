"+-----------------------------------------------------------------------+
"¦ Maintainer:   Amir Salihefendic — @amix3k, aloha                      ¦
"¦                                                                       ¦
"¦ License:        MIT                                                   ¦
"+-----------------------------------------------------------------------+

""""""""""""""""""""""""""""""
" => 创建文件头
""""""""""""""""""""""""""""""
" autocmd BufNewFile *.py,*.tex exec ":call SetTitle()"
" func! SetTitle()
"     if &filetype == 'python'    " python
"         call setline(1,"#!/usr/bin/env python3")
"         call append(line("."),"# -*- coding:UTF-8 -*-")
"         call append(line(".")+1,"##########################################################################")
"         call append(line(".")+2, "# File Name: ".expand("%"))
"         call append(line(".")+3, "# Author: aloha")
"         call append(line(".")+4, "# Created Time: ".strftime("%c"))
"         call append(line(".")+5, "##########################################################################")
"     endif
"     if &filetype == 'plaintex'  " LaTex
"         call setline(1,"% -*- coding:UTF-8 -*-")
"         call append(line("."),"%#########################################################################")
"         call append(line(".")+1, "% File Name: ".expand("%"))
"         call append(line(".")+2, "% Author: aloha")
"         call append(line(".")+3, "% Created Time: ".strftime("%c"))
"         call append(line(".")+4, "%#########################################################################")
"     endif
"     if &filetype == 'cpp' || &filetype == 'c'
"         call setline(1,"% -*- coding:UTF-8 -*-")
"         call append(line("."),"%#########################################################################")
"         call append(line(".")+1, "% File Name: ".expand("%"))
"         call append(line(".")+2, "% Author: aloha")
"         call append(line(".")+3, "% Created Time: ".strftime("%c"))
"         call append(line(".")+4, "%#########################################################################")
"     normal Go
" endfunc

""""""""""""""""""""""""""""""
" => C/C++ section
""""""""""""""""""""""""""""""
au FileType c,cpp set foldmethod=syntax

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
"au FileType python syn keyword pythonDecorator True None False self
au bufenter python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

" au FileType python map <buffer> F :set foldmethod=indent<cr>
au Filetype python set foldmethod=indent

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <C-t> $log();<esc>hi
au FileType javascript imap <C-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f // --- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => CoffeeScript section
"""""""""""""""""""""""""""""""
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])


""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX') 
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color 
    endif
endif


""""""""""""""""""""""""""""""
" => Twig section
""""""""""""""""""""""""""""""
autocmd BufRead *.twig set syntax=html filetype=html


""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""
function s:markdown_settings()
    setlocal spell
    setlocal spelllang = en_US
    inoremap<buffer> <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
endfunction
autocmd BufReadPre markdown call s:tex_settings()


""""""""""""""""""""""""""""""
" => LaTex
""""""""""""""""""""""""""""""
function s:tex_settings()
    setlocal spell
    setlocal spelllang = en_US
    inoremap<buffer> <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
endfunction
autocmd BufReadPre tex call s:tex_settings()
