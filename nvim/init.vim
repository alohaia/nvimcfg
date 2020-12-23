
call plug#begin("~/.config/nvim/plugins/")

Plug 'SirVer/ultisnips'            " improved vim-snipmate

"============================\ ultisnips /=============================
" Plug 'alohaia/vim-snippets'               " snips for snipmate and ultisnips
""An array of relative directory names OR an array with a single absolute path.
" Defines how the edit window is opened.
let g:UltiSnipsEditSplit= 'context'
""Enable snippmate snippets (dirs named 'snippets' under dirs in &runtimepath)
" let g:UltiSnipsEnableSnipMate = 1
let g:UltiSnipsRemoveSelectModeMappings = 0
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
" 在代码段内跳转
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetsDir=[$HOME."/.config/nvim/Ultisnips"]
" let g:UltiSnipsSnippetDirectories=["Ultisnips"]
""Add c snippets for cpp files. (改为在 snippets 文件中使用 extends 关键字)
" au FileType cpp UltiSnipsAddFiletypes cpp.c
" autocmd! User UltiSnipsEnterFirstSnippet
" autocmd User UltiSnipsEnterFirstSnippet echomsg 'snippet expanded'
" autocmd! User UltiSnipsExitLastSnippet
" autocmd User UltiSnipsExitLastSnippet echomsg 'expanding finished'


call plug#end()
