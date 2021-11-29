command PackInstall lua aloha.packer:download()
command PackUpdate  lua aloha.packer:download('update')
command PackClean   lua aloha.packer:clean()
command PackSync    lua aloha.packer:clean(); aloha.packer:download('update')

fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
autocmd BufWritePre *.c,*.cpp,*.h,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

function! BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif
    if bufnr("%") == l:currentBufNum
        new
    endif
    if buflisted(l:currentBufNum)
        exe "bdelete! ".l:currentBufNum
    endif
endfunction

fun! DeleteAllBuffersInWindow(option)
    let s:curWinNr = winnr()
    if winbufnr(s:curWinNr) == 1
        ret
    endif
    let s:curBufNr = bufnr("%")
    exe "bn"
    let s:nextBufNr = bufnr("%")
    while s:nextBufNr != s:curBufNr
        exe "bn"
        if a:option == 'force'
            exe "bdel! ".s:nextBufNr
        else
            exe "bdel ".s:nextBufNr
        endif
        let s:nextBufNr = bufnr("%")
    endwhile
endfun

nnoremap <leader>bd <Cmd>call g:BufcloseCloseIt()<cr>
nnoremap <leader>bo <Cmd>call DeleteAllBuffersInWindow('noforce')<cr>
nnoremap <leader>BO <Cmd>call DeleteAllBuffersInWindow('force')<cr>

function! Ocr()
    let l:str = system('ocr')
    " remove \n
    let l:str = join(split(l:str), ' ')

    let l:frgs = matchlist(l:str, '\(.*[\u4e00-\u9fa5]\+\) \([\u4e00-\u9fa5]\+.*\)')[1:2]
    while l:frgs != []
        let l:str = join(frgs, '')
        " echo l:str
        let l:frgs = matchlist(l:str, '\(.*[\u4e00-\u9fa5]\+\) \([\u4e00-\u9fa5]\+.*\)')[1:2]
    endwhile

    return l:str
endfunction

autocmd FileType cpp,c setlocal path+=./include
autocmd FileType text,markdown setlocal wrap spell
autocmd FileType html,yaml,toml,vue setlocal tabstop=2 shiftwidth=2

"-----------------------------------\ vim-table-mode /----------------------------------
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}

cabbrev <expr> %% expand('%:p')

autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
