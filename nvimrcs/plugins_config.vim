"+-----------------------------------------------------------------------+
"¦ Maintainer:     aloha                                                 ¦
"¦                                                                       ¦
"¦ License:        MIT                                                   ¦
"¦                                                                       ¦
"¦ Sections:                                                             ¦
"¦                 -> Help Commands                                      ¦
"¦                 -> User Interface ( VIM-IDE )                         ¦
"¦                 -> Color and Highlighting                             ¦
"¦                 -> Search and Replace                                 ¦
"¦                 -> Completion and Syntax Checking                     ¦
"¦                 -> For Project                                        ¦
"¦                 -> General Editing Enhancement                        ¦
"¦                 -> MarkDown                                           ¦
"¦                 -> Terminal Improvement                               ¦
"¦                 -> Git Related                                        ¦
"¦                 -> Misc                                               ¦
"¦                 -> Abandoned Plugins                                  ¦
"¦                                                                       ¦
"+-----------------------------------------------------------------------+

""TODO:keith/investigate.vim

call plug#begin(g:main_runtimepath."plugins/")

"=========================================================================
""Description: A plugin to manage other plugins.
""Note: You need to create a link of plug.vim under nvim/autoload or .vim/autoloda
""Alternatives: Shougo/dein.vim(Async), VundleVim/Vundle.vim
Plug 'junegunn/vim-plug'


"#########################################################################
"############################\ Help Commands /############################
"#########################################################################

""Note: To get fullly mastered, read this file and plugins' docs.

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
" command! Hdefx echo
"             \"=== \<leader\>df to start.===\n".
"             \"  Enter       - open\n".
"             \"  c           - copy\n".
"             \"  x           - move\n".
"             \"  p           - paste\n".
"             \"  E           - open vsplit\n".
"             \"  P           - preview\n".
"             \"  o           - open tree toggle\n".
"             \"  N           - new directory\n".
"             \"  n           - new file\n".
"             \"  M           - new multiple files\n".
"             \"  S           - toggle sort by time\n".
"             \"  d           - remove\n".
"             \"  r           - rename\n".
"             \"  !           - execute command\n".
"             \"  ex          - execute system\n".
"             \"  yy          - yank path\n".
"             \"  .           - toggle ignored files\n".
"             \"  ;           - repeat\n".
"             \"  h           - cd ..\n".
"             \"  ~           - cd ~\n".
"             \"  q           - quit\n".
"             \"  s           - toggle select and up\n".
"             \"  *           - toggle select all\n".
"             \"  j           - down\n".
"             \"  k           - up\n".
"             \"  C-l         - redraw\n".
"             \"  C-g         - print\n".
"             \"  cd          - change vim cwd"

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

"=========================================================================
""Description: vim-which-key is vim port of emacs-which-key that displays available keybindings in popup.
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }


"#########################################################################
"############################\ User Interface /###########################
"#########################################################################

"=========================================================================
""Description: Vim Startup Interface
""Alternatives: hardcoreplayers/dashboard-nvim
Plug 'mhinz/vim-startify'
" e q <cr> | b s v t | B S V T <nums>/again |
":h startify-faq
"" Functions
" function! s:list_commits()
"     let git = 'git -C ~/repo'
"     let commits = systemlist(git .' log --oneline | head -n10')
"     let git = 'G'. git[1:]
" return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
" endfunction

function s:startify_vim_cfg()
    return [
                \ { 'line': "What's this?", 'cmd': 'echo "open a group of files."' },
                \ { 'line': 'Vim configuration files',
                \   'cmd': 'cd ~/.config/nvim/nvimrcs/ | e basic.vim | e filetypes.vim | e plugins_config.vim' },
                \ ]
endfunction

" function s:startify_defx()
"     return [
"                 \ {'line': 'Press 0 to open defx.', 'cmd': 'call g:Defx_toggle_with_my_options()'},
"                 \ ]
" endfunction
" call startify#open_buffers() |

""打开文件时自动将root目录切换为文件所在目录
""At the moment only git, hg, bzr and svn are supported.
let g:startify_change_to_vcs_dir=1
""打开文件时自动切换到文件所在目录
let g:startify_change_to_dir=0
""使用 Unicode 字符
let g:startify_fortune_use_unicode = 1
""左边空白的宽度
let g:startify_padding_left = 3
""指定 session 目录
let g:startify_session_dir = expand('$HOME/.config/nvim/.cache/startify')
""在退出Vim或加载新的session前保存当前session
let g:startify_session_persistence = 0
""自动加载session
let g:startify_session_autoload = 1
""过滤列表，支持正则表达式
let g:startify_skiplist = [
            \ '\.git',
            \ ]
""'file'和'dir'中的最大项目数量
let g:startify_files_number = 10
""Add your bookmarks here:
let g:startify_bookmarks = [
            \   '~/.config/nvim/plugins/vimspector/docs/schema/vimspector.schema.json',
            \   '~/.config/nvim/plugins/vimspector/docs/schema/gadgets.schema.json',
            \]
""Add Your commands here.
let g:startify_commands = [
            \ {'t': ['Press t to open NERDTree.', 'NERDTree']},
            \ ]
            " \ {'t': ['Press t to open defx.', 'call g:Defx_toggle_with_my_options()']},
" \ ':help reference',
" \ ['Vim Reference', 'h ref'],
" \ {'?': ['Vim Reference', 'h ref']},
" \ {'h': 'h ref'},
" \ {'m': ['My magical function', 'call Magic()']},
""菜单列表
let g:startify_lists = [
            \ { 'type': 'commands',                     'header': ['   Commands']            },
            \ { 'type': 'files',                        'header': ['   Recent Opened Files'] },
            \ { 'type': 'sessions',                     'header': ['   Sessions']            },
            \ { 'type': 'dir',                          'header': ['   PWD: '. getcwd()]     },
            \ { 'type': 'bookmarks',                    'header': ['   Bookmarks']           },
            \ ]
            "\ { 'type': function('s:startify_vim_cfg'), 'header': ['   FileGroups']          },
            "\ { 'type': function('s:startify_defx'),    'header': ['   Open Defx']           },
            "\ { 'type': function('s:list_commits'),     'header': ['   Commits']             },
" let g:ascii = [
"       \ '        __',
"       \ '.--.--.|__|.--------.',
"       \ '|  |  ||  ||        |',
"       \ ' \___/ |__||__|__|__|',
"       \ ''
"       \]
" let g:startify_custom_header = g:ascii + startify#fortune#boxed()
" let g:startify_custom_header =
"     \ startify#pad(split(system('fortune | cowsay'), '\n'))
" let g:startify_custom_header = [
"     \ '                                 ________  __ __        ',
"     \ '            __                  /\_____  \/\ \\ \       ',
"     \ '    __  __ /\_\    ___ ___      \/___//''/''\ \ \\ \    ',
"     \ '   /\ \/\ \\/\ \ /'' __` __`\        /'' /''  \ \ \\ \_ ',
"     \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \      /'' /''__  \ \__ ,__\',
"     \ '    \ \___/  \ \_\ \_\ \_\ \_\    /\_/ /\_\  \/_/\_\_/  ',
"     \ '     \/__/    \/_/\/_/\/_/\/_/    \//  \/_/     \/_/    ',
"     \ ]
" let g:startify_custom_header = split(system('fortune | cowsay'), '\n')
""Example: ctermfg=252 ctermbg=233 guifg=#F8F8F2 guibg=#1B1D1E
" highlight StartifyBracket ctermfg=86  guifg=#5fffdf
" highlight StartifyFooter  ctermfg=50  guifg=#00ffdf
" highlight StartifyHeader  ctermfg=50  guifg=#00ffdf
" highlight StartifyNumber  ctermfg=215 guifg=
" highlight StartifyPath    ctermfg=245 guifg=
" highlight StartifySlash   ctermfg=240 guifg=
" highlight StartifySpecial ctermfg=240 guifg=

