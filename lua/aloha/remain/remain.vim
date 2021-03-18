"==== Delete trailing white space on save, useful for some filetypes =====
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
autocmd BufWritePre *.c,*.cpp,*.h,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

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

"================================ 移动模式 ===============================
function! g:SwitchMotionMod()
    if !exists("g:motionMod") || g:motionMod == 1
        noremap <S-M-j> 5<C-y>
        noremap <S-M-k> 5<C-e>
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
function! g:GetSID()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction
"======================= Choose Window with Filter =======================
let g:choosewin_ignore_filetypes = []
function! ChooseWin(...)
    let l:wins = range(1,winnr('$'))
    if a:0 == 0
        let l:available_windows = filter(l:wins, 'index(g:choosewin_ignore_filetypes, getbufvar(winbufnr(v:val), "&filetype")) == -1')
    else
        let l:available_windows = filter(l:wins, 'index(a:000[0], getbufvar(winbufnr(v:val), "&filetype")) == -1')
    endif
    return choosewin#start(l:available_windows, { 'auto_choose': 1, 'hook_enable': 0 })
endfunction

au BufRead,BufNewFile *.vs setfiletype glsl
au BufRead,BufNewFile *.fs setfiletype glsl

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
command! Hundotree echo
            \"=== \<leader\>ut to start, ? to see help. Addition: ===\n".
            \"  u     _ NextState\n".
            \"  e     _ PreviousState\n".
            \"  U     _ NextState\n".
            \"  E     _ PreviousState"
command! Hvista echo
            \"=== \<leader\>vt to start, ,T to use finder. ===\n".
            \"  Enter       - jump to the tag under the cursor.\n".
            \"  p           - preview the tag under the context via the floating window if it's avaliable.\n".
            \"  s           - sort the symbol alphabetically or the location they are declared.\n".
            \"  q           - close the vista window."
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
command! Hsuda vert h suda-usage
command! Hfzf vert h fzf-vim-commands
command! Hfar vert h far-usage
command! Hvisualmulti echo "Use '[n]vim -Nu path/to/visual-multi/tutorialrc' for quick start."
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

command! Haigt echo
            \"J			<Plug>(agit-scrolldown-stat)".
            \"K			<Plug>(agit-scrollup-stat)".
            \"<C-j>			<Plug>(agit-scrolldown-diff)".
            \"<C-k>			<Plug>(agit-scrollup-diff)".
            \"u			<PLug>(agit-reload)".
            \"yh			<Plug>(agit-yank-hash)".
            \"<C-g>			<Plug>(agit-print-commitmsg)".
            \"q			<Plug>(agit-exit)".
            \"C			<Plug>(agit-git-checkout)".
            \"cb			<Plug>(agit-git-checkout-b)".
            \"D			<Plug>(agit-git-branch-d)".
            \"rs			<Plug>(agit-git-reset-soft)".
            \"rm			<Plug>(agit-git-reset)".
            \"rh			<Plug>(agit-git-reset-hard)".
            \"rb			<Plug>(agit-git-rebase)".
            \"ri			<Plug>(agit-git-rebase-i)".
            \"di			<Plug>(agit-diff)".
            \"dl			<Plug>(agit-diff-with-local)"

"#########################################################################
"############################\ User Interface /###########################
"#########################################################################
"==============================\ undotree /===============================
function g:Undotree_CustomMap()
    nnoremap <buffer> n <plug>UndotreeNextState
    nnoremap <buffer> p <plug>UndotreePreviousState
    nnoremap <buffer> N 5<plug>UndotreeNextState
    nnoremap <buffer> P 5<plug>UndotreePreviousState
endfunc

"==============================\ defx.nvim /==============================
function! Root(path) abort
      return fnamemodify(a:path, ':t')
endfunction

augroup user_plugin_defx
    autocmd!
    autocmd FileType defx call <SID>defx_mappings()
    autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdel | endif
    autocmd TabLeave * if &filetype == 'defx' | wincmd w | endif
augroup END

