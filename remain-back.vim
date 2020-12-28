colorscheme onedark

let s:transparent_background = 0

"============================= Switch themes =============================
function! s:colorcolumn_bg_backup()
    if !exists('g:hi_colorcolumn_bg')
        let l:hi = split(execute('silent hi ColorColumn', ''))[-2:-1]
        let g:hi_colorcolumn_bg = join(l:hi, ' ')
    endif
    return g:hi_colorcolumn_bg
endfunction
au ColorScheme * call s:colorcolumn_bg_backup()

function! g:SwitchTheme(choice)
    set termguicolors     " enable true colors support
    if a:choice == 0
        colorscheme solarized8_light
        let g:airline_theme = 'solarized'
    elseif a:choice == 1
        colorscheme iceberg
        ""angr atomic
        let g:airline_theme = 'tomorrow'
    elseif a:choice == 2
        colorscheme molokai
        " colorscheme sublimemonokai
        let g:airline_theme = 'airlineish'
    elseif a:choice == 3
        au VimEnter * colorscheme onedark
        let g:airline_theme = 'onedark'
    elseif a:choice == 4
        colorscheme ayu
        let g:airline_theme = 'ayu'
    elseif a:choice == 5
        colorscheme nord
        let g:airline_theme = 'nord'
    elseif a:choice == 6
        au VimEnter * colorscheme dracula
        let g:airline_theme = 'dracula'
    endif
endfunction

function! g:ThemeByTime(...)
    if a:0 != 0
        let l:time = a:000[0]
    else
        let l:time = system('date +%H')
    endif
    if 6 <= l:time && l:time < 18
        call g:SwitchTheme(0)
    else
        call g:SwitchTheme(2)
    endif
endfunction

"======================== Open a terminal smartly ========================
function! g:OpenTerminalSmartly()
    if winwidth(0)*1.0/winheight(0) > 3
        vsplit | terminal
    else
        split  | terminal
    endif
endfunction

"========================= Backup Normal highlighting ====================
""Do NOT call this function in this file.
function! s:normal_color_backup()
    if !exists('g:hi_normal')
        let l:hi_normal = split(execute('silent hi Normal', ''))[2:-1]
        let g:hi_normal = join(l:hi_normal, ' ')
    endif
    return g:hi_normal
endfunction
au ColorScheme * call s:normal_color_backup()

"========================= Transparent background ========================
""pass 0 to use transparent background and store current bg color in a file.
""pass 1 to use color specified by the file.
function! g:TransparentBg(option)
    ""检查输入
    execute a:option != 0 && a:option != 1 ?
                \ 'echoerr "Argument error in function TransparentBg" | return -1'
                \ : ''
    ""检查备份变量是否存在
    if !exists('g:hi_normal')
        call s:normal_color_backup()
    elseif !exists('g:hi_colorcolumn_bg')
        call s:colorcolumn_bg_backup()
    endif
    ""防止重复执行
    if !exists('s:trans_back_color')
        let s:trans_back_color = -1
    endif
    ""根据选项设置背景
    if a:option == 1
        ""设置透明背景
        hi Normal ctermbg=NONE guibg=NONE
        hi ColorColumn ctermbg=NONE guibg=NONE
        let s:trans_back_color = 1
        " ================ Make some adjustments here. =====================
        hi CursorLineNr               ctermbg=NONE guibg=NONE ctermfg=208 guifg=#FD971F
        hi LineNr                     ctermbg=NONE guibg=NONE
        hi SignColumn                 ctermbg=NONE guibg=NONE
        hi SignifySignAdd             ctermbg=NONE guibg=NONE
        hi SignifySignDelete          ctermbg=NONE guibg=NONE
        hi SignifySignDeleteFirstLine ctermbg=NONE guibg=NONE
        hi SignifySignChange          ctermbg=NONE guibg=NONE
        hi VertSplit                  ctermbg=NONE guibg=NONE ctermfg=black guifg=black gui=NONE cterm=NONE
        " hi cppRainbow_lv1_r0 guifg=#8700ff
    elseif a:option ==0 && s:trans_back_color != 0
        exe 'hi Normal '.g:hi_normal
        exe 'hi ColorColumn '.g:hi_colorcolumn_bg
        let s:trans_back_color =0
        " ================ Make some adjustments here. =====================
        exe 'hi CursorLineNr               '.g:hi_colorcolumn_bg.' ctermfg=208 guifg=#FD971F'
        exe 'hi LineNr                     '.g:hi_colorcolumn_bg
        exe 'hi SignColumn                 '.g:hi_colorcolumn_bg
        exe 'hi SignifySignAdd             '.g:hi_colorcolumn_bg
        exe 'hi SignifySignDelete          '.g:hi_colorcolumn_bg
        exe 'hi SignifySignDeleteFirstLine '.g:hi_colorcolumn_bg
        exe 'hi SignifySignChange          '.g:hi_colorcolumn_bg
        exe 'hi VertSplit                  '.g:hi_colorcolumn_bg.' ctermfg=black guifg=black gui=NONE cterm=NONE'
        " hi cppRainbow_lv1_r0 guifg=#8700ff
    endif
endfunction

"================================== HasPaste =============================
" function! HasPaste()
"     if &paste
"         return 'PASTE MODE  '
"     endif
"     return ''
" endfunction

"==== Delete trailing white space on save, useful for some filetypes =====
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

"============= Don't close window, when deleting a buffer ================
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

""Delete all buffers except the one in current window.
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

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"================================ 窗口操作 ===============================
func! FullScreen()
     " GUI is running or is about to start.
    if (has("win16") || has("win32")) && has("gui_running")
        simalt ~x
    elseif has('linux')
        "if exists("+lines")
        "    set lines=9999
        "endif
        "if exists("+columns")
        "    set columns=9999
        "endif
    endif
    let g:Full_Screen = 1
endfunc

func! ShrinkScreen()
    if has("win32") && has("gui_running")
        set lines=35 columns=100
    elseif has('linux')
        "set lines=25 columns=75
    endif
    let g:Full_Screen = 0
endfunc

func! ToggleFullScreen()
    if g:Full_Screen == 0
        call FullScreen()
    else
        call ShrinkScreen()
    endif
endfunc

function! BigWindow()
    call FullScreen()
    NERDTree
    TagbarOpen
endfunction

function! SmallWindow()
    call ShrinkScreen()
    " vim-plug 中设置 NERDTree 不会自动启动
    if exists("g:NERDTree")
        NERDTreeClose
    endif
    TagbarClose
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"Author : 路永磊
"plugin : awheel_fcitx.vim
"Date   : 2020-05-29
"Usage  : 解决vim使用中文输入法时的干扰问题
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:chinese_enable = 2                                     "若当前系统为中文输入法,则获取的输入法状态值为 2
let s:english_enable = 1                                     "若当前系统为英文输入法,则获取的输入法状态值为 1
let s:get_fcitx_language_status = "fcitx-remote"             "获取当前输入法的状态值
let s:set_fcitx_chinese         = "fcitx-remote -o"          "把输入法设置为 中文
let s:set_fcitx_english         = "fcitx-remote -c"          "把输入法设置为 英文

let s:start_language_status = system(s:set_fcitx_english)    "vim启动时,默认把输入法设置为英文



"此处可以根据编辑的文件后缀名来做更改
let g:saved_insert_mode_language_status = s:english_enable                     "初始设置 插入模式 输入法为英文
autocmd BufNewFile,BufRead *.txt,*.text,*.md,*.wiki,[Rr][Ee][Aa][Dd][Mm][Ee] 
            \let g:saved_insert_mode_language_status = s:chinese_enable        "在编辑*.txt,*.text文件格式的时候



"当退出 插入模式 时,会把输入法设置为英文 
function! s:fcitx_2_english()
    let s:exit_insert_status = system(s:get_fcitx_language_status)      "检查退出 插入模式 时,输入法的状态
    if s:exit_insert_status != s:english_enable                         "如果退出 插入模式 时,输入法不是英文
        let l:temp = system(s:set_fcitx_english)                        "将输入法设置为英文
    endif
    let g:saved_insert_mode_language_status = s:exit_insert_status      "保存退出 插入模式 时的输入法状态 
endfunction

"当进入 插入模式 时,输入法会自动选择语言为上一次插入模式使用的语言
function! s:fcitx_enter_insert_mode()
    let s:enter_insert_status = system(s:get_fcitx_language_status)     "获取进入 插入模式 时,输入法的状态
    if s:enter_insert_status != g:saved_insert_mode_language_status     "如果当前输入法语言和上一次退出插入模式时的语言不一样
        if g:saved_insert_mode_language_status == s:chinese_enable      "改变输入法当前语言为上一次退出插入模式时的语言
            let l:temp = system(s:set_fcitx_chinese)
        else
            let l:temp = system(s:set_fcitx_english)
        endif
    endif
endfunction


"退出插入模式调用的函数
autocmd InsertLeave * call s:fcitx_2_english()

"进入插入模式调用的函数
autocmd InsertEnter * call s:fcitx_enter_insert_mode()


"================================ 移动模式 ===============================
function! g:SwitchMotionMod()
    if !exists("g:motionMod") || g:motionMod == 1
        noremap <S-M-j> 5<C-e>
        noremap <S-M-k> 5<C-y>
        if exists('g:motionMod')
            echo 'Changed to Free mod.'
        endif
        let g:motionMod = 0
    elseif g:motionMod == 0
        noremap <S-M-j> 5jzz
        noremap <S-M-k> 5kzz
        echo 'Changed to Fixed mod.'
        let g:motionMod = 1
    endif
endfunction


""Get SID
function! g:GetSID()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

"======================= Choose Window with Filter =======================
function! ChooseWin(...)
    let l:wins = range(1,winnr('$'))
    if a:0 == 0
        let l:available_windows = filter(l:wins, 'index(s:choosewin_ignore_filetypes, getbufvar(winbufnr(v:val), "&filetype")) == -1')
    else
        let l:available_windows = filter(l:wins, 'index(a:000[0], getbufvar(winbufnr(v:val), "&filetype")) == -1')
    endif
    return choosewin#start(l:available_windows, { 'auto_choose': 1, 'hook_enable': 0 })
endfunction

"================================ Viminal ================================
function! OpenAsTerminal()
    au VimEnter * call TransparentBg(1)
    terminal
    normal a
endfunction

au VimEnter * call g:TransparentBg(s:transparent_background)
""""""""""""""""""""""""""""""
" => C/C++ section
""""""""""""""""""""""""""""""
au FileType c,cpp set path+=./include

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
" let python_highlight_all = 1

" au BufNewFile,BufRead *.jinja set syntax=htmljinja
" au BufNewFile,BufRead *.mako set ft=mako

" au FileType python map <buffer> F :set foldmethod=indent<cr>

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
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])

""""""""""""""""""""""""""""""
" => Twig section
""""""""""""""""""""""""""""""
autocmd BufRead *.twig set syntax=html filetype=html


""""""""""""""""""""""""""""""
" => Markdown
""""""""""""""""""""""""""""""
function s:markdown_settings()
    setlocal spell
    setlocal spelllang=en_us,cjk
    inoremap<buffer> <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
endfunction
autocmd BufReadPre *.md,*.vimwiki call s:markdown_settings()