"=========================================================================
""Description: Visualize vim undotree.
""Alternatives: simnalamburt/vim-mundo
Plug 'mbbill/undotree'
nnoremap <leader>ut :UndotreeToggle<cr>
""Layout: <position> <vertical> <width> new | <position> <height> new
let g:undotree_CustomUndotreeCmd  = 'topleft vertical 30 new'
let g:undotree_CustomDiffpanelCmd = 'botright 10 new'
""Auto open the diff window.
" let g:undotree_DiffAutoOpen = 1
""Whether to stay in current after Undotree being opened.
let g:undotree_SetFocusWhenToggle = 1
""Tree node shape
let g:undotree_TreeNodeShape = '⚑'
""Use relative timestamp.
let g:undotree_RelativeTimestamp = 0
""Get short timestamps.
" let g:undotree_ShortIndicators = 0
""Highlight the changed text.
" let g:undotree_HighlightChangedText = 1
""Highlight groups.
" let g:undotree_HighlightSyntaxAdd    = "DiffAdd"
" let g:undotree_HighlightSyntaxChange = "DiffChange"
" let g:undotree_WindowLayout = 2
""Whether to shoe help line.
let g:undotree_HelpLine = 0
""Custom mappings.
function g:Undotree_CustomMap()
    nmap <buffer> u <plug>UndotreeNextState
    nmap <buffer> e <plug>UndotreePreviousState
    nmap <buffer> U 5<plug>UndotreeNextState
    nmap <buffer> E 5<plug>UndotreePreviousState
endfunc

"=========================================================================
""Description: NERDTree file tree
""Alternatives: Defx.nvim
Plug 'preservim/nerdtree' , {'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFromBookmark', 'NERDTreeFind']}
let g:NERDTreeHijackNetrw = 1
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden = 0
let NERDTreeShowBookmarks = 0
let NERDTreeBookmarksFile = g:main_runtimepath.'.cache/NERDTreeBookmarks'
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeCreatePrefix='silent keepalt keepjumps'
" let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let NERDTreeIgnore = ['\.pyc$', '__pycache__', '\.git$', '\.vscode$', 'desktop.ini']
let g:NERDTreeWinSize=30
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <leader>nt :NERDTreeToggle<cr>
nnoremap <leader>nb :NERDTreeFromBookmark<Space>
nnoremap <leader>nb :NERDTreeFromBookmark<Space>
nnoremap <leader>nf :NERDTreeFind<cr>

""只剩下NERDTree时关闭窗口
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \b:NERDTree.isTabTree()) | q | endif

""用 - 打开 Netrw
" Plug 'tpope/vim-vinegar'

" Plug 'Xuyuanp/nerdtree-git-plugin'
" let g:NERDTreeIndicatorMapCustom = {
"             \ 'Modified'  : '✹ ',
"             \ 'Staged'    : '⚑ ',
"             \ 'Untracked' : '⚝ ',
"             \ 'Renamed'   : '->',
"             \ 'Unmerged'  : ' ',
"             \ 'Ignored'   : '~~',
"             \ 'Dirty'     : '✖ ',
"             \ 'Unknown'   : '? ',
"             \ }
" " 不显示 Ignored 状态(a heavy feature may cost much more time)
" let g:NERDTreeShowIgnoredStatus = 1
" ""NERDTree with airline
" let g:airline#extensions#nerdtree_status = 1

"=========================================================================
""Description: File tree
""Dependencies: See below
" if has('nvim')
"     Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"     Plug 'Shougo/defx.nvim'
"     Plug 'roxma/nvim-yarp'
"     Plug 'roxma/vim-hug-neovim-rpc'
" endif
" ""Set options
" ""Options available: :h defx-options
" noremap <silent> <leader>df :call g:Defx_toggle_with_my_options()<cr>
" function g:Defx_toggle_with_my_options()
"     " if &filetype != 'startify'
"         Defx
"             \ -columns=mark:git:indent:icons:icon:filename:type:size:time
"             \ -ignored-files='.*'
"             \ -vertical-preview -preview-width=50
"             \ -sort='filename'
"             \ -buffer-name='filebrowser'
"             \ -show-ignored-files=0
"             \ -focus -toggle
"             "\ -columns=git:mark:indent:icons:filename:type
"             "\ -split='vertical' -direction='topleft' -winwidth=&columns/2
"             "\ -split='horizontal' -direction='botright' -winheight=30
"             "\ -split='floating' -wincol=4 -winrow=0
"             "\ -preview-height=15
"             "\ -floating-preview -preview-height=10 -preview-width=40
"             "\ -root-maker=
"             "\ -search={path}
"             "\ -session-file={path}
"             "\ -split='floating' -direction='topleft'
"             "\ listed
"     " endif
" endfunction
" autocmd FileType defx call s:defx_my_settings()
" function! s:defx_my_settings() abort
"     ""Custom columns: filename icon indent mark size space time type [git icons]
"     call defx#custom#option('_', {
"                 \ 'columns': 'mark:git:icons:icon:filename:type:size:time',
"                 \ 'defx-option-session-file': g:main_runtimepath.'.cache/defx',
"                 \ })
"     call defx#custom#column('icon', {
"                 \ 'directory_icon': '▸',
"                 \ 'opened_icon': '▾',
"                 \ 'root_icon': ' ',
"                 \ })
"     call defx#custom#column('filename', {
"                 \ 'min_width': 40,
"                 \ 'max_width': 40,
"                 \ })
"     call defx#custom#column('mark', {
"                 \ 'readonly_icon': '✗',
"                 \ 'selected_icon': '✓',
"                 \ })
"     call defx#custom#column('filename', {
"                 \ 'min_width': 40,
"                 \ 'max_width': -100,
"                 \ })
"     " call defx#custom#option('_', {
"     "             \ 'winwidth': 30,
"     "             \ 'split': 'vertical',
"     "             \ 'direction': 'topleft',
"     "             \ 'show_ignored_files': 0,
"     "             \ 'buffer_name': '',
"     "             \ 'toggle': 1,
"     "             \ 'resume': 1
"     "             \ })
"     ""Define mappings
"     ""Actions available: :h defx-actions
"     nnoremap <silent><buffer><expr> <CR>    defx#do_action('open')
"     "nnoremap <silent><buffer><expr> l       defx#do_action('open')
"     nnoremap <silent><buffer><expr> c       defx#do_action('copy')
"     nnoremap <silent><buffer><expr> x       defx#do_action('move')
"     nnoremap <silent><buffer><expr> p       defx#do_action('paste')
"     nnoremap <silent><buffer><expr> E       defx#do_action('open', 'vsplit')
"     nnoremap <silent><buffer><expr> P       defx#do_action('preview')
"     nnoremap <silent><buffer><expr> o       defx#do_action('open_tree', 'toggle')
"     nnoremap <silent><buffer><expr> N       defx#do_action('new_directory')
"     nnoremap <silent><buffer><expr> n       defx#do_action('new_file')
"     nnoremap <silent><buffer><expr> M       defx#do_action('new_multiple_files')
"     "nnoremap <silent><buffer><expr> C       defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
"     nnoremap <silent><buffer><expr> S       defx#do_action('toggle_sort', 'time')
"     nnoremap <silent><buffer><expr> d       defx#do_action('remove')
"     nnoremap <silent><buffer><expr> r       defx#do_action('rename')
"     nnoremap <silent><buffer><expr> !       defx#do_action('execute_command')
"     nnoremap <silent><buffer><expr> ex      defx#do_action('execute_system')
"     nnoremap <silent><buffer><expr> yy      defx#do_action('yank_path')
"     nnoremap <silent><buffer><expr> .       defx#do_action('toggle_ignored_files')
"     nnoremap <silent><buffer><expr> ;       defx#do_action('repeat')
"     nnoremap <silent><buffer><expr> h       defx#do_action('cd', ['..'])
"     nnoremap <silent><buffer><expr> ~       defx#do_action('cd')
"     nnoremap <silent><buffer><expr> q       defx#do_action('quit')
"     nnoremap <silent><buffer><expr> s       defx#do_action('toggle_select') . 'j'
"     nnoremap <silent><buffer><expr> *       defx#do_action('toggle_select_all')
"     nnoremap <silent><buffer><expr> j       line('.') == line('$') ? 'gg' : 'j'
"     nnoremap <silent><buffer><expr> k       line('.') == 1 ? 'G' : 'k'
"     nnoremap <silent><buffer><expr> <C-l>   defx#do_action('redraw')
"     nnoremap <silent><buffer><expr> <C-g>   defx#do_action('print')
"     nnoremap <silent><buffer><expr> cd      defx#do_action('change_vim_cwd')
" endfunction