function! s:SID_PREFIX() abort
    return matchstr(expand('<sfile>'),
    \ '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

let g:sid = s:SID_PREFIX()

function! s:jump_dirty(dir) abort
    let l:icons = get(g:, 'defx_git_indicators', {})
    let l:icons_pattern = join(values(l:icons), '\|')
    if ! empty(l:icons_pattern)
        let l:direction = a:dir > 0 ? 'w' : 'bw'
        return search(printf('\(%s\)', l:icons_pattern), l:direction)
    endif
endfunction

function! s:defx_toggle_tree_or_drop() abort
    if defx#is_directory()
        return defx#do_action('open_or_close_tree')
    endif
    return defx#do_action('multi', ['drop'])
endfunction

function! s:defx_cd_or_drop(context) abort
    if defx#is_directory()
        return defx#call_action('cd', a:context.targets[0])
    endif
    return defx#call_action('multi', ['drop'])
endfunction

function! s:defx_choosewin(context) abort
    if defx#is_directory()
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
        execute('FloatermNew --title='.l:name)
        execute('FloatermToggle '.l:name)
        execute('FloatermSend ' . a:context.targets[0])
        execute('FloatermToggle '.l:name)
    else
        execute('FloatermSend --name=' . l:name . ' ' . a:context.targets[0])
        execute('FloatermToggle '.l:name)
    endif
endfunction

function! s:defx_mappings() abort
    setlocal signcolumn=no expandtab
    nnoremap <silent><buffer><expr> j                 line('.') == line('$') ? 'go' : 'j'
    nnoremap <silent><buffer><expr> k                 line('.') == 1 ? 'G<home>' : 'k'
    nnoremap <silent><buffer><expr> J                 line('.') == line('$') ? 'go' : '5j'
    nnoremap <silent><buffer><expr> K                 line('.') == 1 ? 'G<home>' : '5k'
    nnoremap <silent><buffer><expr> <CR>              defx#do_action('call', g:sid.'defx_choosewin')
    nnoremap <silent><buffer><expr> l                 defx#do_action('call', g:sid.'defx_cd_or_drop')
    nnoremap <silent><buffer><expr> o                 <sid>defx_toggle_tree_or_drop()
    nnoremap <silent><buffer><expr> t                 defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
    nnoremap <silent><buffer><expr> s                 defx#do_action('open', 'botright split')
    nnoremap <silent><buffer><expr> v                 defx#do_action('open', 'botright vsplit')
    nnoremap <silent><buffer><expr> q                 defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Esc>             defx#do_action('quit')
    nnoremap <silent><buffer><expr> <C-r>             defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>             defx#do_action('print')
    nnoremap <silent><buffer><expr><nowait> c         defx#do_action('copy')
    nnoremap <silent><buffer><expr><nowait> x         defx#do_action('move')
    nnoremap <silent><buffer><expr><nowait> m         defx#do_action('move')
    nnoremap <silent><buffer><expr><nowait> p         defx#do_action('paste')
    nnoremap <silent><buffer><expr><nowait> r         defx#do_action('rename')
    nnoremap <silent><buffer><expr> n                 defx#do_action('new_file')
    nnoremap <silent><buffer><expr> N                 defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> M                 defx#do_action('new_multiple_files')
    nnoremap <silent><buffer>  <                      :<C-u>call <SID>jump_dirty(-1)<CR>
    nnoremap <silent><buffer>  >                      :<C-u>call <SID>jump_dirty(1)<CR>
    nnoremap <silent><buffer><expr> b                 winnr('$') != 1 ? ':<C-u>wincmd w<CR>'
                                                          \ : ':<C-u> Defx -buffer-name=temp -split=vertical<CR>'
    nnoremap <silent><buffer><expr> cd                defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr><nowait> %         defx#do_action('cd', getcwd())
    nnoremap <silent><buffer><expr> ~                 defx#async_action('cd')
    nnoremap <silent><buffer><expr> <BS>              defx#async_action('cd', ['..'])
    nnoremap <silent><buffer><expr> h                 defx#async_action('cd', ['..'])
    nnoremap <silent><buffer><expr> 2h                defx#do_action('cd', ['../..'])
    nnoremap <silent><buffer><expr> 3h                defx#do_action('cd', ['../../..'])
    nnoremap <silent><buffer><expr> 4h                defx#do_action('cd', ['../../../..'])
    nnoremap <silent><buffer><expr><nowait> <Space>   defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> <C-j>             defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> <C-k>             defx#do_action('toggle_select') . 'k'
    nnoremap <silent><buffer><expr> <C-a>             defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> S                 defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> C                 defx#do_action('toggle_columns', 'mark:indent:icon:filename')
    nnoremap <silent><buffer><expr> !                 defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> ex                defx#do_action('call', g:sid.'defx_execute')
    nnoremap <silent><buffer><expr> P                 defx#do_action('preview')
    nnoremap <silent><buffer><expr> H                 defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> yy                defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .                 defx#do_action('repeat')
endfunction

"============================\ vista.vim /=============================
autocmd FileType vista,vista_kind nnoremap <buffer> <silent> f :<c-u>call vista#finder#fzf#Run()<CR>
"#########################################################################
"########################\ Color and Highlighting /#######################
"#########################################################################
" let g:cpp_class_scope_highlight = 1
" let g:cpp_member_variable_highlight = 1
" let g:cpp_class_decl_highlight = 1
" let g:cpp_posix_standard = 1
" let g:cpp_experimental_template_highlight = 1
" let g:cpp_concepts_highlight = 1
" let c_no_curly_error=1
"===========================\ vim-illuminate /============================
let g:Illuminate_delay = 250
let g:Illuminate_highlightUnderCursor = 1
let g:Illuminate_ftblacklist = ['nerdtree']
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline
augroup END
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi illuminatedCurWord cterm=italic gui=italic
augroup END
let g:Illuminate_insert_mode_highlight = 1
nnoremap ,<cr> :IlluminationToggle<cr>
hi! link illuminatedWord Visual
"#########################################################################
"##########################\ Search and Replace /#########################
"#########################################################################
"===============================\ fzf.vim /===============================
let g:fzf_command_prefix = 'Fzf'
noremap ,p :FzfFiles<CR>
noremap ,b :FzfBuffers<CR>
noremap ,l :FzfLines<CR>
noremap ,g :FzfRg<CR>
let g:fzf_tags_command = 'ctags -R -o .ctags'
noremap ,t :FzfTags<CR>
noremap ,h :FzfHistory<CR>
noremap ,; :FzfHistory:<CR>
noremap ,/ :FzfHistory/<CR>
command! FzfMapsn <plug>(fzf-maps-n)
command! FzfMapsi <plug>(fzf-maps-i)
command! FzfMapsx <plug>(fzf-maps-x)
command! FzfMapso <plug>(fzf-maps-o)
command! -bang -nargs=* FzfGit
            \ call fzf#vim#grep(
            \     'git grep --line-number -- '.shellescape(<q-args>), 0,
            \ fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

let g:fzf_layout = {'down':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
function! s:list_buffers()
    redir => list
    silent ls
    redir END
    return split(list, "\n")
endfunction
function! s:delete_buffers(lines)
    execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction
"============================\ fzf-gitignore /=============================
noremap <LEADER>gi :FzfGitignore<CR>
"============================\ any-jump.vim /=============================
let g:any_jump_references_enabled = 1
let g:any_jump_grouping_enabled = 1
let g:any_jump_preview_lines_count = 5
let g:any_jump_max_search_results = 7
let g:any_jump_results_ui_style = 'filename_first'
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9
let g:any_jump_colors = {
            \}
"============================\ far.vim /=============================
noremap <LEADER>f :F<space><space>**/*
            \<left><left><left><left><left>
if has('nvim')
    let g:far#source = 'rgnvim'
else
    let g:far#source = 'rg'
endif
let g:far#enable_undo = 1
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
let g:coc_global_extensions = [
            \ 'coc-diagnostic',
            \ 'coc-clangd',
            \ 'coc-tabnine',
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
            \ 'coc-explorer'
            \ ]
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
inoremap <silent><expr> <C-c> pumvisible() ?
            \ coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
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
nnoremap <leader>ce :CocCommand explorer<CR>
nnoremap <silent> <leader>g[ <Plug>(coc-diagnostic-prev)
nnoremap <silent> <leader>g] <Plug>(coc-diagnostic-next)
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
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
nmap <leader>rn <Plug>(coc-rename)
xmap \\f  <Plug>(coc-format-selected)
nmap \\f  <Plug>(coc-format-selected)
augroup mygroup
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
nmap <leader>F  <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" let lua_lsp = glob('~/.vscode/extensions/sumneko.lua*', 0, 1)
" if len(lua_lsp)
"     let lua_lsp = lua_lsp[-1] . '/server'
"     call coc#config('languageserver', {
"         \ 'lua-language-server': {
"         \     'cwd': lua_lsp,
"         \     'command': lua_lsp . '/bin/lua-language-server.exe',
"         \     'args': ['-E', '-e', 'LANG="zh-cn"', lua_lsp . '/main.lua'],
"         \     'filetypes': ['lua'],
"         \ }
"     \ })
" endif
"=========================\ completion-nvim /==========================
"============================\ ultisnips /=============================
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"#########################################################################
"############################\ Debug & Tasks /############################
"#########################################################################
"============================\ vimspector /=============================
" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools']
" let g:vimspector_base_dir='/home/aloha/.config/nvim/settings/vimspector'
" command! Launch   call vimspector#Launch()
" command! Continue call vimspector#Continue()
" command! Pause    call vimspector#Pause()
" command! Stop     call vimspector#Stop()
" command! Restart  call vimspector#Restart()
" map <silent> <F5>  <Plug>VimspectorStepOver
" map <silent> <F6>  <Plug>VimspectorStepInto
" map <silent> <F7>  <Plug>VimspectorStepOut
" map <silent> <F8>  <Plug>VimspectorToggleBreakpoint
" map <silent> <F9>  <Plug>VimspectorToggleConditionalBreakpoint
" map <silent> <F10> <Plug>VimspectorAddFunctionBreakpoint
" sign define vimspectorBP text=◉  texthl=ColorColumn
" sign define vimspectorBPDisabled text=○  texthl=ColorColumn
" sign define vimspectorBPCond text=♦  texthl=ColorColumn
" sign define vimspectorPC text=➤➤ texthl=ColorColumn
"+-------------------------------------------------------------------------------------+
"|                             \ asyncrun asyncrun_extra /                             |
"+-------------------------------------------------------------------------------------+
let g:asyncrun_rootmarks = ['.git', '.svn', '.root']
let g:asyncrun_extra#floaterm#title_style = 'asyncrun'
""move to https://github.com/skywind3000/asyncrun.extra/blob/master/plugin/asyncrun_extra.v
" function! g:Asyncrun_floaterm(opts)
"     " echo a:opts
"                     " \ ' --wintype=float' .
"                     " \ ' --height=0.5' .
"                     " \ ' --width=0.5' .
"     execute 'FloatermNew --position=bottomright' .
"                     \ ' --title=Aysnctasks:\ ' . a:opts.name .
"                     \ ' --autoclose=0' .
"                     \ ' --cwd=' . a:opts.cwd
"                     \ ' ' . a:opts.cmd
"     " Do not focus on floaterm window, and close it once cursor moves
"     " If you want to jump to the floaterm window, use <C-w>p
"     " You can choose whether to use the following code or not
"     stopinsert | noa wincmd p
"     augroup close-floaterm-runner
"         autocmd!
"         autocmd CmdlineEnter,CursorMoved,InsertEnter * ++nested
"             \ call timer_start(100, { -> s:close_floaterm_runner() })
"     augroup END
" endfunction
"
" function! s:close_floaterm_runner() abort
"     if &ft == 'floaterm' | return | endif
"     for b in tabpagebuflist()
"         if getbufvar(b, '&ft') == 'floaterm' &&
"             \ getbufvar(b, 'floaterm_jobexists') == v:false
"         execute b 'bwipeout!'
"         break
"         endif
"     endfor
"     autocmd! close-floaterm-runner
" endfunction
" let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
" let g:asyncrun_runner.floaterm = function('g:Asyncrun_floaterm')

"============================\ asynctasks.vim /=============================
let g:asynctasks_term_pos = 'floaterm'
let g:asynctasks_extra_config = [
            \ '~/.config/nvim/settings/asynctask/tasks.ini',
            \ ]
let g:asynctasks_environ = {
            \ 'my_name': 'aloha',
            \ 'cppc': '/usr/bin/g++',
            \ 'cc': '/usr/bin/gcc',
            \}
let g:asynctasks_template = {}
let g:asynctasks_template.cpp = [
    \ "[make]",
    \ "command=make $(VIM_FILENOEXT)",
    \ "output=terminal",
    \ "cwd=$(VIM_FILEDIR)",
    \ "save=2",
    \ "[run]",
    \ "command=$(VIM_PATHNOEXT)",
    \ "output=terminal",
    \ "cwd=$(VIM_FILEDIR)",
    \ "save=2",
    \ "[build]",
    \ "command:c=gcc -Wall $(VIM_FILENAME) -o $(VIM_PATHNOEXT)",
    \ "command:cpp=g++ -Wall $(VIM_FILENAME) -o $(VIM_PATHNOEXT)",
    \ "output=terminal",
    \ "cwd=$(VIM_FILEDIR)",
    \ "save=2",
    \ "[debug]",
    \ "command:c=gcc -Wall -g $(VIM_FILENAME) -o $(VIM_PATHNOEXT)",
    \ "command:cpp=g++ -Wall -g $(VIM_FILENAME) -o $(VIM_PATHNOEXT)",
    \ "output=terminal",
    \ "cwd=$(VIM_FILEDIR)",
    \ "save=2",
    \ "[compile]",
    \ "command:c=gcc -Wall -c $(VIM_FILENAME)",
    \ "command:cpp=g++ -Wall -c $(VIM_FILENAME)",
    \ "output=terminal",
    \ "cwd=$(VIM_FILEDIR)",
    \ "save=2"
    \ ]
let g:asynctasks_template.c = g:asynctasks_template.cpp
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

"============================\ vim-rooter /=============================
let g:rooter_patterns = ['.rooter', '.git']
let g:rooter_silent_chdir = 1
"#########################################################################
"#####################\ General Editing Enhancement /#####################
"#########################################################################
"============================\ vim-capslock /=============================
set statusline^=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}
"==========================\ vim-after-object /===========================
autocmd VimEnter * call after_object#enable([']', '['], '/', '=', ':', '-', '#', '*', ' ')
vnoremap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>
au FileType php let b:surround_45 = "<?php \r ?>"
au FileType tex let b:surround_108 = "\\begin{\1environment: \1}\r\\end{\1\r}.*\r\1}"
"===============================\ auto-pairs /============================
let g:AutoPairs = { '(': ')', '[': ']', '{': '}', "'": "'", '"': '"', '`': '`' }
au FileType * let b:AutoPairs = g:AutoPairs
au FileType html let b:AutoPairs['<'] = '>'
au FileType vim let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '`':'`', '<':'>'}
"#########################################################################
"###############################\ MarkDown /##############################
"#########################################################################
"===============================\ vimtex /================================
au FileType tex command! FzfTex call vimtex#fzf#run('ctli', g:fzf_layout)
"#########################################################################
"#############################\ Git Related /#############################
"#########################################################################
"============================\ vim-signify /==============================
highlight SignifySignAdd    ctermfg=green  guifg=#A6DB29
highlight SignifySignDelete ctermfg=red    guifg=#ff0000
highlight SignifySignChange ctermfg=yellow guifg=#ffff00
"#########################################################################
"#################################\ Msic /################################
"#########################################################################
"===============================\ rainbow /===============================
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
"==============================\ suda.vim /===============================
"===========================\ vim-translator /============================
"=============================\ vimwiki /=================================
""Mappings: home/aloha/.config/nvim/ftplugin/vimwiki.vim
" let g:vimwiki_key_mappings = { 'all_maps': 0, }
let g:vimwiki_list = []
let g:vimwiki_conceal_pre = 1
let g:vimwiki_use_calendar = 1
"auto_tags:          automatically update the tags metadata when current wiki page is saved
"auto_diary_index:   automatically update the diary index when opened.
"auto_genrate_links: automatically update generated links when the current wiki page is saved.
"auto_genrate_tags:  automatically update generated tags when the current wiki page is saved.
" augroup indexautoupdate
"     au!
"     au bufenter index.md,index.wiki write
"     " au bufenter index.md,index.wiki vimwikigeneratelinks
"     " au bufenter index.md,index.wiki vimwikigeneratetaglinks
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
            \ 'path': '~/vimwiki_origin/',
            \ 'path_html': '~/vimwiki_origin/export/',
            \ 'syntax': 'default',
            \ 'ext': '.wiki',
            \ 'links_space_char': '_',
            \ 'auto_toc': 1,
            \ 'auto_tags': 1,
            \ 'auto_diary_index': 0,
            \ 'auto_generate_links': 1,
            \ 'auto_generate_tags': 1,
            \ 'exclude_files': ['**/README.md'],
            \ 'template_path': '~/vimwiki_origin/templates/',
            \ 'template_default': 'default',
            \ 'template_ext': '.html',
            \ 'css_name': 'css/style.css',
            \ 'maxhi': 1,
            \'nested_syntaxes': {'c++': 'cpp'}
            \})
            " \'template_path': '~/vimwiki/templates/',
            " template_default    default
