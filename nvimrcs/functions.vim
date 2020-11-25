"+-----------------------------------------------------------------------+
"¦ Maintainer:     aloha                                                 ¦
"¦                                                                       ¦
"¦ License:        MIT                                                   ¦
"+-----------------------------------------------------------------------+

""======================== Preset helper functions =======================
""Get a random int number.
function! GetRandomInt()
    if has('nvim')
        ""How to get random int in nvim?
        "return RandomInt()
    else
        let b:seed = srand()
        return rand(b:seed)
    endif
endfunction

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
        call g:SwitchTheme(1)
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

" " Compile function
" nnoremap <leader>r :call <SID>CompileRunGcc()<CR>
" func! CompileRunGcc()
"     exec "w"
"     if &filetype == 'c'
"         exec "!g++ % -o %<"
"         exec "!time ./%<"
"     elseif &filetype == 'cpp'
"         set splitbelow
"         exec "!g++ -std=c++11 % -Wall -o %<"
"         :sp
"         :res -15
"         :term ./%<
"     elseif &filetype == 'java'
"         exec "!javac %"
"         exec "!time java %<"
"     elseif &filetype == 'sh'
"         :!time bash %
"     elseif &filetype == 'python'
"         set splitbelow
"         :sp
"         :term python3 %
"     elseif &filetype == 'html'
"         silent! exec "!".g:mkdp_browser." % &"
"     elseif &filetype == 'markdown'
"         exec "MarkdownPreview"
"     elseif &filetype == 'tex'
"         silent! exec "VimtexStop"
"         silent! exec "VimtexCompile"
"     elseif &filetype == 'dart'
"         exec "CocCommand flutter.run -d ".g:flutter_default_device
"         CocCommand flutter.dev.openDevLog
"     elseif &filetype == 'javascript'
"         set splitbelow
"         :sp
"         :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
"     elseif &filetype == 'go'
"         set splitbelow
"         :sp
"         :term go run .
"     endif
" endfunc

" ""找到较低的目录层级，然后删除之
" function RToc()
"     exe "/-toc .* -->"
"     let lstart=line('.')
"     exe "/-toc -->"
"     let lnum=line('.')
"     execute lstart.",".lnum."g/           /d"
" endfunction

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
autocmd BufNewFile,BufRead *.txt,*.text,[Rr][Ee][Aa][Dd][Mm][Ee] 
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
        echo 'Changed to Fixed mod.'
        noremap <S-M-j> 5jzz
        noremap <S-M-k> 5kzz
        let g:motionMod = 1
    endif
endfunction


"============================ Download images from url ===================
" ""g:UrlToLocal(url[, path[, name]])
" ""g:mdip_random_imgname
" ""g:mdip_imgformats(wrote in lowercase, also effective to uppercase)
" function! g:IsImage(name)
"     if !exists('g:mdip_imgformats')
"         let g:mdip_imgformats = ['bmp','jpg','png','tif','gif','pcx','tga','exif','fpx','svg','psd','cdr','pcd','dxf','ufo','eps','ai','raw','wmf','webp']
"     endif
"
"     " let l:mdip_imgformat_pattern = ''
"     " for item in g:mdip_imgformats
"     "     let l:mdip_imgformat_pattern = l:mdip_imgformat_pattern.'\|\(\.'.item.'\)'
"     " endfor
"     " let l:mdip_imgformat_pattern = l:mdip_imgformat_pattern[2:-1]
"     let l:name_pieces = split(a:name)
"     if len(l:name_pieces) == 1 ||
" endfunction
"
" function! g:UrlToLocal(url, ...)
"     if !exists('g:mdip_random_imgname')
"         let g:mdip_random_imgname = 0
"     endif
"     let l:path = './'
"     let l:name = ''
"     if a:0 <= 1                 "name is not given
"         let l:name = split(a:url, '/')[-1]
"         if l:name[-4:-1] !~? l:mdip_imgformat_pattern || g:mdip_random_imgname == 1
"             let l:name = system('date +%d_%m_%Y_%H%M%S')[0:-1].system('! echo $RANDOM')[0:-1].'.png'
"         endif
"     elseif a:0 == 2
"         let l:path = a:000[0]
"         if l:path[-1] != '/'
"             let l:path = l:path.'/'
"         endif
"         let l:name = a:000[1]
"         if l:name[-4:-1] !~? l:mdip_imgformat_pattern
"
"         endif
"     else
"         echoerr 'Wrong number of arguments.'
"         return -1
"     endif
"     ""path ends with '/'
"     call system('curl '.a:url.' -o '.l:path.' '.l:name)
"     return 0
" endfunction

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