"=========================================================================
""Description: Icons and git status for defx.
""Dependencies: Shougo/defx.nvim
" Plug 'kristijanhusak/defx-icons'
" "":Defx -columns=icons:indent:filename:type
" Plug 'kristijanhusak/defx-git'
" "":Defx -columns=git:mark:filename:type
" au VimEnter * call defx#custom#column('git', 'indicators', {
"             \ 'Modified'  : '✹ ',
"             \ 'Staged'    : '⚑ ',
"             \ 'Untracked' : '⚝ ',
"             \ 'Renamed'   : '->',
"             \ 'Unmerged'  : '==',
"             \ 'Ignored'   : '~~',
"             \ 'Deleted'   : '✖ ',
"             \ 'Unknown'   : '? '
"             \ })
" " ⚐ ★ "
" " call defx#custom#column('git', 'indicators', {
" " \ 'Modified'  : '✹',
" " \ 'Staged'    : '✚',
" " \ 'Untracked' : '✭',
" " \ 'Renamed'   : '➜',
" " \ 'Unmerged'  : '═',
" " \ 'Ignored'   : '☒',
" " \ 'Deleted'   : '✖',
" " \ 'Unknown'   : '?'
" " \ })


"=========================================================================
""Description: Tag list
""Dependencies: ctags/..., see :echo g:vista#executives
Plug 'liuchengxu/vista.vim'
""See the full list of executivs via :echo g:vista#executives
let g:vista_default_executive = 'ctags'
""Don't sort tags
let g:vista_ctags_project_opts = '--sort=no -R -o .tags'
let g:vista_executive_for = {
            \ 'vimwiki': 'markdown',
            \ 'pandoc': 'markdown',
            \ 'markdown': 'toc',
            \ }
            " \ 'python': 'coc',
            "\ 'vim': 'vimlsp',
let g:vista_enable_markdown_extension = 1
""Toggle Vista
noremap <silent> <leader>vt :Vista!!<CR>
""Fzf, try :Vista finder <tab>
let g:airline#extensions#fzf#enabled = 1
""Show markdown outline properly. default 1
let g:vista_enable_markdown_extension = 1
noremap <silent> ,T :Vista finder<CR>
let g:vista_fzf_preview = ['right:50%']
"noremap <silent> <F8> :Vista finder<CR>    "search tags recursively.
"let g:vista_sidebar_position = 'vertical botright'
let g:vista_sidebar_width = 50
"?let g:vista_sidebar_keepalt = 1
let g:vista_fold_toggle_icons = ['▾', '▸']
""Only works for LSP executivea, not for ctags
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
"let g:vista_echo_cursor = 1
let g:vista_cursor_delay = 200
""echo scroll foating_win both
"let g:vista_echo_cursor_strategy = 'echo'
"let g:vista_floating_delay=100
let g:vista_update_on_text_changed = 1
let g:vista_update_on_text_changed_delay = 2000
" let g:vista_close_on_jump = 1
let g:vista_stay_on_open = 1
""Disable blink
let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]
"let g:vista_disable_statusline = exists('g:loaded_airline') || exists('g:loaded_lightline')
""Use beautiful icons
"let g:vista#renderer#enable_icon = exists('g:vista#renderer#icons') || exists('g:airline_powerline_fonts')
let g:vista#renderer#icons = {
            \   "default": "\uf794",
            \  }
" function! NearestMethodOrFunction() abort
"     return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

"=========================================================================
""Description: Open Defx and Vista Compactly
""Dependencies: liuchengxu/vista.vim Shougo/defx.nvim
" Plug 'linjiX/vim-defx-vista'

"=========================================================================
""Description:
""Dependencies:
" Plug 'alohaia/eleline.vim'
" "Plug 'theniceboy/eleline.vim'
" let g:airline_powerline_fonts = 0

" Plug 'bling/vim-bufferline'
" " let g:bufferline_echo = 0
" " autocmd VimEnter *
" " \ let &statusline='%{bufferline#refresh_status()}'
" "   \ .bufferline#get_status_string()

"=========================================================================
""Description: Other visual enhancement
""Dependencies: Nerd fonts, such as nerd-fonts-fira nerd-fonts-jetbrains-mono and etc.
""A lot of unicode icons.( nerd-fonts needed )
Plug 'ryanoasis/vim-devicons'
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_tabline = 1

"=========================================================================
""Description: Cursor shape change in insert and replace mode & Improved mouse support
Plug 'wincent/terminus'

"=========================================================================
""Description: 状态栏美化、tabline
Plug 'vim-airline/vim-airline'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
""Enable tabline
let g:airline#extensions#tabline#enabled=1    "Smarter tab line: 显示窗口tab和buffers
""tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
""设置分隔符 |¦┊┇
" let g:airline#extensions#tabline#left_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#right_sep = ''
" let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#left_sep = '┊'
let g:airline#extensions#tabline#left_alt_sep = '┊'
let g:airline#extensions#tabline#right_sep = '┊'
let g:airline#extensions#tabline#right_alt_sep = '┊'
let g:airline#extensions#tabline#formatter = 'default'  "formater
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
let g:airline_left_sep = '┊'
let g:airline_left_alt_sep = '┊'
let g:airline_right_sep = '┊'
let g:airline_right_alt_sep = '┊'
""配置其他字符
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '㏑'
let g:airline_symbols.maxlinenr = '¶'
let g:airline_symbols.branch = ''
"let g:airline_symbols.paste = 'ρ'
"let g:airline_symbols.paste = '∥ '
let g:airline_symbols.dirty='[+]'   "⚡
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

"=========================================================================
""Description: Schemes for airline
""Dependencies: vim-airline/vim-airline
""Recommend: cool, airlineish
Plug 'vim-airline/vim-airline-themes'
Plug 'rafalbromirski/vim-airlineish'
""推荐：cool, airlineish
""是否使用随机airline主题(开发中...)
if has('nvim')
    let g:airline_theme = 'airlineish'
    let g:airline_random_theme = 0
else
    let g:airline_random_theme = 1
endif


"#########################################################################
"########################\ Color and Highlighting /#######################
"#########################################################################

""See currently enabled highlight groups :so $VIMRUNTIME/syntax/hitest.vim
""See highlight info of text under the cursor :Showhi

"=========================================================================
""Description: Open a color table.
Plug 'guns/xterm-color-table.vim'
" Provides command :XtermColorTable, as well as variants for different splits

"=========================================================================
""Description: vim-polyglot，开箱即用型的语法高亮包
Plug 'sheerun/vim-polyglot'
""根据语言选择是否开启，如对css禁用此插件
" let g:polyglot_disabled = ['css']
let g:polyglot_disabled = ['cpp']

"=========================================================================
""Description: c++ 语法高亮增强包
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}
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

"=========================================================================
""Description: Highlighting fo go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
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

"=========================================================================
""Description: Schemes for vim
""Recommend: molokai
Plug 'flazz/vim-colorschemes'

"=========================================================================
""Description: vim syntax highlighting for firebase-bolt
"Plug 'bpietravalle/vim-bolt'

"=========================================================================
""Description: Color other uses of the current word under the cursor.
Plug 'RRethy/vim-illuminate'
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

"=========================================================================
""Description: Plugin for fuzzy finder, search everything in vim!
""Dependencies: fzf, [mlocate, ]others see :h fzf-vim-dependencies
""Alternatives: Shougo/denite.nvim
Plug 'junegunn/fzf.vim'
" set rtp+=/usr/local/opt/fzf
" set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
" set rtp+=/home/david/.linuxbrew/opt/fzf
""Full list of commands, see :h fzf-vim-commands
noremap ,p :Files<CR>
noremap ,b :Buffers<CR>
noremap ,l :Lines<CR>
noremap ,g :Rg<CR>
""Specify tags-generatiing commands for :Tags
let g:fzf_tags_command = 'ctags -R -o .tags'
noremap ,t :Tags<CR>
""Use ':Vista finder <tab>' to search tab from other sources.
noremap ,h :History<CR>
noremap ,; :History:<CR>
noremap ,/ :History/<CR>
""This is the default extra key bindings
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }
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
noremap <c-d> call fzf#run(fzf#wrap({
            \ 'source': s:list_buffers(),
            \ 'sink*': { lines -> s:delete_buffers(lines) },
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
            \ }))

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }

"=========================================================================
""Description: Fzf interface for creating .gitignore files using the gitignore.io API.
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
""Disable all key mappings.
" let g:fzf_gitignore_no_maps = 1
noremap <LEADER>gi :FzfGitignore<CR>