call add(g:vimwiki_list, {
            \ 'path': '~/vimwiki/',
            \ 'diary_index': 'diary',
            \ 'diary_header': 'Diary',
            \ 'diary_rel_path': 'diary/',
            \ 'syntax': 'markdown',
            \ 'ext': '.md',
            \ 'links_space_char': ' ',
            \ 'makhi': 1,
            \ 'auto_tags': 1,
            \ 'auto_diary_index': 0,
            \ 'auto_generate_links': 1,
            \ 'auto_generate_tags': 1,
            \ 'exclude_files': ['**/README.md']
            \})
let g:vimwiki_diary_months = {
      \ 1: '一月 January', 2: '二月 February', 3: '三月 March',
      \ 4: '四月 April', 5: '五月 May', 6: '六月 June',
      \ 7: '七月 July', 8: '八月 August', 9: '九月 September',
      \ 10: '十月 October', 11: '十一月 November', 12: '十二月December'
      \ }
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 2
let g:vimwiki_option_maxhi = 1
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







""设置透明背景
function! g:TransparentBg()
    hi Normal ctermbg=NONE guibg=NONE
    hi ColorColumn ctermbg=NONE guibg=NONE
endfunction

function! s:hi_adjust_onedark()
    let g:airline_theme = 'airlineish'
    call g:TransparentBg()