au FileType wiki,markdown
""""""""""""""""""""""""""""""
" => LaTex
""""""""""""""""""""""""""""""
function s:tex_settings()
    setlocal spell
    setlocal spelllang=en_us,cjk
    inoremap<buffer> <C-s> <c-g>u<Esc>[s1z=`]a<c-g>u
endfunction
autocmd BufReadPre *.tex call s:tex_settings()

""""""""""""""""""""""""""""""
" => GLSL
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.vs setfiletype glsl
au BufRead,BufNewFile *.fs setfiletype glsl

"+--------------------------------------------------------------------------+" 
"|                              Helper Commands                             |"
"+--------------------------------------------------------------------------+"
""Startify:
command! Hstartify echo
            \"=== :h startify-usage to see the doc ===\n".
            \"  e creates an empty buffer\n".
            \"  i creates an empty buffer and jumps into insert mode\n".
            \"  q quits either the buffer or, if there is no other listed buffer left, Vim itself\n".
            \"--- open multiple buffers at once ---\n".
            \"  b (open in same window)\n".
            \"  s (open in split)\n".
            \"  v (open in vertical split)\n".
            \"  t (open in tab)\n".
            \"  Afterwards execute these actions via <cr>\n"
            \"  Try typing B024".
            \"--- sessions ---\n".
            \"  :SLoad       load a session    \n".
            \"  :SSave[!]    save a session    \n".
            \"  :SDelete[!]  delete a session  \n".
            \"  :SClose      close a session   "

""Undotree:
command! Hundotree echo
            \"=== \<leader\>ut to start, ? to see help. Addition: ===\n".
            \"  u     _ NextState\n".
            \"  e     _ PreviousState\n".
            \"  U     _ NextState\n".
            \"  E     _ PreviousState"

""Vista:
command! Hvista echo
            \"=== \<leader\>vt to start, ,T to use finder. ===\n".
            \"  Enter       - jump to the tag under the cursor.\n".
            \"  p           - preview the tag under the context via the floating window if it's avaliable.\n".
            \"  s           - sort the symbol alphabetically or the location they are declared.\n".
            \"  q           - close the vista window."

" ""Defx:
command! Hdefx echo
            \"===================================== \<leader\>df to start ======================================\n".
            \"------------- Open & toggle tree -------------|---------------- Change directory ---------------\n".
            \"  \<CR\>              open in choosen window    |  cd                     change vim cwd          \n".
            \"  l                 cd or drop                |  %                      cd to cwd               \n".
            \"  o                 toggle tree or drop       |  ~                      cd home                 \n".
            \"  t                 drop in new tab           |  \<BS\>                   cd ..                   \n".
            \"  s                 open in botright split    |  h                      cd ..                   \n".
            \"  v                 open in botright vsplit   |  u                      cd ..                   \n".
            \"                                              |  2u                     cd ../..                \n".
            \"---------- Defx's buffer management ----------|  3u                     cd ../../..             \n".
            \"  q/\<Esc\>           quit                      |  4u                     cd ../../../..          \n".
            \"  \<C-r\>             redraw                    |                                                 \n".
            \"  \<C-g\>             print                     |------------------- Selection -------------------\n".
            \"                                              |  s                      toggle select           \n".
            \"------------- File/dir management ------------|  \<Space\>                toggle select           \n".
            \"  c                 copy                      |  \<C-j\>                  toggle select & j       \n".
            \"  x                 move                      |  \<C-k\>                  toggle select & k       \n".
            \"  m                 move                      |  \<C-a\>                  toggle select all       \n".
            \"  p                 paste                     |  S                      sort by time            \n".
            \"  r                 rename                    |  C                      toggle columns          \n".
            \"  dd(abandoned)     remove to trash           |                                                 \n".
            \"  n                 new file                  |-------------------- Commands--------------------\n".
            \"  N                 new directory             |  !                      execute command         \n".
            \"  M                 new multiple files        |  ex                     execute current file    \n".
            \"                                              |                                                 \n".
            \"-------------------- Jump --------------------|--------------- Special operations---------------\n".
            \"  \<                 jump dirty previous       |  P                      preview                 \n".
            \"  \>                 jump dirty next           |  H                      toggle_ignored_files    \n".
            \"  b                 leave defx window         |  yy                     yank_path               \n".
            \"                                              |  .                      repeat                  \n"

""Soda:
command! Hsuda vert h suda-usage

""Fzf_vim:
command! Hfzf vert h fzf-vim-commands

""Far:
command! Hfar vert h far-usage

""VisualMulti:
command! Hvisualmulti echo "Use '[n]vim -Nu path/to/visual-multi/tutorialrc' for quick start."

""Vimspector:
command! Hvimspector echo
            \"  :Launch   Launch\n".
            \"  :Continue Continue\n".
            \"  :Pause    Pause\n".
            \"  :Stop     Stop\n".
            \"  :Restart  Restart\n".
            \"  \<F5\>      StepOver\n".
            \"  \<F6\>      StepInto\n".
            \"  \<F7\>      StepOut\n".
            \"  \<F8\>      ToggleBreakpoint\n".
            \"  \<F9\>      ToggleConditionalBreakpoint\n".
            \"  \<F10\>     AddFunctionBreakpoint\n".
            \"  Type :call vimspe\<tab\> to see more functions."

"============================\ vim-which-key /=============================
hi WhichKeyBg ctermfg=252 ctermbg=233 guifg=#F8F8F2 guibg=#1B1D1E
" highlight default link WhichKey          Function
" highlight default link WhichKeySeperator DiffAdded
" highlight default link WhichKeyGroup     Keyword
" highlight default link WhichKeyDesc      Identifier
highlight default link WhichKeyFloating  WhichKeyBg

"#########################################################################
"############################\ User Interface /###########################
"#########################################################################

"==============================\ undotree /===============================
""Custom mappings.
function g:Undotree_CustomMap()
    nnoremap <buffer> u <plug>UndotreeNextState
    nnoremap <buffer> e <plug>UndotreePreviousState
    nnoremap <buffer> U 5<plug>UndotreeNextState
    nnoremap <buffer> E 5<plug>UndotreePreviousState
endfunc

"===============================\ rnvimr /================================
highlight default link RnvimrNormal NormalFloat
highlight default link RnvimrCurses Normal

""============================\ defx.nvim /=============================
function! Root(path) abort
      return fnamemodify(a:path, ':t')
endfunction

" defx-icons plugin
" Events
" ---
augroup user_plugin_defx
    autocmd!
    " Define defx window mappings
    autocmd FileType defx call <SID>defx_mappings()
    " Delete defx if it's the only buffer left in the window
    autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdel | endif
    " Move focus to the next window if current buffer is defx
    autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif
augroup END
" Internal functions
" ---
function! s:SID_PREFIX() abort
    return matchstr(expand('<sfile>'),
    \ '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
let g:sid = s:SID_PREFIX()

function! s:jump_dirty(dir) abort
    " Jump to the next position with defx-git dirty symbols
    let l:icons = get(g:, 'defx_git_indicators', {})
    let l:icons_pattern = join(values(l:icons), '\|')
    if ! empty(l:icons_pattern)
        let l:direction = a:dir > 0 ? 'w' : 'bw'
        return search(printf('\(%s\)', l:icons_pattern), l:direction)
    endif
endfunction

function! s:defx_toggle_tree_or_drop() abort
    " Open current file, or toggle directory expand/collapse
    if defx#is_directory()
        return defx#do_action('open_or_close_tree')
    endif
    return defx#do_action('multi', ['drop'])
endfunction

function! s:defx_cd_or_drop(context) abort
    " Open current file, or toggle directory expand/collapse
    if defx#is_directory()
        " echo a:context
        return defx#call_action('cd', a:context.targets[0])
    endif
    return defx#call_action('multi', ['drop'])
endfunction

function! s:defx_choosewin(context) abort
    " let l:winnrs = find_winnrs() " Modified for slide
    if defx#is_directory()
        " echomsg string(a:context)
        " return
        return defx#call_action('cd', a:context.targets)
    endif
    for filename in a:context.targets
        call ChooseWin(['defx'])
        execute 'edit '.filename
    endfor
endfunction

function s:defx_execute(context) abort
    let l:name = 'DefsExec'
    let l:bufnr = floaterm#terminal#get_bufnr(l:name)
    if l:bufnr == -1
        execute('FloatermNew --name='.l:name)
        execute('FloatermToggle '.l:name)
        execute('FloatermSend ' . a:context.targets[0])
        execute('FloatermToggle '.l:name)
    else
        execute('FloatermSend --name=' . l:name . ' ' . a:context.targets[0])
        execute('FloatermToggle '.l:name)
    endif
endfunction

function! s:defx_mappings() abort
    ""Defx window keyboard mappings
    setlocal signcolumn=no expandtab
    ""Moving Curaor
    nnoremap <silent><buffer><expr> j                 line('.') == line('$') ? 'go' : 'j'
    nnoremap <silent><buffer><expr> k                 line('.') == 1 ? 'G<home>' : 'k'
    nnoremap <silent><buffer><expr> J                 line('.') == line('$') ? 'go' : '5j'
    nnoremap <silent><buffer><expr> K                 line('.') == 1 ? 'G<home>' : '5k'

    ""Open & toggle tree
    nnoremap <silent><buffer><expr> <CR>              defx#do_action('call', g:sid.'defx_choosewin')
    nnoremap <silent><buffer><expr> l                 defx#do_action('call', g:sid.'defx_cd_or_drop')
    nnoremap <silent><buffer><expr> o                 <sid>defx_toggle_tree_or_drop()
    nnoremap <silent><buffer><expr> t                 defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
    nnoremap <silent><buffer><expr> s                 defx#do_action('open', 'botright split')
    nnoremap <silent><buffer><expr> v                 defx#do_action('open', 'botright vsplit')

    ""Defx's buffer management
    nnoremap <silent><buffer><expr> q                 defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Esc>             defx#do_action('quit')
    " nnoremap <silent><buffer><expr> se                defx#do_action('save_session')
    " nnoremap <silent><buffer><expr> le                defx#do_action('load_session')
    nnoremap <silent><buffer><expr> <C-r>             defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>             defx#do_action('print')

    ""File/dir management
    nnoremap <silent><buffer><expr><nowait> c         defx#do_action('copy')
    nnoremap <silent><buffer><expr><nowait> x         defx#do_action('move')
    nnoremap <silent><buffer><expr><nowait> m         defx#do_action('move')
    nnoremap <silent><buffer><expr><nowait> p         defx#do_action('paste')
    nnoremap <silent><buffer><expr><nowait> r         defx#do_action('rename')
    " nnoremap <silent><buffer><expr> dd                defx#do_action('remove_trash')
    nnoremap <silent><buffer><expr> n                 defx#do_action('new_file')
    nnoremap <silent><buffer><expr> N                 defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> M                 defx#do_action('new_multiple_files')

    ""Jump
    nnoremap <silent><buffer>  <                      :<C-u>call <SID>jump_dirty(-1)<CR>
    nnoremap <silent><buffer>  >                      :<C-u>call <SID>jump_dirty(1)<CR>
    nnoremap <silent><buffer><expr> b                 winnr('$') != 1 ? ':<C-u>wincmd w<CR>'
                                                          \ : ':<C-u> Defx -buffer-name=temp -split=vertical<CR>'

    ""Change directory
    nnoremap <silent><buffer><expr> cd                defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr><nowait> %         defx#do_action('cd', getcwd())
    nnoremap <silent><buffer><expr> ~                 defx#async_action('cd')
    nnoremap <silent><buffer><expr> <BS>              defx#async_action('cd', ['..'])
    nnoremap <silent><buffer><expr> h                 defx#async_action('cd', ['..'])
    nnoremap <silent><buffer><expr> u                 defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> 2u                defx#do_action('cd', ['../..'])
    nnoremap <silent><buffer><expr> 3u                defx#do_action('cd', ['../../..'])
    nnoremap <silent><buffer><expr> 4u                defx#do_action('cd', ['../../../..'])

    ""Selection
    nnoremap <silent><buffer><expr><nowait> s         defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr><nowait> <Space>   defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> <C-j>             defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> <C-k>             defx#do_action('toggle_select') . 'k'
    nnoremap <silent><buffer><expr> <C-a>             defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> S                 defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> C                 defx#do_action('toggle_columns', 'mark:indent:icon:filename')

    ""Commands
    nnoremap <silent><buffer><expr> !                 defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> ex                defx#do_action('call', g:sid.'defx_execute')

    ""Special operations
    nnoremap <silent><buffer><expr> P                 defx#do_action('preview')
    nnoremap <silent><buffer><expr> H                 defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> yy                defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .                 defx#do_action('repeat')
endfunction

"============================\ vista.vim /=============================
autocmd FileType vista,vista_kind nnoremap <buffer> <silent> f :<c-u>call vista#finder#fzf#Run()<CR>
let g:vista#renderer#icons = {
            \   "function": "\uf794",
            \   "variable": "\uf71b",
            \  }

"============================\ vim-devicons /=============================

"============================\ vim-airline /=============================
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
""Enable tabline
let g:airline#extensions#tabline#enabled=1    "Smarter tab line: 显示窗口tab和buffers
""tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'default'  "formater
""设置分隔符 https://github.com/ryanoasis/powerline-extra-symbols
let g:airline#extensions#tabline#left_sep = '┆'
let g:airline#extensions#tabline#left_alt_sep = '┆'
let g:airline#extensions#tabline#right_sep = '┆'
let g:airline#extensions#tabline#right_alt_sep = '┆'
let g:airline_left_sep = '┆'
let g:airline_left_alt_sep = '┆'
let g:airline_right_sep = '┆'
let g:airline_right_alt_sep = '┆'
" let g:airline#extensions#tabline#left_sep = "\ue0b4"
" let g:airline#extensions#tabline#left_alt_sep = "\ue0b5"
" let g:airline#extensions#tabline#right_sep = "\ue0b6"
" let g:airline#extensions#tabline#right_alt_sep = "\ue0b7"
" let g:airline_left_sep = "\ue0b4"
" let g:airline_left_alt_sep = "\ue0b5"
" let g:airline_right_sep = "\ue0b6"
" let g:airline_right_alt_sep = "\ue0b7"
""配置其他字符
let g:airline_symbols.crypt = ''
let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '㏑'
let g:airline_symbols.maxlinenr = '¶'
let g:airline_symbols.branch = '' "
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = '∥ '
let g:airline_symbols.dirty='[+]'   "⚡
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

"#########################################################################
"########################\ Color and Highlighting /#######################
"#########################################################################

"============================\ vim-polyglot /=============================
""cpp 的额外的语法插件与此插件不冲突，markdown 高亮和 vim-markdown 提供的高亮几乎一样
" let g:polyglot_disabled = ['markdown']        "转移到上方

"====================\ vim-cpp-enhanced-highlight /=======================
""Highlighting of class scope is disabled by default. To enable set
let g:cpp_class_scope_highlight = 1
""Highlighting of member variables is disabled by default. To enable set
let g:cpp_member_variable_highlight = 1
""Highlighting of class names in declarations is disabled by default. To enable set
let g:cpp_class_decl_highlight = 1
""Highlighting of POSIX functions is disabled by default. To enable set
let g:cpp_posix_standard = 1
""There are two ways to highlight template functions. Either
""  which works in most cases, but can be a little slow on large files. Alternatively set
"let g:cpp_experimental_simple_template_highlight = 1
""  which is a faster implementation but has some corner cases where it doesn't work.
let g:cpp_experimental_template_highlight = 1
""Highlighting of library concepts is enabled by
let g:cpp_concepts_highlight = 1
""This will highlight the keywords concept and requires as well as all named requirements (like DefaultConstructible) in the standard library.
""Highlighting of user defined functions can be disabled by
"let g:cpp_no_function_highlight = 1
""Vim tend to a have issues with flagging braces as errors, see for example https://github.com/vim-jp/vim-cpp/issues/16. A workaround is to set
let c_no_curly_error=1

"===============================\ vim-go /================================
let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0

"===========================\ vim-javascript /============================
set cole=0
" source: https://github.com/pangloss/vim-javascript/issues/101#issuecomment-45543789

" change to 1 to enable concealing
let g:javascript_conceal = 1

let g:javascript_conceal_function   = 'ƒ'
let g:javascript_conceal_null       = 'ø'
let g:javascript_conceal_this       = '@'
let g:javascript_conceal_return     = '⇚'
let g:javascript_conceal_undefined  = '¿'
let g:javascript_conceal_NaN        = 'ℕ'
let g:javascript_conceal_prototype  = '¶'

" fix conceal color
highlight Conceal guifg=#ffb964

"highlight link Conceal SpellCap
"highlight link Conceal comment
" source: https://github.com/pangloss/vim-javascript/issues/151

" Enables HTML/CSS syntax highlighting in your JavaScript file.
let g:javascript_enable_domhtmlcss = 1
" source: https://github.com/pangloss/vim-javascript

"===========================\ vim-illuminate /============================
" Time in milliseconds (default 250)
let g:Illuminate_delay = 250
" Highlight word under cursor (default: 1)
let g:Illuminate_highlightUnderCursor = 1
""Show highlight group of a symbol under the cursor:
""echo synIDattr(synID(line("."), col("."), 1), "name")
""Thus you can determine which highlight groups you want the illuminating to apply to.
""filetype:[highlight-groups] or filetype:blacklist:[highlight-groups]
" let g:Illuminate_ftHighlightGroups = {
"       \ 'vim': ['vimVar', 'vimString', 'vimLineComment',
"       \         'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc'],
"       \ 'vim:blacklist': ['vimVar', 'vimString', 'vimLineComment',
"       \         'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc']
"       \ }
""Disable Illuminate for some filetypes.
"let g:Illuminate_ftwhitelist = ['python', 'sh', 'nerdtree']
let g:Illuminate_ftblacklist = ['nerdtree']
""Matched symbols
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
    "autocmd VimEnter * hi illuminatedWord cterm=undercurl gui=undercurl
augroup END
""The word under your cursor
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
augroup END
""Enable Illumination in insert mod.
let g:Illuminate_insert_mode_highlight = 1
nnoremap ,<cr> :IlluminationToggle<cr>
""underline for the matched words?
hi! link illuminatedWord Visual


"#########################################################################
"##########################\ Search and Replace /#########################
"#########################################################################

"===============================\ fzf.vim /===============================
" set rtp+=/usr/local/opt/fzf
" set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
" set rtp+=/home/david/.linuxbrew/opt/fzf
""Full list of commands, see :h fzf-vim-commands
let g:fzf_command_prefix = 'Fzf'
noremap ,p :FzfFiles<CR>
noremap ,b :FzfBuffers<CR>
noremap ,l :FzfLines<CR>
noremap ,g :FzfRg<CR>
""Specify tags-generatiing commands for :Tags
let g:fzf_tags_command = 'ctags -R -o .tags'
noremap ,t :FzfTags<CR>
""Use ':Vista finder <tab>' to search tab from other sources.
noremap ,h :FzfHistory<CR>
noremap ,; :FzfHistory:<CR>
noremap ,/ :FzfHistory/<CR>
""Mappings
command! FzfMapsn <plug>(fzf-maps-n)
command! FzfMapsi <plug>(fzf-maps-i)
command! FzfMapsx <plug>(fzf-maps-x)
command! FzfMapso <plug>(fzf-maps-o)
""This is the default extra key bindings
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = {'down':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

""Customize fzf colors to match your color scheme
" let g:fzf_colors = {
"   \ 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'],
"   \}

function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

" command! BD call fzf#run(fzf#wrap({
"             \ 'source': s:list_buffers(),
"             \ 'sink*': { lines -> s:delete_buffers(lines) },
"             \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
"             \ }))
"
" noremap <c-d> :BD<CR>

""退出？直接用 <Esc> 就行了
" noremap <c-d> call fzf#run(fzf#wrap({
"             \ 'source': s:list_buffers(),
"             \ 'sink*': { lines -> s:delete_buffers(lines) },
"             \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
"             \ }))

"============================\ fzf-gitignore /=============================
""Disable all key mappings.
" let g:fzf_gitignore_no_maps = 1
noremap <LEADER>gi :FzfGitignore<CR>

"============================\ any-jump.vim /=============================
""Show line numbers in search rusults
" let g:any_jump_list_numbers = 0
""Auto search references
let g:any_jump_references_enabled = 1
""Auto group results by filename
let g:any_jump_grouping_enabled = 1
""Amount of preview lines for each search result
let g:any_jump_preview_lines_count = 5
""Max search results, other results can be opened via [a]
let g:any_jump_max_search_results = 7
""Default search results list styles:
""- 'filename_first'
""- 'filename_last'
let g:any_jump_results_ui_style = 'filename_first'
""Any-jump window size & position options
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9
" let g:any_jump_window_top_offset   = 4
""Or override all default colors
let g:any_jump_colors = {
            \}
" \"plain_text":         "Comment",
" \"preview":            "Comment",
" \"preview_keyword":    "Operator",
" \"heading_text":       "Function",
" \"heading_keyword":    "Identifier",
" \"group_text":         "Comment",
" \"group_name":         "Function",
" \"more_button":        "Operator",
" \"more_explain":       "Comment",
" \"result_line_number": "Comment",
" \"result_text":        "Statement",
" \"result_path":        "String",
" \"help":               "Comment"
""Disable default any-jump keybindings (default: 0)
" let g:any_jump_disable_default_keybindings = 0
""Remove comments line from search results (default: 1)
" let g:any_jump_remove_comments_from_results = 1
""Custom ignore files
""default is: ['*.tmp', '*.temp']
" let g:any_jump_ignored_files = ['*.tmp', '*.temp']
""Search references only for current file type
""(default: false, so will find keyword in all filetypes)
" let g:any_jump_references_only_for_current_filetype = 0
""Disable search engine ignore vcs untracked files (default: false, search engine will ignore vcs untracked files)
" let g:any_jump_disable_vcs_ignore = 0

"============================\ far.vim /=============================
""F Far Farp Farr Farf Fardo Farundo Refar(in a Far buffer)
""For params, see :h far-params
noremap <LEADER>f :F<space><space>**/*
            \<left><left><left><left><left>
"\--source='agnvim' --cwd=''
"\--win-layout --win-width --win-height
"\--preview-win-layout --preview-win-width --preview-win-height
"\--auto-preview --auto-preview-on-start
if has('nvim')
    let g:far#source = 'rgnvim'
else
    let g:far#source = 'rg'
endif
let g:far#enable_undo = 1
""For default mappings, see :h default-far-mappings
"" X I T F <CR> p P <C-k> <C-j> s u U q za
let g:far#mapping = {
            \ "stoggle_expand_all": 'zt',
            \ 'toggle_expand_all':  'zA',
            \ "expand_all":         'zr',
            \ 'collapse_all':       'zm',
            \ }


"#########################################################################
"###################\ Completion and Syntax Checking /####################
"#########################################################################

"============================\ coc.nvim /=============================
""Language Servers; Snippets(coc-snippets); ...
""fix the most annoying bug that coc has
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
""Language servers: https://github.com/neoclide/coc.nvim/wiki/Language-servers
""Edit snippet file for current filetype: :CocCommand snippets.editSnippets
""建议只在首次安装时使用以下列表，之后可以使用 CocInstall/CocUninstall
let g:coc_global_extensions = [
            \ 'coc-diagnostic',
            \ 'coc-tabnine',
            \ 'coc-pyright',
            \ 'coc-sh',
            \ 'coc-css',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-tsserver',
            \ 'coc-tslint-plugin',
            \ 'coc-prettier',
            \ 'coc-stylelint',
            \ 'coc-syntax',
            \ 'coc-vimlsp',
            \ 'coc-yaml',
            \ 'coc-floaterm',
            \ 'coc-lists',
            \ 'coc-explorer',
            \ 'coc-bookmark'
            \ ]
" \ 'coc-ccls',
" \ 'coc-translator',
" \ 'coc-sourcekit',
" \ 'coc-flutter',
" \ 'coc-actions',
" \ 'coc-gitignore',
" \ 'coc-tasks',
" \ 'coc-todolist',
" \ 'coc-yank',
" \ 'coc-snippets',
""Use python-language-server instead: pip install 'python-language-server[all]'
            "\ 'coc-python',
            "\ 'coc-pyright',
""Use coc-ccls instead
            "\ 'coc-clangd',
""??????????
""Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <silent><expr> <S-Tab>
            \ pumvisible() ? "\<C-p>" :
            \ <SID>check_back_space() ? "\<S-Tab>" :
            \ coc#refresh()
""Define the key to confirm completion (for snippets and additional edit)
""<Tab>:使普通使用时 tab 插入空行; <cr>:无效。
inoremap <silent><expr> <C-c> pumvisible() ?
            \ coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
""Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

""coc-snippets :CocCommand snippets.editSnippets to edit snippet file for current file
" inoremap <silent><expr> <C-c>
"             \ pumvisible() ? coc#_select_confirm() :
"             \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"             \ <SID>check_back_space() ? "\<TAB>" :
"             \ coc#refresh()
" let g:coc_snippet_next = '<M-j>'
" let g:coc_snippet_prev = '<M-k>'

" noremap <C-z> :CocCommand translator.popup<cr>

""coc-explorer
let g:coc_explorer_global_presets = {
            \   'nvim': {
            \     'root-uri': '~/.config/nvim/',
            \   },
            \   'tab': {
            \     'position': 'tab',
            \     'quit-on-open': 1,
            \   },
            \   'floating': {
            \     'position': 'floating',
            \     'open-action-strategy': 'sourceWindow',
            \   },
            \   'floatingTop': {
            \     'position': 'floating',
            \     'floating-position': 'center-top',
            \     'open-action-strategy': 'sourceWindow',
            \   },
            \   'floatingLeftside': {
            \     'position': 'floating',
            \     'floating-position': 'left-center',
            \     'floating-width': 50,
            \     'open-action-strategy': 'sourceWindow',
            \   },
            \   'floatingRightside': {
            \     'position': 'floating',
            \     'floating-position': 'right-center',
            \     'floating-width': 50,
            \     'open-action-strategy': 'sourceWindow',
            \   },
            \   'simplify': {
            \     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
            \   }
            \ }

" nnoremap <leader>ce :CocCommand explorer --preset floating<CR>
nnoremap <leader>ce :CocCommand explorer<CR>

""coc-bookmark
nmap <Leader>bj <Plug>(coc-bookmark-next)
nmap <Leader>bk <Plug>(coc-bookmark-prev)
nmap <leader>bt <Plug>(coc-bookmark-toggle)
" <Plug>(coc-bookmark-annotate)
""Q: The background of bookmark signs are not consistent with signcolumn...
" function! s:my_bookmark_color() abort
"   let s:scl_guibg = matchstr(execute('hi SignColumn'), 'guibg=\zs\S*')
"   let s:scl_guifg = matchstr(execute('hi SignColumn'), 'guifg=\zs\S*')
"   if empty(s:scl_guibg)
"     let s:scl_guibg = 'NONE'
"   endif
"   if empty(s:scl_guifg)
"     let s:scl_guifg = 'NONE'
"   endif
"   exe 'hi MyBookmarkSign guibg=' . s:scl_guibg . ' guifg=' . s:scl_guifg
" endfunction
" call s:my_bookmark_color() " don't remove this line!
"
" augroup UserGitSignColumnColor
"   autocmd!
"   autocmd ColorScheme * call s:my_bookmark_color()
" augroup END

" Use g[ and g] to navigate diagnostics
" Use :CocDiagnostics to get all diagnostics of current buffer in location list.
nnoremap <silent> <leader>g[ <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>g] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nnoremap <silent> <leader>gd <Plug>(coc-definition)
nnoremap <silent> <leader>gy <Plug>(coc-type-definition)
nnoremap <silent> <leader>gi <Plug>(coc-implementation)
nnoremap <silent> <leader>gr <Plug>(coc-references)

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
"
" Use <leader>K to show documentation in preview window.
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap \\f  <Plug>(coc-format-selected)
nmap \\f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>F  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let lua_lsp = glob('~/.vscode/extensions/sumneko.lua*', 0, 1)
if len(lua_lsp)
    let lua_lsp = lua_lsp[-1] . '\server'
    call coc#config('languageserver', {
        \ 'lua-language-server': {
        \     'cwd': lua_lsp,
        \     'command': lua_lsp . '\bin\lua-language-server.exe',
        \     'args': ['-E', '-e', 'LANG="zh-cn"', lua_lsp . '\main.lua'],
        \     'filetypes': ['lua'],
        \ }
    \ })
endif

" let g:airline#extensions#coc#enabled = 1
" let airline#extensions#coc#error_symbol = 'E:'
" let airline#extensions#coc#warning_symbol = 'W:'
" let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
" let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"=========================\ completion-nvim /==========================
" lua require'nvim_lsp'.pyls.setup{on_attach=require'completion'.on_attach}
" lua <<EOF
" local lspconfig = require'lspconfig'
" local configs = require'lspconfig/configs'
"
" EOF
"
" let g:completion_auto_change_source = 1

"============================\ ultisnips /=============================
" Plug 'alohaia/vim-snippets'               " snips for snipmate and ultisnips
""An array of relative directory names OR an array with a single absolute path.
" Defines how the edit window is opened.
let g:UltiSnipsEditSplit="vertical"
""Enable snippmate snippets (dirs named 'snippets' under dirs in &runtimepath)
" let g:UltiSnipsEnableSnipMate = 1
let g:UltiSnipsRemoveSelectModeMappings = 0
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"
" 在代码段内跳转
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsSnippetsDir=[$HOME."/.config/nvim/UltiSnips"]
" let g:UltiSnipsSnippetDirectories=["UltiSnips"]
""Add c snippets for cpp files. (改为在 snippets 文件中使用 extends 关键字)
" au FileType cpp UltiSnipsAddFiletypes cpp.c
" autocmd! User UltiSnipsEnterFirstSnippet
" autocmd User UltiSnipsEnterFirstSnippet echomsg 'snippet expanded'
" autocmd! User UltiSnipsExitLastSnippet
" autocmd User UltiSnipsExitLastSnippet echomsg 'expanding finished'


"#########################################################################
"############################\ Debug & Tasks /############################
"#########################################################################

"============================\ vimspector /=============================
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools']
let g:vimspector_base_dir='/home/aloha/.config/nvim/settings/vimspector'
"let g:vimspector_enable_mappings = 'HUMAN'    " 'VISUAL_STUDIO'
command! Launch   call vimspector#Launch()
command! Continue call vimspector#Continue()
command! Pause    call vimspector#Pause()
command! Stop     call vimspector#Stop()
command! Restart  call vimspector#Restart()
map <silent> <F5>  <Plug>VimspectorStepOver
map <silent> <F6>  <Plug>VimspectorStepInto
map <silent> <F7>  <Plug>VimspectorStepOut
map <silent> <F8>  <Plug>VimspectorToggleBreakpoint
map <silent> <F9>  <Plug>VimspectorToggleConditionalBreakpoint
map <silent> <F10> <Plug>VimspectorAddFunctionBreakpoint
""Changing the default signs⚝ ◉ ♦ 🔴🔵
sign define vimspectorBP text=◉  texthl=ColorColumn
sign define vimspectorBPDisabled text=○  texthl=ColorColumn
sign define vimspectorBPCond text=♦  texthl=ColorColumn
"The program counter, i.e. current line.🔶
sign define vimspectorPC text=➤➤ texthl=ColorColumn

"============================\ asyncrun.vim /=============================
""运行时自动打开高度为 6 的 quickfix 窗口
"let g:asyncrun_open = 6
""编译整个项目时，通过rootmarks确定项目根目录，可以通过创建特殊空目录的方式截断向上查找的过程。
""Customize Runner: https://github.com/skywind3000/asynctasks.vim/wiki/Customize-Runner
function s:asyncrun_floaterm(opts)abort
    let l:name = 'AsyncRun'
    let l:bufnr = floaterm#terminal#get_bufnr(l:name)
    if l:bufnr == -1
        execute('FloatermNew --name='.l:name)
        execute('FloatermToggle '.l:name)
        execute('FloatermSend ' . a:opts.cmd)
        execute('FloatermToggle '.l:name)
    else
        execute('FloatermSend --name=' . l:name . ' ' . a:opts.cmd)
        execute('FloatermToggle '.l:name)
    endif
endfunction
let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.floaterm = function('s:asyncrun_floaterm')

let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', '.tasks']

"============================\ asynctasks.vim /=============================
command! Run   AsyncTask run
command! Build AsyncTask build
""设置终端的工作位置和工作模式
""使用 floaterm 需要在项目配置中设置 output=terminal
let g:asynctasks_term_pos = 'floaterm'
""设置tab模式的终端可复用
"let g:asynctasks_term_reuse = 1
""打开新的分屏终端时保持 fucus
"let g:asynctasks_term_focus = 0
""当使设置为 top/bottom/left/right 时，可以用下面两个配置确定终端窗口大小：
" let g:asynctasks_term_rows = 10    " 设置纵向切割时，高度为 10
" let g:asynctasks_term_cols = 80    " 设置横向切割时，宽度为 80
""Task_examples: https://github.com/skywind3000/asynctasks.vim/wiki/Task-Examples
""Change different name for global/local configuration.
" let g:asynctasks_rtp_config = expand('tasks.ini')
" let g:asynctasks_config_name = '.git/tasks'
""Extra configurations loaded after the original global configuration.
let g:asynctasks_extra_config = [
            \ '~/.config/nvim/settings/asynctask/tasks.ini',
            \ ]
""Define environment variables such as ${VIM:my_name}
let g:asynctasks_environ = {
            \ 'my_name': 'aloha',
            \ 'cppc': '/usr/bin/g++',
            \ 'cc': '/usr/bin/gcc',
            \}
""插件还提供了一个用于在命令行下执行 task 的脚本 asynctask, 并支持使用 fzf 查找 task.
""Integrate with fzf: https://github.com/skywind3000/asynctasks.vim/wiki/UI-Integration
""Usage: :AsyncTaskFzf
function! s:fzf_sink(what)
    let p1 = stridx(a:what, '<')
    if p1 >= 0
        let name = strpart(a:what, 0, p1)
        let name = substitute(name, '^\s*\(.\{-}\)\s*$', '\1', '')
        if name != ''
            exec "AsyncTask ". fnameescape(name)
        endif
    endif
endfunction

function! s:fzf_task()
    let rows = asynctasks#source(&columns * 48 / 100)
    let source = []
    for row in rows
        let name = row[0]
        let source += [name . '  ' . row[1] . '  : ' . row[2]]
    endfor
    let opts = { 'source': source, 'sink': function('s:fzf_sink'),
                \ 'options': '+m --nth 1 --inline-info --tac' }
    if exists('g:fzf_layout')
        for key in keys(g:fzf_layout)
            let opts[key] = deepcopy(g:fzf_layout[key])
        endfor
    endif
    call fzf#run(opts)
endfunction

command! -nargs=0 AsyncTaskFzf call s:fzf_task()
command! -nargs=0 FzfTasks call s:fzf_task()

""Templates for :AsyncTaskEdit
let g:asynctasks_template = {}
" let g:asynctasks_template.cargo = [
"         \ "[project-init]",
"         \ "command=cargo update",
"         \ "cwd=<root>",
"         \ "",
"         \ "[project-build]",
"         \ "command=cargo build",
"         \ "cwd=<root>",
"         \ "errorformat=%. %#--> %f:%l:%c",
"         \ "",
"         \ "[project-run]",
"         \ "command=cargo run",
"         \ "cwd=<root>",
"         \ "output=terminal",
"         \ ]

"============================\ vim-rooter /=============================
let g:rooter_patterns = ['.rooter', '.git']
""Don't echo the project directory.
let g:rooter_silent_chdir = 1

"#########################################################################
"#####################\ General Editing Enhancement /#####################
"#########################################################################

"============================\ vim-capslock /=============================
set statusline^=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}
"imap <C-L> <C-O><Plug>CapsLockToggle

"==========================\ vim-after-object /===========================
""Enable some characters and use ]= and [= instead of a= and aa=
autocmd VimEnter * call after_object#enable([']', '['], '/', '=', ':', '-', '#', '*', ' ')

"===========================\ vim-easymotion /============================
""Cauce slow motion:
""~/.config/nvim/plugins/argtextobj.vim/plugin/argtextobj.vim L:296
nmap \ <Plug>(easymotion-prefix)
nmap \. <Plug>(easymotion-repeat)
""Default mappings
let g:EasyMotion_do_mapping = 0
nmap \f <Plug>(easymotion-f)
nmap \F <Plug>(easymotion-F)
nmap \t <Plug>(easymotion-t)
nmap \T <Plug>(easymotion-T)
nmap \w <Plug>(easymotion-w)
nmap \W <Plug>(easymotion-W)
nmap \b <Plug>(easymotion-b)
nmap \B <Plug>(easymotion-B)
nmap \e <Plug>(easymotion-e)
nmap \E <Plug>(easymotion-E)
nmap \g <Plug>(easymotion-ge)
nmap \g <Plug>(easymotion-gE)
nmap \j <Plug>(easymotion-j)
nmap \k <Plug>(easymotion-k)
nmap \n <Plug>(easymotion-n)
nmap \N <Plug>(easymotion-N)
nmap \s <Plug>(easymotion-s)
""Search for two characters.
nmap \2s <Plug>(easymotion-s2)
nmap \2f <Plug>(easymotion-f2)
nmap \2F <Plug>(easymotion-F2)
nmap \2t <Plug>(easymotion-t2)
nmap \2T <Plug>(easymotion-T2)
" nmap \\ <Plug>(easymotion-sl2)
" nmap \\ <Plug>(easymotion-fl2)
" nmap \\ <Plug>(easymotion-Fl2)
" nmap \\ <Plug>(easymotion-tl2)
" nmap \\ <Plug>(easymotion-Tl2)
""Search for any number of characters.
nmap \ns <Plug>(easymotion-sn)
nmap \nf <Plug>(easymotion-fn)
nmap \nF <Plug>(easymotion-Fn)
nmap \nt <Plug>(easymotion-tn)
nmap \nT <Plug>(easymotion-Tn)
" nmap \\ <Plug>(easymotion-sln)
" nmap \\ <Plug>(easymotion-fln)
" nmap \\ <Plug>(easymotion-Fln)
" nmap \\ <Plug>(easymotion-tln)
" nmap \\ <Plug>(easymotion-Tln)
""Over Window Motion
nmap \wf <Plug>(easymotion-overwin-f)
nmap \wF <Plug>(easymotion-overwin-f2)
nmap \wl <Plug>(easymotion-overwin-line)
nmap \ww <Plug>(easymotion-overwin-w)

let g:EasyMotion_do_shade = 1
let g:EasyMotion_smartcase = 1

" Plug 'Konfekt/FastFold'
"Plug 'junegunn/vim-peekaboo'
"Plug 'wellle/context.vim'

"============================\ vim-subversive /=============================
""For details, see :h subversive-substitute-over-range-motion and :h text-objects
"" s p b B
""whether to pre-populate the prompt with the text to be replaced.
"let g:subversivePromptWithCurrent = 0
""whether to pre-populate the given register with the text to be replaced.
""In this way, you can use <C-r><reg> to populate the prompt manually.
let g:subversiveCurrentTextRegister = 1
nmap s <plug>(SubversiveSubstitute)
xmap s <plug>(SubversiveSubstitute)
xmap p <plug>(SubversiveSubstitute)
xmap P <plug>(SubversiveSubstitute)
nmap ss <plug>(SubversiveSubstituteLine)
nmap S <plug>(SubversiveSubstituteToEndOfLine)
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)
nmap <leader>ss <plug>(SubversiveSubstituteWordRange)
" nmap <leader>s <plug>(SubversiveSubstituteRangeNoPrompt)
" xmap <leader>s <plug>(SubversiveSubstituteRangeNoPrompt)
" nmap <leader>ss <plug>(SubversiveSubstituteWordRangeNoPrompt)
nmap <leader>cr <plug>(SubversiveSubstituteRangeConfirm)
xmap <leader>cr <plug>(SubversiveSubstituteRangeConfirm)
nmap <leader>crr <plug>(SubversiveSubstituteWordRangeConfirm)
""Behave the same as '<leader>s' except that it will perform
"" an abolish(tpope/vim-abolish) 'subvert' instead of using vim's built in substitute command.
nmap <leader><leader>s <plug>(SubversiveSubvertRange)
xmap <leader><leader>s <plug>(SubversiveSubvertRange)
nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)
" nmap <leader><leader>s <plug>(SubversiveSubvertRangeNoPrompt)
" xmap <leader><leader>s <plug>(SubversiveSubvertRangeNoPrompt)
" nmap <leader><leader>ss <plug>(SubversiveSubvertWordRangeNoPrompt)
""Customize text objects.
""ie = inner entire buffer
omap ie :exec "normal! ggVG"<cr>
""iv = current viewable text in the buffer
omap iv :exec "normal! HVL"<cr>

""Store abolishes in a specified file.
" let g:abolish_save_file = "after/plugin/abolish.vim"
"":Abolish! ... to append abolish to the file, :Abolish -delete to remove it.
""       Abolish -delete -buffer -cmdline anomol{y,ies}
""=== search ===
"":Abolish -search <pattern> :S/<pattern>/       search
"":Abolish! -search <pattern> :S?<pattern>?      search in reverse.
""=== grep ===
"":S /box{,es}/ *
"":S /box/aw *.txt *.html
""=== flags ===
"":h abolish-substitute

"=============================\ vim-yoink /===============================
"":Yanks :ClearYanks
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)
nmap y <plug>(YoinkYankPreserveCursorPosition)
xmap y <plug>(YoinkYankPreserveCursorPosition)
""History size.
let g:yoinkMaxItems = 20
""Synchronize with numbered registers 1 - 9
" let g:yoinkSyncNumberedRegisters = 0
""Let delete operations be added to the yank history.
" let g:yoinkIncludeDeleteOperations = 0
""Save yank history persistently. Only support in neovim.
""You can also use this feature to sync the yank history across multiple running instances of NeoVim
if has('nvim')
    let g:yoinkSavePersistently = 1
endif
""Automatically format the paste.
" let g:yoinkAutoFormatPaste = 0
""Put corsor the the end of the paste.
" let g:yoinkMoveCursorToEndOfPaste = 0
""Cycle around yank histories.
" let g:yoinkSwapClampAtEnds = 1
""Include the changes of all registers instead of only default register.
" let g:yoinkIncludeNamedRegisters = 1
""Synchronize with system clipboard.
" let g:yoinkSyncSystemClipboardOnFocus = 1

"============================\ clever-f.vim /=============================
""Search a character only in current line
" let g:clever_f_across_no_line = 0
""ignorecase and smartcase
"let g:clever_f_ignore_case = 0
let g:clever_f_smart_case = 1
""Migemo support
let g:clever_f_use_migemo = 1
""Adjust search to match vim's original direction.
let g:clever_f_fix_key_direction = 1
""Characters to match any signs.
let g:clever_f_chars_match_any_signs = ''
""Highlight current position while waitting for a character.
" let g:clever_f_mark_cursor = 1
""Change the highlight group.
" let g:clever_f_mark_cursor_color = "Cursor"
""Use <CR> and <Tab> to repeat last character.
let g:clever_f_repeat_last_char_inputs = ["\<CR>", "\<Tab>"]
""Highlight the character which the cursor can be moved directly to.
let g:clever_f_mark_direct = 1
let g:clever_f_mark_direct_color = "CleverFDefaultLabel"

" gS to split a one-liner into multiple lines
" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.

"============================\ nerdcommenter /============================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"==========================\ vim-visual-multi /===========================
""Leader key for this plugin.
let g:VM_leader = {'default': ',', 'visual': ',', 'buffer': ','}
""Use default mappings.
let g:VM_default_mappings = 1
""Full Mapping List - https://github.com/mg979/vim-visual-multi/wiki/Mappings#full-mappings-list
" let g:VM_maps={}
""Change some default mappings below if needed.
"Use mouse
" "Create a cursor at the clicked position.
" nmap   <C-LeftMouse>     <Plug>(VM-Mouse-Cursor)
" "Select the clicked word.
" nmap   <C-RightMouse>    <Plug>(VM-Mouse-Word)
" "Create a column of cursors, keeping the initial vertical column, up to the clicked line.
" nmap   <M-C-RightMouse>  <Plug>(VM-Mouse-Column)

"============================\ vim-surround /=============================
vnoremap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>
au FileType php let b:surround_45 = "<?php \r ?>"
" echo char2nr("-") -> 45
" print "Hello *world!"     yss-        <?php print "Hello world!" ?>
au FileType tex let b:surround_108 = "\\begin{\1environment: \1}\r\\end{\1\r}.*\r\1}"
let g:surround_{char2nr("d")} = "<div\1id: \r1.*\r id=\"&\"\1>\r</div>"
let g:surround_insert_tail = "<++>"

" vS yS<motion><replacement> ySS<replacement>\
" Replacement <C-]> b B r a | t/T/< <C-t> | f F <C-f>

" "hello"                   ysWta>            <a>"hello"</a>
" "hello"                   ysW<C-t>echo<cr>  <a>
"                                                 "hello"
"                                             </a>
"
" "hello"                   ysWfprint<cr>     print("hello")
" "hello"                   ysWFprint<cr>     print( "hello" )
" "hello"                   ysW<C-f>print<cr> (print "hello")

"============================\ delimitMate /==============================
" ""Set to any value to disable this pluging globally or in specific buffers.
" " let g:loaded_delimitMate = 1
" " au FileType ... let b:g:loaded_delimitMate = 1
" ""This options turns delimitMate off for the listed file types.
" " let delimitMate_excluded_ft = "mail,txt"
" ""Add a closing delimiter automagically.
" let g:delimitMate_autoclose = 1
" ""The expansion of space and cr will also be applied to quotes.
" let g:delimitMate_expand_inside_quotes = 1
" ""This option turns on/off the jumping over <CR> and <Space> expansions when inserting closing matchpairs.
" let g:delimitMate_jump_expansion = 1
" ""Automatically insert a quote when the pattern matches or doesn't match if a ! presented at the beginning.
" ""Use '\%#' to match (matches with zero width) the position of the cursor.
" ""          For expample, set to '\%#.hello'
" ""       |hello   ->    "    ->    ""hello
" ""       |world   ->    "    ->    "world
" let g:delimitMate_smart_quotes = '\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
" ""This regex is matched against the text to the right of cursor, if it's not empty and there is a match delimitMate will not autoclose the pair.
" ""\! will be replaced by the character being inserted;
" ""\# will be replaced by the closing pair.
" ""          For expample, set to 'hello'
" ""       |hello   ->    (    ->    (hell0
" ""       |world   ->    (    ->    ()world
" let g:delimitMate_smart_matchpairs = '^\%(\w\|\!\|[£$]\|[^[:space:][:punct:]]\)'
" ""See :h delimitMateBalance.
" let g:delimitMate_balance_matchpairs = 1
" ""This options turns delimitMate off for the listed regions, see :h group-name for more info about what is a region.
" ""You can use :Showhi to see group name of text under the cursor.
" " let delimitMate_excluded_regions = "Comment,String"
" ""Auto insert eol marker.
" ""0 -> never
" ""1 -> when inserting any matchpair
" ""2 -> when expanding car return in matchpair
" " let g:delimitMate_insert_eol_marker = 1
" " au FileType cpp let b:delimitMate_eol_marker = ";"
" inoremap <M-e>   <Plug>delimitMateJumpAny
" inoremap <M-S-e> <Plug>delimitMateJumpMany
" " imap <M-BS>  <Plug>delimitMateS-BS
" ""In basic.vim: imap <M-BS> <Del>
" ""Which characters should be considered as matching pairs.
" let g:delimitMate_matchpairs = "(:),[:],{:},<:>"
" au FileType c,cpp let b:delimitMate_matchpairs = "(:),[:],{:}"
" ""DelimitMate 提供了宽字符支持。
" let g:delimitMate_matchpairs = g:delimitMate_matchpairs.",（:）,《:》,【:】"
" " ""Which characters should be considered as quotes.
" " let g:delimitMate_quotes = "\" ' ` "
" " au FileType markdown let g:delimitMate_quotes = g:delimitMate_quotes."* "
" ""三个 quotes，如 python 中的多行注释/多行字符串、MarkDown 中的代码块。
" au Filetype python let delimitMate_nesting_quotes = ['"']
" au Filetype markdown let delimitMate_nesting_quotes = ['`']
" ""Turns on/off expansion of <CR> and <Space>
" let g:delimitMate_expand_cr = 1           " 0/1/2 set to 2 to force cr-expansion.
" let g:delimitMate_expand_space = 1

"===============================\ auto-pairs /============================
" 开启/禁用 auto-pairs
let g:AutoPairsShortcutToggle='M-o'
" 将一对 pair 后面的内容移到 pair 中（在 pair 内按下快捷键）
let g:AutoPairsShortcutFastWrap='<M-e>'
let g:AutoPairsShortcutJump=''
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`'}
au FileType * let b:AutoPairs = g:AutoPairs
au FileType html let b:AutoPairs['<'] = '>'
au FileType vim let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '`':'`', '<':'>'}
" au FileType vimwiki let b:AutoPairs['='] = '='
" 使用 Backspace 删除时会删除 pair 中的另一个
let g:AutoPairsMapBs=1
" 让使用 <C-h> 删除时不会删除 pair 中的另一个
let g:AutoPairsMapCh=0
""在pairs间输入空格
let g:AutoPairsMapSpace=1
" 将回车键映射为插入空行的操作
let g:AutoPairsMapCR=1

""FlyMode, 输入 ")", "}", "]" 总是会跳转到后方的 ")", "}", "]" 后面
" let g:AutoPairsFlyMode=0
""纠正错误跳转
" let g:AutoPairsShortcutBackInsert='<M-b>'


"#########################################################################
"###############################\ MarkDown /##############################
"#########################################################################

"============================\ vim-markdown /=============================
" "查看所有配置建议
" :help vim-markdwon
" [[ "跳转上一个标题 ]] "跳转下一个标题 ]c "跳转到当前标题 ]u "跳转到副标题 zr "打开下一级折叠
" zR "打开所有折叠
" zm "折叠当前段落
" zM "折叠所有段落
" :Toc "显示目录
""高亮数学公式
let g:vim_markdown_math = 1
let vim_markdown_folding_disabled = 1

"============================\ vim-instant-markdownm /=============================
" filetype plugin on
" "Uncomment to override defaults:
" "let g:instant_markdown_slow = 1
" "let g:instant_markdown_autostart = 0
" "let g:instant_markdown_open_to_the_world = 1
" "let g:instant_markdown_allow_unsafe_content = 1
" "let g:instant_markdown_allow_external_content = 0
" "let g:instant_markdown_mathjax = 1
" "let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
" "let g:instant_markdown_autoscroll = 0
" "let g:instant_markdown_port = 8888
" "let g:instant_markdown_python = 1

"============================\ markdown-preview.nvim /=============================
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0
" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0
" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0
" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0
" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0
" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''
" specify browser to open preview page
" default: ''
" options: chromium, firefox, google-chrome-stable, etc.
let g:mkdp_browser = 'google-chrome-stable'
" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0
" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''
" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
let g:mkdp_preview_options = {
            \ 'mkit': {},
            \ 'katex': {},
            \ 'uml': {},
            \ 'maid': {},
            \ 'disable_sync_scroll': 0,
            \ 'sync_scroll_type': 'middle',
            \ 'hide_yaml_meta': 1,
            \ 'sequence_diagrams': {},
            \ 'flowchart_diagrams': {},
            \ 'content_editable': v:false
            \ }
" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''
" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''
" use a custom port to start server or random for empty
let g:mkdp_port = ''
" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'
" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown', 'vimwiki']

"============================\ vim-table-mode /=============================
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1

"============================\ vim-markdown-toc /=============================
""Type :GenToc<tab> to start.
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'
"let g:vmt_list_item_char = '*'
""Every level will instead cycle between the valid list item markers *, - and +
let g:vmt_cycle_list_item_markers = 1
""Include headings before the position of Table of Contents.
"let g:vmt_include_headings_before = 1

"============================\ bullets.vim /=============================
""Enable/disable default key mappings:
" let g:bullets_set_mappings = 0 " default = 1
""Disable this plugin for empty buffers (no filetype)
let g:bullets_enable_in_empty_buffers = 0 " default = 1
""Enable/disable deleting the last empty bullet when hitting `<cr>` (insert mode) or `o` (normal mode):
" let g:bullets_delete_last_bullet_if_empty = 0 " default = 1
""Line spacing between bullets (1 = no blank lines, 2 = one blank line, etc.):
" let g:bullets_line_spacing = 2 " default = 1
""Add extra padding between the bullet and text when bullets are multiple characters long:
" let g:bullets_pad_right = 1 " default = 1
""Maximum number of alphabetic characters to use for bullets:
" let g:bullets_max_alpha_characters = 2 " default = 2
""Nested outline bullet levels:
" let g:bullets_outline_levels = ['ROM', 'ABC', 'num', 'abc', 'rom', 'std-', 'std*', 'std+'] " default
""Automatically renumbering the current ordered bullet list when changing the indent level of bullets or inserting a new bullet:
" let g:bullets_renumber_on_change = 1 " default = 1
""Enable/disable toggling parent and child checkboxes to indicate "completion" of child checkboxes:
" let g:bullets_nested_checkboxes = 1 " default = 1
""Define the checkbox markers to use to indicate unchecked, checked, and "partially" checked.
" let b:bullets_checkbox_markers = ' .oOX'    " '✗○ ◐ ● ✓'
""Define whether toggling partially complete checkboxes sets the checkbox to checked or unchecked:
" let g:bullets_checkbox_partials_toggle = 1    " default 1
au FileType markdown let g:bullets_checkbox_markers = ' X'
let g:bullets_enabled_file_types = [
            \ 'markdown',
            \ 'text',
            \ 'gitcommit',
            \ 'scratch',
            \ 'text'
            \]

"============================\ md-img-paste /=============================
autocmd FileType markdown nnoremap <buffer> <leader>i :call mdip#MarkdownClipboardImage()<cr>
""Default name of markdown's alternative name of images.
" let g:mdip_imgname = 'image'
""Image dir path relative to expand('%:p:h'). And this will be expanded.
let g:mdip_imgdir = '%:p:t:r'
""Use prefix/postfix, for example: <filename>.asserts like typora.
let g:mdip_imgdir_prefix = ''
let g:mdip_imgdir_postfix = '.asserts'

"===============================\ vimtex /================================
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode = 0
let g:vimtex_complete_close_braces = 1
let g:vimtex_cache_root = expand('~/.config/nvim/.cache/vimtex')
""Default mappings, see :h vimtex-default-mappings
let g:vimtex_mappings_enabled = 1
""Set conceal text to hide.
let g:tex_conceal='abdmg'
au FileType tex command! FzfTex call vimtex#fzf#run('ctli', g:fzf_layout)
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : '',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'hooks' : [],
            \ 'options' : [
            \   '-verbose',
            \   '-file-line-error',
            \   '-synctex=1',
            \   '-interaction=nonstopmode',
            \ ],
            \}
""使用 Ctex 宏包的中文文档建议使用 xelatex 编译
let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-xelatex',
            \ 'pdflatex'         : '-pdf',
            \ 'dvipdfex'         : '-pdfdvi',
            \ 'lualatex'         : '-lualatex',
            \ 'xelatex'          : '-xelatex',
            \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
            \ 'context (luatex)' : '-pdf -pdflatex=context',
            \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
            \}
let g:vimtex_compiler_latexrun_engines = {
            \ '_'                : 'xelatex',
            \ 'pdflatex'         : 'pdflatex',
            \ 'lualatex'         : 'lualatex',
            \ 'xelatex'          : 'xelatex',
            \}
" let g:vimtex_compiler_latexmk = {
"     \ 'build_dir' : '',
"     \ 'callback' : 1,
"     \ 'continuous' : 1,
"     \ 'executable' : 'latexmk',
"     \ 'hooks' : [],
"     \ 'options' : [
"     \   '-verbose',
"     \   '-file-line-error',
"     \   '-synctex=1',
"     \   '-interaction=nonstopmode',
"     \ ],
"     \}
" let g:vimtex_mappings_enabled = 0
" let g:vimtex_text_obj_enabled = 0
" let g:vimtex_motion_enabled = 0
" let maplocalleader=' '

"=============================\ pangu.vim /===============================
autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing()


"#########################################################################
"#########################\ Terminal Impvovement /########################
"#########################################################################

"============================\ vim-floaterm /=============================
let g:floaterm_keymap_toggle = '<F1>'
let g:floaterm_keymap_prev   = '<F2>'
let g:floaterm_keymap_next   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'
" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=1
let g:floaterm_autoclose=1
""Q:This plugin leaves an empty buffer on startify window A:
autocmd User Startified setlocal buflisted


"#########################################################################
"#############################\ Git Related /#############################
"#########################################################################
""Most frequently used command: :Gblame :Gvdiffsplit GV

"==============================\ agit.vim /===============================
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1

"============================\ vim-signify /==============================
""default updatetime 4000ms is not good for async update
set updatetime=100
let g:signify_sign_add               = '▐'
let g:signify_sign_delete_first_line = '▔'
let g:signify_sign_delete            = '▎'
let g:signify_sign_change            = '░'
highlight SignifySignAdd    ctermfg=green  guifg=#A6DB29
highlight SignifySignDelete ctermfg=red    guifg=#ff0000
highlight SignifySignChange ctermfg=yellow guifg=#ffff00


"#########################################################################
"#################################\ Msic /################################
"#########################################################################

"=============================\ zeavim.vim /==============================
" http://{city_name}.kapeli.com/feeds/{name}.tgz
"   city_name: frankfurt, london, newyork, sanfrancisco, singapore, sydney, tokyo
"   name: get from http://api.zealdocs.org/v1/docsets
" Plug 'keith/investigate.vim'       " Looking documentation online/offline

"=============================\ indentline /==============================
" 指定对齐线的尺寸
let g:indent_guides_guide_size = 1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level = 2
""highlight conceal color with your colorscheme, 禁用插件的高亮
let g:indentLine_setColors = 1
" Vim
let g:indentLine_color_term = 239
" GVim
" none X terminal
"let g:indentLine_color_tty_light = 7 " (default: 4)
"let g:indentLine_color_dark = 1 " (default: 2)
" Background (Vim, GVim)
" let g:indentLine_bgcolor_term = 202
" let g:indentLine_bgcolor_term = 202
" let g:indentLine_color_gui = '#A4E57E'
" let g:indentLine_bgcolor_gui = '#FF5F00'
let g:indentLine_char = '┆'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileType = ['python']

"===============================\ rainbow /===============================
""https://github.com/luochen1990/rainbow/blob/master/README_zh.md
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
            \    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \    'operators': '_,_',
            \    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \    'separately': {
            \        '*': {},
            \        'tex': {
            \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \        },
            \        'lisp': {
            \            'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \        },
            \        'vim': {
            \            'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \        },
            \        'perl': {
            \            'syn_name_prefix': 'perlBlockFoldRainbow',
            \        },
            \        'stylus': {
            \            'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
            \        },
            \        'html': {
            \            'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \        },
            \        'markdown': 0,
            \        'vimwiki': 0,
            \        'nerdtree': 0,
            \    }
            \}

"===========================\ vim-autoformat /============================
nnoremap \\f :Autoformat<CR>
let g:formatdef_custom_js = '"js-beautify -t"'
let g:formatters_javascript = ['custom_js']
au BufWrite *.js :Autoformat

"==============================\ goyo.vim /===============================
command! Zen Goyo 85%x85%

"========================\ thesaurus_query.vim /==========================
""If default keymapping is used.
let g:tq_map_keys = 0
noremap  <Leader>cw :ThesaurusQueryReplaceCurrentWord <CR>
"vnoremap  <Leader> cs y:ThesaurusQueryReplace <Cr>
""https://www.openoffice.org/lingucomponent/MyThes-1.zip
let g:tq_openoffice_en_file="~/.config/nvim/thesaurus/th_en_US_new"
""http://www.gutenberg.org/files/3202/files/
let g:tq_mthesaur_file="~/.config/nvim/thesaurus/mthesaur.txt"
""http://www.datamuse.com/
let g:tq_cilin_txt_file="~/.config/nvim/thesaurus/cilin.txt"

"========================\ thesaurus_query.vim /==========================
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
" let g:Hexokinase_refreshEvents = ['BufWrite', 'BufRead']
let g:Hexokinase_refreshEvents = ['BufWrite', 'BufRead', 'InsertLeave']
" Do not scraped any terminal buffers.
let g:Hexokinase_termDisabled = 1
" Which FileTypes not to scrape.
" let g:Hexokinase_ftDisabled = []
" Which FileTypes to scrape automatically.
" let g:Hexokinase_ftEnabled = ['css', 'html', 'javascript']

"==============================\ suda.vim /===============================
" let g:suda#prefix = 'sudo:'

"============================\ calendar.vim /=============================
"noremap \\c :Calendar -position=here<CR>
noremap <silent> \\c :Calendar -task -view=days -cyclic_view -position=here<CR>
let g:calendar_skip_task_delete_confirm = 1
let g:calendar_skip_event_delete_confirm = 1
let g:scalendar_kip_task_clear_completed_confirm = 1
" let g:calendar_yank_deleting = 0
let g:calendar_task_delete = 1
let g:calendar_cache_directory = '~/.config/nvim/.cache/calendar.vim/'
command! HCalendar echo
            \"EVENT: dd-mm-yyyy HH:MM - dd-mm-yyyy HH:MM [event-title] (little endian, \"-\" separator)\n".
            \"EVENT: 23-10-2014 10:00 - 25-10-2014 21:00 [event-title] (little endian, \"-\" separator)\n".
            \"TASK: yyyy-mm-dd [task-title] note: [task-note]\n".
            \"TASK: 2014-10-23 [task-title] note: [task-note]"

" let g:calendar_google_calendar = 1
" let g:calendar_google_task = 1

"===========================\ vim-translator /============================
nnoremap <silent> <leader>t :TranslateW<cr>
vnoremap <silent> <leader>t :Translate<cr>
noremap <silent> <leader>r :TranslateR<cr>
" let g:translator_target_lang = 'zh'
" let g:translator_source_lang = 'auto'
" let g:translator_default_engine = [...]
" let g:translator_proxy_url = 'socks5://127.0.0.1:1080'
let g:translator_history_enable = 1
let g:translator_window_type = 'popup'
let g:translator_window_max_width = 0.6*&columns
" let g:translator_window_max_height = 0.6
" let g:translator_window_borderchars = ['─','│','─','│','┌','┐','┘','└']

"=============================\ vimwiki /=================================
""Mappings: home/aloha/.config/nvim/ftplugin/vimwiki.vim
" let g:vimwiki_key_mappings = { 'all_maps': 0, }
let g:vimwiki_list = []
let g:vimwiki_conceal_pre = 1
let g:vimwiki_use_calendar = 1
call add(g:vimwiki_list, {
            \'path': '~/Shared/vimwiki/',
            \'diary_index': 'diary',
            \'diary_header': 'Diary',
            \'diary_rel_path': 'diary/',
            \'syntax': 'markdown',
            \'ext': '.md',
            \'links_space_char': '_',
            \'makhi': 1,
            \'auto_tags': 1,
            \'auto_diary_index': 0,
            \'auto_generate_links': 1,
            \'auto_generate_tags': 1,
            \'exclude_files': ['**/README.md'],
            \})
"auto_tags:          automatically update the tags metadata when current wiki page is saved
"auto_diary_index:   automatically update the diary index when opened.
"auto_genrate_links: automatically update generated links when the current wiki page is saved.
"auto_genrate_tags:  automatically update generated tags when the current wiki page is saved.
" augroup IndexAutoUpdate
"     au!
"     au BufEnter index.md,index.wiki write
"     " au BufEnter index.md,index.wiki VimwikiGenerateLinks
"     " au BufEnter index.md,index.wiki VimwikiGenerateTagLinks
" augroup END
" augroup DiaryAutoUpdate
"     au!
"     " au BufEnter diary.md,diary.wiki VimwikiGenerateTagLinks
"     "Delete old, insert new diary section into diary index file.
"     au BufEnter diary.md,diary.wiki VimwikiDiaryGenerateLinks
"     au BufEnter diary.md,diary.wiki write
" augroup END
" Exporting to html is only supported for original syntax
call add(g:vimwiki_list, {
            \'path': '~/vimwiki_origin/',
            \'path_html': '~/vimwiki_origin/export/',
            \'syntax': 'default',
            \'ext': '.wiki',
            \'links_space_char': '_',
            \'auto_toc': 1,
            \'auto_tags': 1,
            \'auto_diary_index': 0,
            \'auto_generate_links': 1,
            \'auto_generate_tags': 1,
            \'exclude_files': ['**/README.md'],
            \})
            " \'nested_syntaxes': {'c++': 'cpp', 'cpp': 'c++'}
            " \'template_path': '~/vimwiki/templates/',
            " template_default    default
let g:vimwiki_diary_months = {
      \ 1: '一月 January', 2: '二月 February', 3: '三月 March',
      \ 4: '四月 April', 5: '五月 May', 6: '六月 June',
      \ 7: '七月 July', 8: '八月 August', 9: '九月 September',
      \ 10: '十月 October', 11: '十一月 November', 12: '十二月December'
      \ }
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_folding = 'expr'
let g:vimwiki_markdown_link_ext = 1  "将 g:vimwiki_list 中的 ext 添加到 "Link" 的末尾
""Recommend to set when 'wrap' is seted.
let g:vimwiki_table_reduce_last_col = 0
let g:vimwiki_dir_link = 'main'
let g:vimwiki_toc_header = 'Table of Contents'
let g:vimwiki_toc_header_level = 2
let g:vimwiki_html_header_numbering = 2
let g:vimwiki_links_header = 'Generated Links'
let g:vimwiki_links_header_level = 2
let g:vimwiki_tags_header = 'Generated Tags'
let g:vimwiki_tags_header_level = 2
let g:vimwiki_auto_header = 1
let g:vimwiki_markdown_header_style = 1
"Use table-mode instead
let g:vimwiki_table_auto_fmt = 1
let g:vimwiki_key_mappings = {
            \'table_format': 1,
            \'table_mappings': 1,
            \}
"Prevent any link shortening
let g:vimwiki_url_maxsave = 0
""Toggle creation of temporary wikis.
let g:vimwiki_global_ext = 1
let g:vimwiki_ext2syntax = {
            \'.md': 'markdown', '.mkdn': 'markdown',
            \'.mdwn': 'markdown', '.mdown': 'markdown',
            \'.markdown': 'markdown', '.mw': 'media'
            \}


"=============================\ nvim-treesitter /=================================
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

""utf-8 icons \u259* ... \u2756
"▐ ░ ▒ ▓ ▔ ▕ ▖ ▗ ▘ ▙ ☁ ☂ ☃ ☄ ★ ☆ ☇ ☈ ☉ ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▉ "
"╰ ╱ ╲ ╳ ╴ ╵ ╶ ╷ ╸ ╹ ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ═ ║ ╒ ╓ ╔ ╕ ╖ ╗ ╘ ╙ "
"╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┠ ┡ ┢ ┣ ┤ ┥ ┦ ┧ ┨ ┩ "
"┐ ┑ ┒ ┓ └ ┕ ┖ ┗ ┘ ┙ ─ ━ │ ┃ ┄ ┅ ┆ ┇ ┈ ┉
"⌘ ❖ ❀ ❁ ✿ ✾ ⌖ ⚙ ⌚⌛⌬ ⌭ ⌮  ⌯  ⌰ ⌱ ⌲ ⌳ ⌴ ⌵ ⌶ ⌷ ⌸ ⌹ ﴿"
"♔ ♕ ♖ ♗ ♘ ♙ ♚ ♛ ♜ ♝ ♞ ♟ "
"⎗ ⎘ ⎙ ⎚ ⏍ ⏻ 🗂 "
"|¦┊
"================= Adjust conceal characters' highlighting ===============
function s:set_hi_conceal()
    if &filetype == 'tex'
        hi link Conceal texAccent
    else
        exe 'hi Conceal '.g:hi_normal
    endif
endfunction
" au BufEnter * call s:set_hi_conceal()


"=============== Set extra options when running in GUI mode ==============
if has("gui_running")
    " set guifont=JetBrainsMono\ Nerd\ Font\ Mono:h12:cANSI:qDRAFT
    set guifont=PragmataPro\ Mono:h12:cANSI:qDRAFT
    set gfw=黑体:h13:cGB2312
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=m
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
endif

"================ Use Unix as the standard file type =====================
set fileformats=unix,dos,mac

"================ Highlighting a selection on yank =======================
" au! TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150}


"#########################################################################
"##########################\ Search and Replace /#########################
"#########################################################################
set ignorecase smartcase            " 只有小写时忽略大小写
set hlsearch                        " 高亮搜索结果
set incsearch                       " 增量搜索
set magic                           " 开启 magic 模式

""可视化模式下任然可以使用 */# 向后/前搜索选中的文本.From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

""Find and focus.
nnoremap n nzz
nnoremap N Nzz

""Clear highlight when <leader><cr> is pressed
nnoremap <silent> <esc> :nohl<cr>

""When you press <leader>r you can search and replace the selected text
"vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>


"#########################################################################
"################\ Moving around, Tabs, Windows and Buffers /#############
"#########################################################################

"============================ Moving around ==============================
""Fast moving
nnoremap J 5j
nnoremap K 5k
xnoremap J 5j
xnoremap K 5k

""Moving more convenient when lines wrap
" nnoremap j gj
" nnoremap k gk
" xnoremap j gj
" xnoremap k gk

""Moving using <M-S-j/k>
au VimEnter * call SwitchMotionMod()
nnoremap <silent> \\ :call SwitchMotionMod()<CR>

""Remap VIM 0 to first non-blank character
" nnoremap ^ g0
" nnoremap g0 ^
" nnoremap 0 g^
" nnoremap g^ 0

""Move a line of text using ALT+[jk] or Command+[jk]
""Thus you should not use mark 'z'
nnoremap <M-k> mz:m-2<cr>`z
nnoremap <M-j> mz:m+<cr>`z
xnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
xnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

nnoremap <M-l> "zxl"zP
nnoremap <M-h> "zxh"zP
xnoremap <M-l> "zxl"z`<v`>P
xnoremap <M-h> "zxh"zP`<v`>

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

""For insert mode
inoremap <M-h> <Left>
inoremap <M-l> <Right>
inoremap <M-k> <Up>
inoremap <M-j> <Down>
inoremap <M-a> <Home>
inoremap <M-d> <End>

""For command mod
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"============================ windows related ============================
""Moving around windows.
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
" noremap <silent> <leader>sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
" noremap <silent> <leader>sj :set splitbelow<CR>:split<CR>
" noremap <silent> <leader>sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
" noremap <silent> <leader>sl :set splitright<CR>:vsplit<CR>
" <C-w>v/s <C-w>_/|/=

" Resize splits with arrow keys
noremap <silent> <up> :res +5<CR>
noremap <silent> <down> :res -5<CR>
noremap <silent> <left> :vertical resize-5<CR>
noremap <silent> <right> :vertical resize+5<CR>

"============================ buffers related ============================

""关闭缓冲区，保留窗口
nnoremap <leader>bd :call g:BufcloseCloseIt()<cr>
""Close all the buffers
nnoremap <leader>ba :bufdo bd<cr>
""Close all the other buffers
""https://blog.csdn.net/magicpang/article/details/2308167
nnoremap <leader>bo :call DeleteAllBuffersInWindow('noforce')<cr>
nnoremap <leader>BO :call DeleteAllBuffersInWindow('force')<cr>

nnoremap <silent> = :bnext<cr>
nnoremap <silent> - :bprevious<cr>
nnoremap <silent> ]b :bnext<cr>
nnoremap <silent> [b :bprevious<cr>
nnoremap <silent> ]B :blast<cr>
nnoremap <silent> [B :bfirst<cr>
nnoremap <silent> <c-b>n :bnext<cr>
nnoremap <silent> <c-b><c-n> :bnext<cr>
nnoremap <silent> <c-b>p :bprevious<cr>
nnoremap <silent> <c-b><c-p> :bprevious<cr>

""快速切换到当前编辑的缓冲区中的文件所在的目录
noremap <leader>. :cd %:p:h<cr>pwd<cr>

cnoremap <expr> %% getcmdtype()==':' ? expand('%:p:h').'/' : '%%'

""Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry

""打开文件时自动将光标移动到上次光标所在的位置
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"=========== 打开文件或切换缓冲区时自动将光标移动到上次的位置 ============
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
function s:position_load()
    if !exists('s:positions')
        let s:positions = {}
    endif
    if !has_key(s:positions, bufnr())
        " echo 'add a key'
        let s:positions[bufnr()] = [line("'\""), col("'\"")]
    endif
    " echo 'jump to' s:positions[bufnr()]
    call cursor(s:positions[bufnr()])
endfunction

function s:position_save()
    let l:cursor_posi = getcurpos()
    let s:positions[bufnr()] = l:cursor_posi[1:2]
    " echo s:positions
    " echo 'position saved:' s:positions[bufnr()]
endfunction

au BufEnter,WinEnter * call s:position_load()
au BufLeave,WinLeave * call s:position_save()

"=============================== tabs related ============================
""Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tm :tabmove<space>
nnoremap + :tabnext<cr>
nnoremap _ :tabprevious<cr>
nnoremap <c-t>n :tabnext<cr>
nnoremap <c-t><c-n> :tabnext<cr>
nnoremap <c-t>p :tabprevious<cr>
nnoremap <c-t><c-p> :tabprevious<cr>
nnoremap ]t gt<cr>
nnoremap [t gT<cr>
nnoremap ]T :tablast<cr>
nnoremap [T :tabfirst<cr>

""Let '<leader>tt' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <Leader>tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

""Opens a new tab with the current buffer's path
""Super useful when editing files in the same directory
nnoremap <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/


"#########################################################################
"############################\ Keys and Mappings /########################
"#########################################################################

"---------------------------------------------------------------------------"
" Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
"------------------|--------|--------|---------|--------|--------|----------|
" map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
" nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
" vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
" omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
" xmap / xnormap   |    -   |   -    |    -    |   @    |   -    |    -     |
" smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
" map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
" imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
" cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
"---------------------------------------------------------------------------"

"============================== 保存和退出 ===============================
" Fast saving & quitting
" nnoremap <silent> <leader>w :w<cr>
" nnoremap <leader>q :q<cr>

" :W sudo saves the file(use suda.vim instead)
" command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"================== 折叠命令syntax/indent模式 (vim 自带) =================
" zc 折叠
" zC 对所在范围内所有嵌套的折叠点进行折叠
" zo 展开折叠
" zO 对所在范围内所有嵌套的折叠点展开
" [z 到当前打开的折叠的开始处。
" ]z 到当前打开的折叠的末尾处。
" zj 向下移动到达下一个折叠的开始处。关闭的折叠也被计入。
" zk 向上移动到前一折叠的结束处。关闭的折叠也被计入。
" zR 打开全部折叠
" zM 关闭所有折叠
" zd 删除光标所在的折叠
" zE 删除所有折叠

"================================ 窗口操作 ===============================
" " 1. <leader>+空格 切换全屏和小屏
" "    For GVim on windows.
" if has("win32") && has("gui_running")
"     nnoremap <leader><space> :call ToggleFullScreen()<cr>
" endif
"
" let g:make_full_screen = 1
"     if has("win32") && has("gui_running") && g:make_full_screen == 1
"     au VimEnter * call FullScreen()
" endif
"
" " 2. Bwin/Swin转换屏幕显示内容（也会改变Gvim窗口大小）
" " 注意 Bwin 会打开 NERDTree 和 Tagbar
" command! Bwin call BigWindow()
" command! Swin call SmallWindow()

" 3. 打开终端
""根据窗口宽高比自动在垂直/水平窗口打开终端
""你可以在functions.vim找到该函数并调整参数
nnoremap <leader>ter :call OpenTerminalSmartly()<cr>
""在neovim中进入终端时自动进入终端模式(C-\+C+N退出)
" if has('nvim')
"     autocmd TermOpen * startinsert
" endif
"" Alt+q 返回终端normal模式
tnoremap <M-q> <C-\><C-n>

""4. Browse files
nnoremap <silent><leader><CR> :e .<cr>

"================================ 复制粘贴 ===============================
nnoremap <C-c> "+yW""yW
vnoremap <C-c> "+ygv""y

"================================ 其他操作 ===============================
nnoremap <leader>H :vert h<space>

""这个设置会使输入 i 的时候有一定延迟
" inoremap ii <esc>
nnoremap Y y$

noremap ; :
noremap : ;

nnoremap <leader>o mzo<esc>`z
nnoremap <leader>O mzO<esc>`z

imap <M-BS> <Del>

""使用虚拟替换模式
" nnoremap R gR
" nnoremap gR R
" nnoremap r gr
" nnoremap gr r


"#########################################################################
"######################\ Status Line and CmdLine /########################
"#########################################################################

set shortmess="atAF"                   " 简化显示信息, 避免烦人的确认信息，详见 :h shm
""Always show the status line
set laststatus=2
set ruler                           " 在状态栏显示当前所在的文件位置

set cmdheight=1                     " Make command line Two line high
set showcmd                         " normal模式下在vim命令行右边显示按键

""设置数字栏左侧的 signcolumn 总是显示
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif
set signcolumn=yes

"============================= wildmenu 设置 =============================
set wildmenu                        " 命令模式下，在状态栏中显示vim补全选项
set wildmode=longest:full,full
" set wildmode=longest:list,full
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


"#########################################################################
"######################\ Vim Configuration Files /########################
"#########################################################################

"if has("win16") || has("win32") && has('gui_running')
"    autocmd! bufwritepost $VIMRUNTIME/.vimrc source $VIMRUNTIME/.vimrc
"elseif has("linux")
"    autocmd! bufwritepost ~/.vimrc source ~/.vimrc
"endif

command! SO source $MYVIMRC

"#########################################################################
"###############################\ Misc /##################################
"#########################################################################

" Automatically clean extra spaces
autocmd BufWritePre *.c,*.cpp,*.h,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
" map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
" map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
" map <leader>pp :setlocal paste!<cr>

" Use Showhi to show hlgroup
command! Showhi echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"


"#########################################################################
"###############################\ Neovide/ ###############################
"#########################################################################
let g:neovide_transparency=0.95