"=========================================================================
""Description: Use Ranger in a floating window
""Dependencies: ranger, pynvim, [ ueberzug(preview pictures), bat(for highlight and faster preview, highly recommended) ]
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
""Disable Rnvimr to import user configuration.
"let g:rnvimr_vanilla = 1
""Make Ranger replace netrw to be a file explorer
let g:rnvimr_ex_enable = 1
""Make Ranger to be hidden after picking a file
let g:rnvimr_pick_enable = 1
""Disable a border for floating window
let g:rnvimr_draw_border = 0
""Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
""Set up only two columns in miller mode and draw border with both
" let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"
"             \ --cmd="set draw_borders both"'
""Make Neovim wipe the buffers corresponding to the files deleted by Ranger
"let g:rnvimr_bw_enable = 1
""Hide the files included in gitignore
"let g:rnvimr_hide_gitignore = 1
""Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine
"nnoremap <silent> <cr> :RnvimrSync<CR>:RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
nnoremap <silent> <cr> :RnvimrToggle<CR>
" <C-\><C-n>:RnvimrResize 0<CR>
"""Resize floating window by all preset layouts
"tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
"""Resize floating window by special preset layouts
"tnoremap <silent> <M-l> <C-\><C-n>:RnvimrResize 1,8,9,11,5<CR>
"""Resize floating window by single preset layout
"tnoremap <silent> <M-y> <C-\><C-n>:RnvimrResize 6<CR>
""Default shortcuts
" let g:rnvimr_action = {
"             \ '<C-t>': 'NvimEdit tabedit',
"             \ '<C-x>': 'NvimEdit split',
"             \ '<C-v>': 'NvimEdit vsplit',
"             \ 'gw': 'JumpNvimCwd',
"             \ 'yw': 'EmitRangerCwd'
"             \ }
""Default layout
" let g:rnvimr_layout = { 'relative': 'editor',
"             \ 'width': float2nr(round(0.6 * &columns)),
"             \ 'height': float2nr(round(0.6 * &lines)),
"             \ 'col': float2nr(round(0.2 * &columns)),
"             \ 'row': float2nr(round(0.2 * &lines)),
"             \ 'style': 'minimal' }
""Let ranger occupies the whole screen
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]

"=========================================================================
""Description: Find & Replace text through multiple files.
""Dependencies: ag(the_silver_searcher, optional)
""Note: pay attention to \ " and space for pattren
"Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
Plug 'brooth/far.vim'
""F Far Farp Farr Farf Fardo Farundo Refar(in a Far buffer)
""For params, see :h far-params
noremap <LEADER>f :F<space><space>**/*
            \<left><left><left><left><left>
            "\--source='agnvim' --cwd=''
            "\--win-layout --win-width --win-height
            "\--preview-win-layout --preview-win-width --preview-win-height
            "\--auto-preview --auto-preview-on-start
if has('nvim')
    let g:far#source = 'agnvim'
else
    let g:far#source = 'ag'
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

"=========================================================================
""Description: Framework for Auto Complete, Syntax Check and etc.
""Dependencies: ccls, pip install 'python-language-server[all]'
""Alternatives: ncm2/ncm2, ycm-core/YouCompleteMe, dense-analysis/ale
Plug 'neoclide/coc.nvim', {'branch': 'release'}
""Language Servers; Snippets(coc-snippets); ...
""fix the most annoying bug that coc has
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap if
""Language servers: https://github.com/neoclide/coc.nvim/wiki/Language-servers
""Edit snippet file for current filetype: :CocCommand snippets.editSnippets
""建议只在首次安装时使用以下列表，之后可以使用 CocInstall/CocUnstall
let g:coc_global_extensions = [
            \ 'coc-sh',
            \ 'coc-css',
            \ 'coc-diagnostic',
            \ 'coc-flutter',
            \ 'coc-html',
            \ 'coc-json',
            \ 'coc-prettier',
            \ 'coc-snippets',
            \ 'coc-sourcekit',
            \ 'coc-stylelint',
            \ 'coc-syntax',
            \ 'coc-tslint-plugin',
            \ 'coc-tsserver',
            \ 'coc-vimlsp',
            \ 'coc-yaml',
            \ 'coc-floaterm',
            \ 'coc-lists',
            \ ]
            " \ 'coc-actions',
            " \ 'coc-gitignore',
            " \ 'coc-tasks',
            " \ 'coc-todolist',
            " \ 'coc-translator',
            " \ 'coc-yank',
""Use python-language-server instead: pip install 'python-language-server[all]'
            "\ 'coc-python',
            "\ 'coc-pyright',
            "\ 'coc-explorer',
""Use coc-ccls instead
            "\ 'coc-clangd',
""??????????
            "\ 'coc-tabnine',
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
""Use <C-c> to confirm completion (for snippets and additional edit)
inoremap <silent><expr> <C-c> pumvisible() ?
            \ coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
""Close the preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

""Coc Snippets :CocCommand snippets.editSnippets to edit snippet file for current file
inoremap <silent><expr> <C-c>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
let g:coc_snippet_next = '<M-j>'
let g:coc_snippet_prev = '<M-k>'

" Use g[ and g] to navigate diagnostics
" Use :CocDiagnostics to get all diagnostics of current buffer in location list.
nnoremap <silent> g[ <Plug>(coc-diagnostic-prev)
nnoremap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Use <leader>K to show documentation in preview window.
nnoremap <silent> <leader>K :call <SID>show_documentation()<CR>

"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = 'E:'
let airline#extensions#coc#warning_symbol = 'W:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

"=========================================================================
""Description: CSharp
" Plug 'OmniSharp/omnisharp-vim', {'for': 'cs'}
" let g:OmniSharp_typeLookupInPreview = 1
" let g:omnicomplete_fetch_full_documentatiot = 1
"
" let g:OmniSharp_server_use_mono = 1
" let g:OmniSharp_server_stdio = 1
" let g:OmniSharp_highlight_types = 2
" let g:OmniSharp_selector_ui = 'ctrlp'
"
" autocmd Filetype cs nnoremap <buffer> gd :OmniSharpPreviewDefinition<CR>
" autocmd Filetype cs nnoremap <buffer> gr :OmniSharpFindUsages<CR>
" autocmd Filetype cs nnoremap <buffer> gy :OmniSharpTypeLookup<CR>
" autocmd Filetype cs nnoremap <buffer> ga :OmniSharpGetCodeActions<CR>
" autocmd Filetype cs nnoremap <buffer> <LEADER>rn :OmniSharpRename<CR><C-N>:res +5<CR>
"
" sign define OmniSharpCodeActions text=💡
"
" augroup OSCountCodeActions
"     autocmd!
"     autocmd FileType cs set signcolumn=yes
"     autocmd CursorHold *.cs call OSCountCodeActions()
" augroup END
"
" function! OSCountCodeActions() abort
"     if bufname('%') ==# '' || OmniSharp#FugitiveCheck() | return | endif
"     if !OmniSharp#IsServerRunning() | return | endif
"     let opts = {
"                 \ 'CallbackCount': function('s:CBReturnCount'),
"                 \ 'CallbackCleanup': {-> execute('sign unplace 99')}
"                 \}
"     call OmniSharp#CountCodeActions(opts)
" endfunction
"
" function! s:CBReturnCount(count) abort
"     if a:count
"         let l = getpos('.')[1]
"         let f = expand('%:p')
"         execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
"     endif
" endfunction
" " Ale integration
" let g:airline#extensions#omnisharp#enabled = 1
"
" Plug 'ctrlpvim/ctrlp.vim', {'on': ['CtrlP', 'CtrlPBuffer']}
" ""(Dependency for omnisharp)
" ""将 CtrlP 的工作目录设置为仓库根目录（找不到则设置为当前目录）
" let g:ctrlp_working_path_mode = 'ra'
" "let g:ctrlp_map =
" " nnoremap <leader>j :CtrlP<cr>
" " nnoremap <leader>b :CtrlPBuffer<cr>
" let g:ctrlp_max_height = 10
" let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee\|^\.vscode'

"=========================================================================
""Description: HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.
"Plug 'elzr/vim-json'
"Plug 'othree/html5.vim'
"Plug 'alvan/vim-closetag'
"" Plug 'hail2u/vim-css3-syntax' " , { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"" Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
"" Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"" Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
""let g:vim_jsx_pretty_colorful_config = 1
"" Plug 'jelera/vim-javascript-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
""Plug 'jaxbot/browserlink.vim'
"Plug 'HerringtonDarkholme/yats.vim'
"Plug 'mattn/emmet-vim'

"=========================================================================
""Description: Python
" Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
" Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
" Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
"Plug 'vim-scripts/indentpython.vim', { 'for' :['python', 'vim-plug'] }
"Plug 'plytophogy/vim-virtualenv', { 'for' :['python', 'vim-plug'] }
" Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }

"=========================================================================
""Description: Dart
" Flutter
" Plug 'dart-lang/dart-vim-plugin'

"=========================================================================
""Description: swift
" Plug 'keith/swift.vim'


"#########################################################################
"############################\ Debug & Tasks /############################
"#########################################################################

"=========================================================================
""Description: Debug
Plug 'puremourning/vimspector'
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
sign define vimspectorBP text=◉  texthl=Normal
sign define vimspectorBPDisabled text=○  texthl=Normal
sign define vimspectorBPCond text=♦  texthl=Normal
"The program counter, i.e. current line.🔶
sign define vimspectorPC text=➤➤ texthl=SpellBad

"=========================================================================
""Description: 为 Vim 引入类似 vscode 的 tasks 任务系统，
""             用统一的方式系统化解决各类：编译/运行/测试/部署任务。
""             The generic way to handle building/running/testing/deploying
""             tasks by imitating vscode's task system.
Plug 'skywind3000/asynctasks.vim'
command! RunDefault AsyncTask default-run
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

Plug 'skywind3000/asyncrun.vim'
""运行时自动打开高度为 6 的 quickfix 窗口
"let g:asyncrun_open = 6
""编译整个项目时，通过rootmarks确定项目根目录，可以通过创建特殊空目录的方式截断向上查找的过程。
""Customize Runner: https://github.com/skywind3000/asynctasks.vim/wiki/Customize-Runner
function! s:my_floaterm(opts)
    " if floaterm#terminal#get_bufnr('asynctasks') == -1
    "     FloatermNew --name='asynctasks'
    "     FloatermToggle
    " endif
    ""将命令发送给浮动终端并运行
    execute("FloatermSend " . a:opts.cmd)
endfunction
let g:asyncrun_runner = get(g:, 'asyncrun_runner', {})
let g:asyncrun_runner.floaterm = function('s:my_floaterm')
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg', '.tasks']
""插件还提供了一个用于在命令行下执行 task 的脚本 asynctask, 并支持使用 fzf 查找 task.

"=========================================================================
""Description: Auto change 
Plug 'airblade/vim-rooter'
let g:rooter_patterns = ['__vim_project_root', '.git/']
""Don't echo the project directory.
let g:rooter_silent_chdir = 1

"=========================================================================
""Description: Vim plugin for "jump to defitinition" and "find usages" feature through nice popup ui.
Plug 'pechorin/any-jump.vim'
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
" let g:any_jump_colors = {
"       \"plain_text":         "Comment",
"       \"preview":            "Comment",
"       \"preview_keyword":    "Operator",
"       \"heading_text":       "Function",
"       \"heading_keyword":    "Identifier",
"       \"group_text":         "Comment",
"       \"group_name":         "Function",
"       \"more_button":        "Operator",
"       \"more_explain":       "Comment",
"       \"result_line_number": "Comment",
"       \"result_text":        "Statement",
"       \"result_path":        "String",
"       \"help":               "Comment"
"       \}
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

"#########################################################################
"#####################\ General Editing Enhancement /#####################
"#########################################################################

"=========================================================================
""Description: Swith between antonyms.
"Plug 'jwarby/antovim'

"=========================================================================
""Description: Quickly select all text in ' ) ] } ... in visual mode.
"Plug 'gcmt/wildfire.vim'

"=========================================================================
""Description: Text outlining and task management for Vim based on Emacs' Org-Mode.
""Note: This plugin seems to make [neo]vim beyond the concept of code editor.
"Plug 'jceb/vim-orgmode'

"=========================================================================
""Description: <C-l>(if not already used)/<C-g>c (insert) to toggle capslock
Plug 'tpope/vim-capslock'
set statusline^=%{exists('*CapsLockStatusline')?CapsLockStatusline():''}
"imap <C-L> <C-O><Plug>CapsLockToggle

"=========================================================================
""Description: 'after' text objects for v/c/d/y
Plug 'junegunn/vim-after-object' " da= to delete what's after =
""Enable some characters and use ]= and [= instead of a= and aa=
autocmd VimEnter * call after_object#enable([']', '['], '/', '=', ':', '-', '#', '*', ' ')

"=========================================================================
""Description: Improved motion
Plug 'easymotion/vim-easymotion'
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

"=========================================================================
""Description: ["reg]s<motion/txtobj> 使用[默认]寄存器中的内容替换指定内容
""Dependencies: [tpope/vim-abolish], [svermeulen/vim-yoink]
""Note: The key 's' is shadowed, use 'cl' instead.
Plug 'svermeulen/vim-subversive'
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
onoremap ie :exec "normal! ggVG"<cr>
""iv = current viewable text in the buffer
onoremap iv :exec "normal! HVL"<cr>

"=========================================================================
""Description: Abbreviation Substitution & Coercion
""  Abbreviation: :Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
""   -buffer: buffer local
""   -cmdline: work in command line in addition to insert mode
""    :Abolish -buffer cook{,re} cook{s,er}
""    Try typing cook<space> or cookre<space>
""  Substitution: :%Subvert/facilit{y,ies}/building{,s}/g
""    abcd abbd noabcd abdd ABCD
""    1. :%S/{,no}ab{c,b,d}d/ba{x,y}al{ha}/g
""       baxalha baxalha bayalha baxalha BAXALHA
""    2. :%S/{,no}ab{c,b,d}d/{kon,yes,extra}ba{x,y}al{ha}/g
""       konbaxal{ha} konbayal{ha} yesbaxal{ha} konbaxal{ha} KONBAXAL{HA}
""  Coercion:
""    MixedCase  :  crm
""    camelCase  :  crc
""    snake_case :  crs/cr_
""    UPPER_CASE :  cru/crU
""    dash-case  :  cr-
""    kebab-case :  crk
""    dot.case   :  cr.
""    space case :  cr<space>
""    Title Case :  crt
Plug 'tpope/vim-abolish'
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

"=========================================================================
""Description: Rotate between yank histories.
Plug 'svermeulen/vim-yoink'
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

"=========================================================================
""Description: Improved f/F/t/T
Plug 'rhysd/clever-f.vim'
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
let g:clever_f_chars_match_any_signs = ';.'
""Highlight current position while waitting for a character.
" let g:clever_f_mark_cursor = 1
""Change the highlight group.
" let g:clever_f_mark_cursor_color = "Cursor"
""Use <CR> and <Tab> to repeat last character.
let g:clever_f_repeat_last_char_inputs = ["\<CR>", "\<Tab>"]
""Highlight the character which the cursor can be moved directly to.
let g:clever_f_mark_direct = 1
let g:clever_f_mark_direct_color = "CleverFDefaultLabel"

"=========================================================================
""Description: 断行/合并，支持多种语言
Plug 'AndrewRadev/splitjoin.vim'
" gS to split a one-liner into multiple lines
" gJ (with the cursor on the first line of a block) to join a block into a single-line statement.

"=========================================================================
""Description: Display a calendar/clock in vim
Plug 'itchyny/calendar.vim'
"noremap \\c :Calendar -position=here<CR>
noremap \\c :Calendar -view=clock -position=here<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
augroup calendar-mappings
    autocmd!
    " diamond cursor
    autocmd FileType calendar nmap <buffer> u <Plug>(calendar_up)
    autocmd FileType calendar nmap <buffer> n <Plug>(calendar_left)
    autocmd FileType calendar nmap <buffer> e <Plug>(calendar_down)
    autocmd FileType calendar nmap <buffer> i <Plug>(calendar_right)
    autocmd FileType calendar nmap <buffer> <c-u> <Plug>(calendar_move_up)
    autocmd FileType calendar nmap <buffer> <c-n> <Plug>(calendar_move_left)
    autocmd FileType calendar nmap <buffer> <c-e> <Plug>(calendar_move_down)
    autocmd FileType calendar nmap <buffer> <c-i> <Plug>(calendar_move_right)
    autocmd FileType calendar nmap <buffer> k <Plug>(calendar_start_insert)
    autocmd FileType calendar nmap <buffer> K <Plug>(calendar_start_insert_head)
    " unmap <C-n>, <C-p> for other plugins
    nnoremap ． .
    autocmd FileType calendar nunmap <buffer> <C-n>
    autocmd FileType calendar nunmap <buffer> <C-p>
augroup END

"=========================================================================
""Description: 用竖线(或其他字符显示缩进)
Plug 'Yggdroot/indentLine', {'for' : ['python']}
" 指定对齐线的尺寸
let g:indent_guides_guide_size = 1
" 从第二层开始可视化显示缩进
let g:indent_guides_start_level = 2
""highlight conceal color with your colorscheme, 禁用插件的高亮
let g:indentLine_setColors = 1
" Vim
let g:indentLine_color_term = 239
" GVim
"let g:indentLine_color_gui = '#A4E57E'
" none X terminal
"let g:indentLine_color_tty_light = 7 " (default: 4)
"let g:indentLine_color_dark = 1 " (default: 2)
" Background (Vim, GVim)
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#FF5F00'
let g:indentLine_char = '┇'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
au BufEnter python IndentLinesEnable
au BufLeave python IndentLinesDisable

"=========================================================================
""Description: Fast Commenting
Plug 'preservim/nerdcommenter'
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

"=========================================================================
""Description: Vim Multi-Cursors and Aligning
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
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

"=========================================================================
""Description: Handle Surronuds
Plug 'tpope/vim-surround'
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>

"=========================================================================
""Description: Enables . command plugin mappings
Plug 'tpope/vim-repeat'

"=========================================================================
""Description: AutoFormat
Plug 'Chiel92/vim-autoformat'
nnoremap \\f :Autoformat<CR>
nnoremap ． .
let g:formatdef_custom_js = '"js-beautify -t"'
let g:formatters_javascript = ['custom_js']
au BufWrite *.js :Autoformat

"=========================================================================
""Description: ColorfulBrackets
Plug 'luochen1990/rainbow'
""https://github.com/luochen1990/rainbow/blob/master/README_zh.md
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
            \    'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \    'operators': '_,_',
            \    'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \    'separately': {
            \        '*': {},
            \        'markdown': {
            \            'parentheses_options': 'containedin=markdownCode contained',
            \        },
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
            \        'nerdtree': 0,
            \    }
            \}

"=========================================================================
""Description: Auto Make Pairs
Plug 'jiangmiao/auto-pairs'
" 开启/禁用 auto-pairs
" let g:AutoPairsShortcutToggle='<M-P>'
" 将一对 pair 后面的内容移到 pair 中（在 pair 内按下快捷键）
let g:AutoPairsShortcutFastWrap='<M-e>'
let g:AutoPairsShortcutJump='<M-n>'
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
au FileType html let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '<':'>'}
au FileType vim let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '`':'`', '<':'>'}
" 使用 Backspace 删除时会删除 pair 中的另一个
let g:AutoPairsMapBs=1
" 让使用 <C-h> 删除时不会删除 pair 中的另一个
let g:AutoPairsMapCh=0
""在pairs间输入空格
let g:AutoPairsMapSpace=1
" 将回车键映射为插入空行的操作
let g:AutoPairsMapCR=1

" FlyMode
let g:AutoPairsFlyMode=0
let g:AutoPairsShortcutBackInsert='<M-b>'

"=========================================================================
""Description: Zen Mode, help you concentrate.
Plug 'junegunn/goyo.vim'
command! Zen Goyo 85%x85%

"=========================================================================
""Description: Focus on a selected region while making the rest inaccessible.
Plug 'chrisbra/NrrwRgn'
"":NR  - Open the selected region in a new narrowed window
"":NW  - Open the current visual window in a new narrowed window
"":WR  - (In the narrowed window) write the changes back to the original buffer.
"":NRV - Open the narrowed window for the region that was last visually selected.
"":NUD - (In a unified diff) open the selected diff in 2 Narrowed windows
"":NRP - Mark a region for a Multi narrowed window
"":NRM - Create a new Multi narrowed window (after :NRP) - experimental!
"":NRS - Enable Syncing the buffer content back (default on)
"":NRN - Disable Syncing the buffer content back
"":NRL - Reselect the last selected region and open it again in a narrowed window
""Add ! to open in current window.
""Visual mode: <leader>nr

" For general writing
"Plug 'reedes/vim-wordy'

"=========================================================================
""Description: Multi-language thesaurus query/replacement
Plug 'ron89/thesaurus_query.vim'
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


"#########################################################################
"###############################\ MarkDown /##############################
"#########################################################################

"=========================================================================
""Description: MarkDown Prevew
""Alternatives: suan/vim-instant-markdown
""Also support MathJex without this plugin. ???
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
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
let g:mkdp_browser = ''
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

"=========================================================================
""Description: Table Mod
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1

"=========================================================================
""Description: Auto generate and update MarkDown TOC
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
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

"=========================================================================
""Description: Bullet List
Plug 'dkarter/bullets.vim'
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

"#########################################################################
"#########################\ Terminal Impvovement /########################
"#########################################################################

"=========================================================================
""Description: Floating terminal
""Note: This plugin's document is incomplete.
""      Use 'floaterm' in Floaterm window to open file in current [n]vim.
""      Use ':CocList floaterm' to check floaterms.
""      Fzf support is comming.
Plug 'voldikss/vim-floaterm'
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

"=========================================================================
""Description: 在vim中使用git命令 :h fugitive.txt 以查看用法
Plug 'tpope/vim-fugitive'

"=========================================================================
""Description: Git history and commit details, support fugitive commands.
Plug 'cohama/agit.vim'
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1

"=========================================================================
""Description: Uses the sign column to indicate added, modified and removed lines
""             Faster than vim-gitgutter.
""Note: Master branch need async support.
""Alternatives: airblade/vim-gitgutter, see Abandoned Plugins
if has('nvim') || has('patch-8.0.902')
    Plug 'mhinz/vim-signify'
else
    Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
""default updatetime 4000ms is not good for async update
set updatetime=100
let g:signify_sign_add               = '▏'
let g:signify_sign_delete_first_line = '▔'
let g:signify_sign_delete            = '▎'
let g:signify_sign_change            = '░'
highlight SignifySignAdd    ctermfg=green  guifg=#A6DB29 cterm=NONE gui=NONE
highlight SignifySignDelete ctermfg=red    guifg=#ff0000 cterm=NONE gui=NONE
highlight SignifySignChange ctermfg=yellow guifg=#ffff00 cterm=NONE gui=NONE


"#########################################################################
"#################################\ Msic /################################
"#########################################################################

"=========================================================================
""Description: Async Colour
""asynchronously displaying the colours in the file
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }

"=========================================================================
""Description: Add Enddings Automatically
Plug 'tpope/vim-endwise'

"=========================================================================
""Description: Use suda://<file> instead of file to get high permission
Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite
let g:suda#prefix = 'sudo:'


"#########################################################################
"##########################\ Abandoned Plugins /##########################
"#########################################################################

"=========================================================================
""Description: Vim Startup Interface
" Plug 'hardcoreplayers/dashboard-nvim'
" let g:dashboard_default_executive ='fzf'
" " nmap <Leader>ss :<C-u>SessionSave<CR>
" " nmap <Leader>sl :<C-u>SessionLoad<CR>
" " nnoremap <silent> <Leader>fh :History<CR>
" " nnoremap <silent> <Leader>ff :Files<CR>
" " nnoremap <silent> <Leader>tc :Colors<CR>
" " nnoremap <silent> <Leader>fa :Rg<CR>
" " nnoremap <silent> <Leader>fb :Marks<CR>
" " let g:dashboard_custom_header =
" ""Default headers: /.config/nvim/plugins/dashboard-nvim/autoload/dashboard/header.vim
" ""Cowsay???
" " let g:dashboard_custom_header = 'dashboard#pad(dashboard#fortune#cowsay())'
" let g:dashboard_default_header = 'default'
" let g:dashboard_custom_footer =  system('fortune')
" let g:dashboard_custom_shortcut={
"   \ 'last_session'       : '',
"   \ 'find_history'       : '',
"   \ 'find_file'          : '',
"   \ 'change_colorscheme' : '',
"   \ 'find_word'          : '',
"   \ 'book_marks'         : '',
"   \ }

"=========================================================================
""Description:  ultisnips 代码段补全
" Plug 'SirVer/ultisnips'            " improved vim-snipmate
" let g:UltiSnipsSnippetDirectorie
" " 允许使用SnipMate代码段
" let g:UltiSnipsEnableSnipMat
" " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<c-c>"
" " 在代码段内跳转
" let g:UltiSnipsJumpForwardTrigger="jj"
" let g:UltiSnipsJumpBackwardTrigger="kk"
" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
" Plug 'alohaia/vim-snippets'               " snips for snipmate and ultisnips

"=========================================================================
""Description: YouCompleteMe Code Completing
" Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 ./install.py --clangd-completer'}
" let g:ycm_global_ycm_extra_conf='~/.vim/plugins/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" ""也可以将该文件移到其他目录，如：
" "let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" ""禁用syntastic来对python检查
" ""禁用语法检查
" let g:ycm_show_diagnostics_ui = 0
" " let g:syntastic_ignore_files=[".*\.py$"]
" " 使用ctags生成的tags文件
" let g:ycm_collect_identifiers_from_tag_files = 1
" " 在定义和声明之间跳转 "DefinitionElseDeclaration
" nnoremap <leader>] :YcmCompleter GoTo <C-R>=expand("<cword>")<CR><CR>
" "关键字补全
" let g:ycm_seed_identifiers_with_syntax = 1
" " 在接受补全后不分裂出一个窗口显示接受的项
" set completeopt-=preview
" " 不显示开启vim时检查ycm_extra_conf文件的信息
" let g:ycm_confirm_extra_conf=0
" " 每次重新生成匹配项，禁止缓存匹配项
" let g:ycm_cache_omnifunc=0
" " 在注释中也可以补全
" let g:ycm_complete_in_comments=1
" " 输入第一个字符就开始补全
" let g:ycm_min_num_of_chars_for_completion=1
" " 查询ultisnips提供的代码模板补全
" let g:ycm_use_ultisnips_completer=1
" "disable ycm 语法检查(syntastic)
" let g:ycm_enable_diagnostic_signs = 0
" let g:ycm_enable_diagnostic_highlighting = 0
" ""错误标识符
" let g:ycm_error_symbol='>>'
" ""警告标识符
" let g:ycm_warning_symbol='>*'
" ""让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
" set completeopt=longest,menu
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif    "离开插入模式后自动关闭预览窗口
" ""inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    "回车即选中当前项
" ""上下左右键的行为 会显示其他信息
" inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
" inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
" inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
" ""youcompleteme  默认tab  s-tab 和自动补全冲突(已将 snip 补全快捷键设置为 <c-c>)
" "let g:ycm_key_list_select_completion=['<c-n>']
" "let g:ycm_key_list_select_completion = ['<Down>']
" "let g:ycm_key_list_previous_completion=['<c-p>']
" "let g:ycm_key_list_previous_completion = ['<Up>']
" ""关闭加载.ycm_extra_conf.py提示
" "let g:ycm_confirm_extra_conf=0
"
" ""配置文件 .ycm_extra_conf.py 生成器
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

"=========================================================================
""Description: zem mode
" Plug 'amix/vim-zenroom2', {'for': 'markdown'}
" let g:goyo_width=150
" let g:goyo_margin_top = 2
" let g:goyo_margin_bottom = 2
"
" if has('win16') || has('win32')
"     au filetype markdown nnoremap <silent> <leader>z :Goyo<cr> | simalt ~x<cr>
" else
"     au filetype markdown nnoremap <silent> <leader>z :Goyo<cr>
" endif
" Plug 'junegunn/goyo.vim', {'for': 'markdown'}
" map <leader>gy :Goyo<CR>

"=========================================================================
""Description: ale 异步语法检查插件
" Plug 'dense-analysis/ale'
" "错误和警告都处理完后关闭标志列
" let g:ale_sign_column_always = 0
" ""在vim自带的状态栏中整合ale
" "let g:ale_statusline_format = ['XXH  %d','W  %d','OK']
" "let g:ale_echo_msg_error_str = "E"
" "let g:ale_echo_msg_warning_str = "W"
" ""自定义error和warning图标
" let g:ale_sign_error = '✗'
" let g:ale_sign_warning = '⚡'
" ""自定义状态栏
" let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
" let g:ale_echo_msg_error_str = '✗'
" let g:ale_echo_msg_warning_str = '⚡'
" "" ALE 补全（未开启）/显示信息/执行lint的延迟
" let g:ale_completion_delay = 100
" let g:ale_echo_delay = 10
" let g:ale_lint_delay = 200
" ""显示Linter名称,出错或警告等相关信息
" let g:ale_echo_msg_format = '[%linter%] %code%: %s [%severity%]'
" ""check code manually - :ALELint
" let g:ale_lint_on_text_changed = 'never'   " never nromal
" let g:ale_lint_on_enter = 1
" let g:ale_lint_on_save = 1
" let g:ale_lint_on_filetype_changed = 1
" let g:ale_lint_on_insert_leave = 0
" "" 整合到airline中
" let g:airline#extensions#ale#enabled = 1
" let airline#extensions#ale#error_symbol = '✗'
" let airline#extensions#ale#warning_symbol = '⚡'
" let g:ale_linters_explicit = 1
" ""see :h ale-supported-list     " cppcheck only check file on disk.
" let g:ale_linters = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'asm': ['gcc'],
" \   'nasm': ['nasm'],
" \   'c': ['cppcheck', 'clang'],
" \   'cpp': ['cppcheck', 'clang'],
" \   'cmake': ['cmake-format'],
" \   'python': ['flake8', 'pylint'],
" \   'cuda': ['nvcc'],
" \   'go': ['gofmt'],
" \   'java': ['javac'],
" \   'javascript': ['eslint'],
" \   'shell': ['shell -n flag'],
" \   'lua': ['luac'],
" \   'yaml': ['prettier'],
" \   'latex': ['alex'],
" \   'vue': ['eslint'],
" \ }
" ""如果有需要，可以在这里设置补全程序的选项
" " let g:ale_python_flake8_options
" " let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
" " let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
" " let g:ale_c_cppcheck_options = ''
" " let g:ale_cpp_cppcheck_options = ''
" " let g:ale_c_clangd_options = ''
" " let g:ale_cpp_clangd_options = ''
" ""Bind F8 to fixing problems with ALE
" nmap <F8> <Plug>(ale_fix)
" ""前、后一个错误或警告
" nmap sp <Plug>(ale_previous_wrap)
" nmap np <Plug>(ale_next_wrap)
" ""开启／关闭语法检查
" " nmap <Leader>s :ALEToggle<CR>
" ""<Leader>d查看错误或警告的详细信息
" " nmap <Leader>d :ALEDetail<CR>
" ""设置高亮和一些颜色
" let g:ale_set_highlights = 1
" hi! SpellBad gui=undercurl guisp=red
" hi! SpellCap gui=undercurl guisp=blue
" hi! SpellRare gui=undercurl guisp=magenta
" "" 去除部分高亮显示
" "hi! clear SpellBad
" "hi! clear SpellCap
" "hi! clear SpellRare


"=========================================================================
""Description: Tex
" Plug 'lervag/vimtex', {'on': 'This Plugin is disabled.'}
" "let g:vimtex_view_method = ''
" let g:vimtex_view_general_viewer = 'llpp'
" let g:vimtex_mappings_enabled = 0
" let g:vimtex_text_obj_enabled = 0
" let g:vimtex_motion_enabled = 0
" let maplocalleader=' '

"=========================================================================
""Description: Visualize Vim undotree.
" Plug 'simnalamburt/vim-mundo'
" " func MundoTreeRefresh()
" "     MundoToggle
" "     MundoToggle
" " endfunc
" " au BufRead  * call MundoTreeRefresh()
" " au BufWrite * call MundoTreeRefresh()
" " au BufEnter * call MundoTreeRefresh()
" let g:mundo_width = 30
" let g:mundo_preview_height = 10
" let g:mundo_right = 1


"=========================================================================
""Description: Uses the sign column to indicate added, modified and removed lines.
" Plug 'airblade/vim-gitgutter'
" " let g:gitgutter_signs = 0
" let g:gitgutter_sign_allow_clobber = 0
" let g:gitgutter_map_keys = 0
" let g:gitgutter_override_sign_column_highlight = 0
" let g:gitgutter_preview_win_floating = 1
" let g:gitgutter_sign_added = '▎'
" let g:gitgutter_sign_modified = '░'
" let g:gitgutter_sign_removed = '▏'
" let g:gitgutter_sign_removed_first_line = '▔'
" let g:gitgutter_sign_modified_removed = '▒'
" " autocmd BufWritePost * GitGutter
" nnoremap <LEADER>gf :GitGutterFold<CR>
" nnoremap H :GitGutterPreviewHunk<CR>
" nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
" nnoremap <LEADER>g= :GitGutterNextHunk<CR>

"Plug 'fholgado/minibufexpl.vim'
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"hi MBENormal               guifg=#808080 guibg=fg
"hi MBEChanged              guifg=#CD5907 guibg=fg
"hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
"hi MBEVisibleChanged       guifg=#F1266F guibg=fg
"hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=fg
"hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg


"Plug 'garbas/vim-snipmate'
"ino <C-j> <C-r>=snipMate#TriggerSnippet()<cr>
"snor <C-j> <esc>i<right><C-r>=snipMate#TriggerSnippet()<cr>
"let g:snipMate = {}
"let g:snipMate.snippet_version = 1
"let g:snipMate.scope_aliases = {}
"let g:snipMate.scope_aliases['cpp'] = 'c,cpp'
"let g:snipMate.decsription_in_completion = 1

"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim', {'on' : 'This plugin is disabled.'}              " needed by snipmate


"Plug 'itchyny/lightline.vim'
"let g:lightline = {
"      \ 'colorscheme': 'powerline',
"      \ 'active': {
"      \   'left': [ ['mode', 'paste'],
"      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
"      \   'right': [ [ 'lineinfo' ], ['percent'] ]
"      \ },
"      \ 'component': {
"      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
"      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
"      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
"      \ },
"      \ 'component_visible_condition': {
"      \   'readonly': '(&filetype!="help"&& &readonly)',
"      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
"      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
"      \ },
"      \ 'separator': { 'left': ' ', 'right': ' ' },
"      \ 'subseparator': { 'left': ' ', 'right': ' ' }
"      \ }


" Plug 'terryma/vim-multiple-cursors'
" let g:multi_cursor_use_default_mapping=0
" ""Default mapping
" map <C-n> <nop>
" map <C-a> <nop>
" map <C-p> <nop>
" map <C-s> <nop>
" let g:multi_cursor_start_word_key      = '<C-n>'
" let g:multi_cursor_select_all_word_key = '<C-a>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<C-a>'
" let g:multi_cursor_next_key            = '<C-n>'
" let g:multi_cursor_prev_key            = '<C-p>'
" let g:multi_cursor_skip_key            = '<C-s>'
" let g:multi_cursor_quit_key            = '<Esc>'
"
" let g:multi_cursor_support_imap=1
" let g:multi_cursor_exit_from_visual_mode=0
" let g:multi_cursor_exit_from_insert_mode=0
" ""使 vim 命令可以正常使用
" let g:multi_cursor_normal_maps={
"    \ '@': 1, 'F': 1, 'T': 1, '[': 1, '\': 1, ']': 1,
"    \ '!': 1, '"': 1, 'c': 1, 'd': 1, 'f': 1, 'g': 1,
"    \ 'm': 1, 'q': 1, 'r': 1, 't': 1, 'y': 1, 'z': 1,
"    \ '<': 1, '=': 1, '>': 1, 'i': 1, 'a': 1}
" let g:multi_cursor_visual_maps={'T': 1, 'a': 1, 't': 1, 'F': 1, 'f': 1, 'i': 1}
"
" " 避免在插入模式中与其他插件冲突
" function! Multiple_cursors_before()
"  if exists(':NeoCompleteLock')==2
"    exe 'NeoCompleteLock'
"  endif
" endfunction
"
" function! Multiple_cursors_after()
"  if exists(':NeoCompleteUnlock')==2
"    exe 'NeoCompleteUnlock'
"  endif
" endfunction
"
" " Default highlighting (see help :highlight and help :highlight-link)
" highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
" highlight link multiple_cursors_visual Visual


"#########################################################################
"                             Tagbar, 需要安装 ctags
"       其他语言支持，见https://github.com/majutsushi/tagbar/wiki
"#########################################################################
" Plug 'majutsushi/tagbar'
" nnoremap <leader>tb :TagbarToggle<cr>
" " 当 ctags 不在PATH指定的目录中时，需要自行指定 ctags 的路径
" " let g:tagbar_ctags_bin = '...\ctags.exe'
" " 跳转后自动关闭
" let g:tagbar_autoclose = 0
" let g:tagbar_autofocus = 0
" let g:tagbar_left = 0
" let g:tagbar_width = 40
" let g:tagbar_zoomwidth = 0  " 只使用所需的最大列数
" let g:tagbar_vertical = 0   " 指定垂直窗口中显示的行数，为0时使用水平窗口
" let g:tagbar_sort = 0       " 1 to sort by name
" let g:tagbar_case_insensitive = 0   " set to 1 to use case-insensitive comparision while sorting
" let g:tagbar_compact = 1    " 隐藏顶部的帮助提示
" let g:tagbar_indent = 2     " 缩进空格数
" let g:tagbar_singleclick = 0
" let g:tagbar_foldlevel = 99 " 展开的最大级数
" let g:tagbar_iconchars = ['▸', '▾']
" " 操作系统 encoding
" " let g:tagbar_systemenc = 'cp936'
" " Tagbar 状态栏显示内容
" function! TagbarStatusFunc(current, sort, fname, flags, ...) abort
"     let colour = a:current ? '%#StatusLine#' : '%#StatusLineNC#'
"     let flagstr = join(flags, '')
"     if flagstr != ''
"         let flagstr = '[' . flagstr . '] '
"     endif
"     return colour . '[' . sort . '] ' . flagstr . fname
" endfunction
" let g:tagbar_status_func = 'TagbarStatusFunc'
" let g:tagbar_use_cache = 1  " 使用缓存文件来加速 ctags 的解析
"
" highlight TagbarVisiblityPrivate guifg=Red ctermfg=Red
" highlight TagbarVisiblityProtected guifg=Blue ctermfg=Blue
" highlight TagbarVisiblityPublic guifg=Green ctermfg=Green
"
" let g:tagbar_type_cpp = {
"             \ 'ctagstype' : 'c++',
"             \ 'kinds'     : [
"                 \ 'd:macros:1:0',
"                 \ 'p:prototypes:1:0',
"                 \ 'g:enums',
"                 \ 'e:enumerators:0:0',
"                 \ 't:typedefs:0:0',
"                 \ 'n:namespaces',
"                 \ 'c:classes',
"                 \ 's:structs',
"                 \ 'u:unions',
"                 \ 'f:functions',
"                 \ 'm:members:0:0',
"                 \ 'v:variables:0:0'
"             \ ],
"             \ 'sro'        : '::',
"             \ 'kind2scope' : {
"                 \ 'g' : 'enum',
"                 \ 'n' : 'namespace',
"                 \ 'c' : 'class',
"                 \ 's' : 'struct',
"                 \ 'u' : 'union'
"             \ },
"             \ 'scope2kind' : {
"                 \ 'enum'      : 'g',
"                 \ 'namespace' : 'n',
"                 \ 'class'     : 'c',
"                 \ 'struct'    : 's',
"                 \ 'union'     : 'u'
"             \ }
"         \ }

" Plug 'xolox/vim-session'
" Plug 'xolox/vim-misc' " vim-session dep
" Dependencies
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'kana/vim-textobj-user'
" Plug 'roxma/nvim-yarp'

"=========================================================================
""Description: Bookmarks
"Plug 'MattesGroeger/vim-bookmarks'

"=========================================================================
""Description: Looking for documents.
""Dependencies: zeal(zeavim.vim)
Plug 'KabbAmine/zeavim.vim'        " <LEADER>z to find doc offline with zeal.
Plug 'keith/investigate.vim'       " Looking documentation online/offline

"=========================================================================
""Description: Using build-in terminal
"Plug 'kassio/neoterm'

"=========================================================================
""Description: Vim plugin for insert mode completion of words in adjacent tmux panes
" Plug 'wellle/tmux-complete.vim'


call plug#end()


""utf-8 icons \u259* ... \u2756
"▐ ░ ▒ ▓ ▔ ▕ ▖ ▗ ▘ ▙ ☁ ☂ ☃ ☄ ★ ☆ ☇ ☈ ☉ ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▉ "
"╰ ╱ ╲ ╳ ╴ ╵ ╶ ╷ ╸ ╹ ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ═ ║ ╒ ╓ ╔ ╕ ╖ ╗ ╘ ╙ "
"╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┠ ┡ ┢ ┣ ┤ ┥ ┦ ┧ ┨ ┩ "
"┐ ┑ ┒ ┓ └ ┕ ┖ ┗ ┘ ┙ ─ ━ │ ┃ ┄ ┅ ┆ ┇ ┈ ┉
"⌘ ❖ ❀ ❁ ✿ ✾ ⌖ ⚙ ⌚⌛⌬ ⌭ ⌮  ⌯  ⌰ ⌱ ⌲ ⌳ ⌴ ⌵ ⌶ ⌷ ⌸ ⌹ ﴿"
"♔ ♕ ♖ ♗ ♘ ♙ ♚ ♛ ♜ ♝ ♞ ♟ "
"⎗ ⎘ ⎙ ⎚ ⏍ ⏻ 🗂 "
"|¦┊