endfunction

au ColorScheme onedark call s:hi_adjust_onedark()

function! s:hi_adjust_molokai()
    let g:airline_theme = 'airlineish'
    hi VertSplit guibg=#1B1D1E
    call g:TransparentBg()
endfunction

au ColorScheme molokai call s:hi_adjust_molokai()

function! s:hi_adjust_codedark()
    let g:airline_theme = 'codedark'
    hi VertSplit guibg=#1B1D1E
    call g:TransparentBg()
endfunction

au ColorScheme molokai call s:hi_adjust_codedark()

colorscheme onedark
" colorscheme molokai

"============================ Moving around ==============================
au VimEnter * call SwitchMotionMod()
nnoremap <silent> \\ :call SwitchMotionMod()<CR>

"============================ buffers related ============================
nnoremap <leader>bd <Cmd>call g:BufcloseCloseIt()<cr>
nnoremap <leader>bo <Cmd>call DeleteAllBuffersInWindow('noforce')<cr>
nnoremap <leader>BO <Cmd>call DeleteAllBuffersInWindow('force')<cr>

"=========== 打开文件或切换缓冲区时自动将光标移动到上次的位置 ============
function s:position_load()
    if !exists('s:positions')
        let s:positions = {}
    endif
    if !has_key(s:positions, bufnr())
        let s:positions[bufnr()] = [line("'\""), col("'\"")]
    endif
    call cursor(s:positions[bufnr()])
endfunction
function s:position_save()
    let l:cursor_posi = getcurpos()
    let s:positions[bufnr()] = l:cursor_posi[1:2]
endfunction
au BufEnter,WinEnter * call s:position_load()
au BufLeave,WinLeave * call s:position_save()

nnoremap <leader>ter :call OpenTerminalSmartly()<cr>
command! Showhi echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"

"================================ Viminal ================================
function! OpenAsTerminal()
    terminal
    setlocal nonumber
endfunction

au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=false}


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
let s:get_fcitx_language_status = "fcitx5-remote"             "获取当前输入法的状态值
let s:set_fcitx_chinese         = "fcitx5-remote -o"          "把输入法设置为 中文
let s:set_fcitx_english         = "fcitx5-remote -c"          "把输入法设置为 英文

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

autocmd FileType tex,markdown,vimwiki setlocal spell


" auto save

augroup autosave
    au!
    au InsertLeave *.md,*.wiki silent update
    au TextChanged *.md,*.wiki silent update
augroup END

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
autocmd FileType vimwiki setlocal wrap

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
