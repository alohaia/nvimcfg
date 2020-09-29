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

call plug#begin(g:main_runtimepath."plugins/")

"=========================================================================
""Description: A plugin to manage other plugins.
""Note: You need to create a link of plug.vim under nvim/autoload or .vim/autoloda
""Alternatives: Shougo/dein.vim(Async), VundleVim/Vundle.vim
Plug 'junegunn/vim-plug'
"=========================================================================
""Description: vim-which-key is vim port of emacs-which-key that displays available keybindings in popup.
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
"=========================================================================
""Description: Vim Startup Interface
""Alternatives: hardcoreplayers/dashboard-nvim
Plug 'mhinz/vim-startify'
"=========================================================================
""Description: Visualize vim undotree.
""Alternatives: simnalamburt/vim-mundo
Plug 'mbbill/undotree'
"=========================================================================
""Description: Use Ranger in a floating window
""Dependencies: ranger, pynvim, [ ueberzug(preview pictures), bat(for highlight and faster preview, highly recommended) ]
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
"=========================================================================
""Description: File tree
""Dependencies: See below
if has('nvim')
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/defx.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
"=========================================================================
""Description: Land on window you chose like tmux's 'display-pane'
Plug 't9md/vim-choosewin'
"=========================================================================
""Description: Icons and git status for defx.
""Dependencies: Shougo/defx.nvim
Plug 'kristijanhusak/defx-icons'
"":Defx -columns=icons:indent:filename:type
Plug 'kristijanhusak/defx-git'
"":Defx -columns=git:mark:filename:type
"=========================================================================
""Description: Tag list
""Dependencies: ctags/..., see :echo g:vista#executives
Plug 'liuchengxu/vista.vim'
"=========================================================================
""Description: Other visual enhancement
""Dependencies: Nerd fonts, such as nerd-fonts-fira nerd-fonts-jetbrains-mono and etc.
""A lot of unicode icons.( nerd-fonts needed )
Plug 'ryanoasis/vim-devicons'
"=========================================================================
""Description: Cursor shape change in insert and replace mode & Improved mouse support
Plug 'wincent/terminus'
"=========================================================================
""Description: 状态栏美化、tabline
Plug 'vim-airline/vim-airline'
"=========================================================================
""Description: Schemes for airline
""Dependencies: vim-airline/vim-airline
""Recommend: cool, airlineish
Plug 'vim-airline/vim-airline-themes'
Plug 'rafalbromirski/vim-airlineish'
"=========================================================================
""Description: Open a color table.
Plug 'guns/xterm-color-table.vim'
" Provides command :XtermColorTable, as well as variants for different splits
""See currently enabled highlight groups :so $VIMRUNTIME/syntax/hitest.vim
""See highlight info of text under the cursor :Showhi
"=========================================================================
""Description: vim-polyglot，开箱即用型的语法高亮包
let g:polyglot_disabled = ['markdown']
Plug 'sheerun/vim-polyglot'
"=========================================================================
""Description: c++ 语法高亮增强包
Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}
"=========================================================================
""Description: Highlighting fo go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
"=========================================================================
""Description: Schemes for vim
""Recommend: molokai iceberg solarized8_dark solarized8_light
Plug 'flazz/vim-colorschemes'
"=========================================================================
""Description: Color other uses of the current word under the cursor.
Plug 'RRethy/vim-illuminate'
"=========================================================================
""Description: Plugin for fuzzy finder, search everything in vim!
""Dependencies: fzf, [mlocate, ]others see :h fzf-vim-dependencies
""Alternatives: Shougo/denite.nvim
Plug 'junegunn/fzf.vim'
"=========================================================================
""Description: Fzf interface for creating .gitignore files using the gitignore.io API.
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
"=========================================================================
""Description: Vim plugin for "jump to defitinition" and "find usages" feature through nice popup ui.
Plug 'pechorin/any-jump.vim'
"=========================================================================
""Description: Find & Replace text through multiple files.
""Dependencies: ag(the_silver_searcher, optional)/rg(faster)
""Note: pay attention to \ " and space for pattren
"Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }
Plug 'brooth/far.vim'
"=========================================================================
""Description: Framework for Auto Complete, Syntax Check and etc.
""Dependencies: ccls, pip install 'python-language-server[all]'
""Alternatives: ncm2/ncm2, ycm-core/YouCompleteMe, dense-analysis/ale
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"=========================================================================
""Description:  ultisnips 代码段补全
Plug 'SirVer/ultisnips'            " improved vim-snipmate
"=========================================================================
""Description: Debug
Plug 'puremourning/vimspector'
Plug 'skywind3000/asyncrun.vim'
"=========================================================================
""Description: 为 Vim 引入类似 vscode 的 tasks 任务系统，
""             用统一的方式系统化解决各类：编译/运行/测试/部署任务。
""             The generic way to handle building/running/testing/deploying
""             tasks by imitating vscode's task system.
Plug 'skywind3000/asynctasks.vim'
"=========================================================================
""Description: Auto change
Plug 'airblade/vim-rooter'
"=========================================================================
""Description: <C-l>(if not already used)/<C-g>c (insert) to toggle capslock
Plug 'tpope/vim-capslock'
"=========================================================================
""Description: 'after' text objects for v/c/d/y
Plug 'junegunn/vim-after-object' " da= to delete what's after =
"=========================================================================
""Description: Improved motion
Plug 'easymotion/vim-easymotion'
"=========================================================================
""Description: ["reg]s<motion/txtobj> 使用[默认]寄存器中的内容替换指定内容
""Dependencies: [tpope/vim-abolish], [svermeulen/vim-yoink]
""Note: The key 's' is shadowed, use 'cl' instead.
Plug 'svermeulen/vim-subversive'
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
"=========================================================================
""Description: Rotate between yank histories.
Plug 'svermeulen/vim-yoink'
"=========================================================================
""Description: Improved f/F/t/T
Plug 'rhysd/clever-f.vim'
"=========================================================================
""Description: 断行/合并，支持多种语言
Plug 'AndrewRadev/splitjoin.vim'
"=========================================================================
""Description: Fast Commenting
Plug 'preservim/nerdcommenter'
"=========================================================================
""Description: Fast Commenting
Plug 'tpope/vim-commentary'
"=========================================================================
""Description: Vim Multi-Cursors and Aligning
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"=========================================================================
""Description: Handle Surronuds
Plug 'tpope/vim-surround'
"=========================================================================
""Description: Enables . command plugin mappings
Plug 'tpope/vim-repeat'
"=========================================================================
""Description: Auto make pairs.
" Plug 'Raimondi/delimitMate'
"=========================================================================
""Description: Auto Make Pairs
"Note: Seems not being maintained any longer and does not works well with Ultisnips.
Plug 'jiangmiao/auto-pairs'
"=========================================================================
""Description: Add Enddings Automatically
Plug 'tpope/vim-endwise'
"=========================================================================
""Description: Syntax highlighting, matching rules and mappings for the original Markdown and extensions.
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"=========================================================================
""Description: MarkDown Prevew
""Alternatives: suan/vim-instant-markdown
""Also support MathJex without this plugin. ???
" Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
"=========================================================================
""Description: Table Mod
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
"=========================================================================
""Description: Auto generate and update MarkDown TOC
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
"=========================================================================
""Description: Bullet List
""Dependencies: xclip(linux)
Plug 'dkarter/bullets.vim'
"=========================================================================
""Description: Paste images in vim.
Plug 'alohaia/md-img-paste.vim'
"=========================================================================
""Description: Tex support for vim.
""Dependencies: Texlive-core
Plug 'lervag/vimtex'
"=========================================================================
""Description: 『盘古之白』中文排版自动规范化的 Vim 插件
""在保存时自动进行如下规范
" 中英文字符间增加一个半角空白。
" 中文前后的半角标点转成全角标点。
" 全角英文、数字转成半角字符。
" 连续的句号自动转省略号。
" 感叹号、问号最多允许连续重复 3 次。
" 其他中文标点符号不允许重复出现。
""设置保存时自动格式化
Plug 'hotoo/pangu.vim'
"=========================================================================
""Description: Floating terminal
""Note: This plugin's document is incomplete.
""      Use 'floaterm' in Floaterm window to open file in current [n]vim.
""      Use ':CocList floaterm' to check floaterms.
""      Fzf support is comming.
Plug 'voldikss/vim-floaterm'
"=========================================================================
""Description: 在vim中使用git命令 :h fugitive.txt 以查看用法
Plug 'tpope/vim-fugitive'
"=========================================================================
""Description: Git history and commit details, support fugitive commands.
Plug 'cohama/agit.vim'
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
"=========================================================================
""Description: Looking for documents.
""Dependencies: zeal(zeavim.vim)
Plug 'KabbAmine/zeavim.vim'        " <LEADER>z to find doc offline with zeal.
"=========================================================================
""Description: 用竖线(或其他字符显示缩进)
Plug 'Yggdroot/indentLine', {'for' : ['python']}
"============================\ indentLine /=============================
"=========================================================================
""Description: ColorfulBrackets
Plug 'luochen1990/rainbow'
"=========================================================================
""Description: AutoFormat
Plug 'Chiel92/vim-autoformat'
"=========================================================================
""Description: Zen Mode, help you concentrate.
Plug 'junegunn/goyo.vim'
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
"=========================================================================
""Description: Multi-language thesaurus query/replacement
Plug 'ron89/thesaurus_query.vim'
"=========================================================================
""Description: Async Colour
""asynchronously displaying the colours in the file
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
"=========================================================================
""Description: Use suda://<file> instead of file to get high permission
Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite
"=========================================================================
""Description: Display a calendar/clock in vim
Plug 'itchyny/calendar.vim'
"=========================================================================
""Description: Translator
Plug 'voldikss/vim-translator'
"=========================================================================
""Description: Bookmarks
" Plug 'MattesGroeger/vim-bookmarks'

call plug#end()

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
command! Hdefx echo
            \"=== \<leader\>df to start.===\n".
            \"  Enter       - open in chosen window\n".
            \"  c           - copy\n".
            \"  x           - move\n".
            \"  p           - paste\n".
            \"  E           - open vsplit\n".
            \"  P           - preview\n".
            \"  o           - open tree toggle\n".
            \"  N           - new directory\n".
            \"  n           - new file\n".
            \"  M           - new multiple files\n".
            \"  C           - toggle columns\n".
            \"  S           - toggle sort by time\n".
            \"  d           - remove\n".
            \"  r           - rename\n".
            \"  !           - execute command\n".
            \"  ex          - execute system\n".
            \"  yy          - yank path\n".
            \"  .           - toggle ignored files\n".
            \"  ;           - repeat\n".
            \"  h           - cd ..\n".
            \"  ~           - cd ~\n".
            \"  q           - quit\n".
            \"  s           - toggle select and up\n".
            \"  C-a         - toggle select all\n".
            \"  j           - down\n".
            \"  k           - up\n".
            \"  C-l         - redraw\n".
            \"  C-g         - print\n".
            \"  cd          - change vim cwd"
" \"  Enter       - open\n".

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
nnoremap <leader><leader> :<c-u>WhichKey ''<left>
" set timeoutlen=200                " in basic.vim
let g:which_key_map =  {}
let g:which_key_map.j = { 'name' : '+file' }
hi WhichKeyBg ctermfg=252 ctermbg=233 guifg=#F8F8F2 guibg=#1B1D1E
" highlight default link WhichKey          Function
" highlight default link WhichKeySeperator DiffAdded
" highlight default link WhichKeyGroup     Keyword
" highlight default link WhichKeyDesc      Identifier
highlight default link WhichKeyFloating  WhichKeyBg

"#########################################################################
"############################\ User Interface /###########################
"#########################################################################

"============================\ vim-startify /=============================
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
            \ {'t': ['Press t to open coc-explorer.', 'CocCommand explorer']},
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

"==============================\ undotree /===============================
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
    nnoremap <buffer> u <plug>UndotreeNextState
    nnoremap <buffer> e <plug>UndotreePreviousState
    nnoremap <buffer> U 5<plug>UndotreeNextState
    nnoremap <buffer> E 5<plug>UndotreePreviousState
endfunc

"===============================\ rnvimr /================================
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
" nnoremap <silent> <cr> :RnvimrSync<CR>:RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
" nnoremap <silent> <cr> :RnvimrToggle<CR>
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

""============================\ defx.nvim /=============================
nnoremap <silent> <leader>df :Defx<CR>
" call defx#custom#option('_', {
"       \ 'resume': 1,
"       \ 'winwidth': 30,
"       \ 'split': 'vertical',
"       \ 'direction': 'topleft',
"       \ 'show_ignored_files': 0,
"       \ 'columns': 'mark:indent:git:icons:filename',
"       \ })
call defx#custom#option('_', {
      \ 'columns': 'mark:indent:git:icon:icons:filename:type:size:time',
      \ 'sort': 'filename',
      \ 'preview_height': &lines/2,
      \ 'split': 'vertical', 'winwidth': 40, 'direction': 'topleft',
      \ 'root_marker': '[in]: ',
      \ 'buffer_name': 'Defx',
      \ 'show_ignored_files': 0, 'ignored_files': '.*,*.png,*.jpg',
      \ 'toggle': 1, 'resume': 1, 'focus': 1
      \ })
      " \ 'floating_preview': 1, 'wincol': &columns/4, 'winrow': &lines/3,
call defx#custom#column('git', 'indicators', {
      \ 'Modified'  : '✹',
      \ 'Staged'    : '⚑',
      \ 'Untracked' : '⚝',
      \ 'Renamed'   : '≫',
      \ 'Unmerged'  : '=',
      \ 'Ignored'   : '~',
      \ 'Deleted'   : '✖',
      \ 'Unknown'   : '?'
      \ })
call defx#custom#column('indent', 'indent', '  ')
function! Root(path) abort
      return fnamemodify(a:path, ':t')
endfunction
call defx#custom#source('file', {
      \  'root': 'Root',
      \ })
" defx-icons plugin
let g:defx_icons_column_length = 1
let g:defx_icons_mark_icon = ''    " ✓
let g:defx_icons_parent_icon = ""
call defx#custom#column('mark', { 'readonly_icon': '', 'selected_icon': '' })
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

function! s:defx_toggle_tree_or_edit() abort
    " Open current file, or toggle directory expand/collapse
    if defx#is_directory()
        return defx#do_action('open_or_close_tree')
    endif
    return defx#do_action('multi', ['drop'])
endfunction

function! s:defx_toggle_tree_or_cd(context) abort
    " Open current file, or toggle directory expand/collapse
    if defx#is_directory()
        return defx#call_action('cd', a:context.targets)
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
    nnoremap <silent><buffer><expr> <CR>              defx#do_action('call', g:sid.'defx_choosewin')
    nnoremap <silent><buffer><expr> l                 defx#do_action('call', g:sid.'defx_toggle_tree_or_cd')
    nnoremap <silent><buffer><expr> o                 <sid>defx_toggle_tree_or_edit()
    nnoremap <silent><buffer><expr> st                defx#do_action('multi', [['drop', 'tabnew'], 'quit'])
    nnoremap <silent><buffer><expr> v                 defx#do_action('open', 'botright vsplit')
    nnoremap <silent><buffer><expr> s                 defx#do_action('open', 'botright split')
    nnoremap <silent><buffer><expr> P                 defx#do_action('preview')
    nnoremap <silent><buffer><expr> r                 defx#do_action('rename')
    nnoremap <silent><buffer><expr> H                 defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> yy                defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .                 defx#do_action('repeat')
    nnoremap <silent><buffer><expr> b                 winnr('$') != 1 ? ':<C-u>wincmd w<CR>'
                                                          \ : ':<C-u> Defx -buffer-name=temp -split=vertical<CR>'
    nnoremap <silent><buffer><expr> j                 line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k                 line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> J                 line('.') == line('$') ? 'gg' : '5gj'
    nnoremap <silent><buffer><expr> K                 line('.') == 1 ? 'G' : '5gk'
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
    nnoremap <silent><buffer><expr> N                 defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> n                 defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M                 defx#do_action('new_multiple_files')
    ""Jump
    nnoremap <silent><buffer>  <                      :<C-u>call <SID>jump_dirty(-1)<CR>
    nnoremap <silent><buffer>  >                      :<C-u>call <SID>jump_dirty(1)<CR>
    ""Change directory
    nnoremap <silent><buffer><expr> cd                defx#do_action('change_vim_cwd')
    nnoremap <silent><buffer><expr><nowait> \         defx#do_action('cd', getcwd())
    nnoremap <silent><buffer><expr><nowait> &         defx#do_action('cd', getcwd())
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
    nnoremap <silent><buffer><expr> C                 defx#do_action('toggle_columns', 'mark:git:indent:icons:icon:filename:type:size:time')
    ""Commands
    nnoremap <silent><buffer><expr> !                 defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> ex                defx#do_action('call', g:sid.'defx_execute')
endfunction
" ""Options available: :h defx-options
" " noremap <silent> <leader>df :call g:Defx_toggle_with_my_options()<cr>
" " function g:Defx_toggle_with_my_options()
" "     " if &filetype != 'startify'
" "         Defx
" "             \ -columns=mark:git:indent:icons:icon:filename:type:size:time
" "             \ -ignored-files='.*'
" "             \ -vertical-preview -preview-width=50
" "             \ -sort='filename'
" "             \ -buffer-name='filebrowser'
" "             \ -show-ignored-files=0
" "             \ -focus -toggle
" "             "\ -columns=git:mark:indent:icons:filename:type
" "             "\ -split='vertical' -direction='topleft' -winwidth=&columns/2
" "             "\ -split='horizontal' -direction='botright' -winheight=30
" "             "\ -split='floating' -wincol=4 -winrow=0
" "             "\ -preview-height=15
" "             "\ -floating-preview -preview-height=10 -preview-width=40
" "             "\ -root-maker=
" "             "\ -search={path}
" "             "\ -session-file={path}
" "             "\ -split='floating' -direction='topleft'
" "             "\ listed
" "     " endif
" " endfunction
"
" " autocmd BufReadPre defx call s:defx_my_settings()
" " function! s:defx_my_settings() abort
" ""Customize columns: filename icon indent mark size space time type [git icons]
" call defx#custom#column('icon', {
"             \ 'directory_icon': '▸',
"             \ 'opened_icon': '▾',
"             \ 'root_icon': ' ',
"             \ })
" call defx#custom#column('filename', {
"             \ 'min_width': 40,
"             \ 'max_width': 40,
"             \ })
" call defx#custom#column('mark', {
"             \ 'readonly_icon': '✗',
"             \ 'selected_icon': '✓',
"             \ })
"
" ""Customize options
" call defx#custom#option('_', {
"             \ 'columns': 'mark:git:indent:icon:icons:space:filename:type:size:time',
"             \ 'sort': 'filename',
"             \ 'split': 'vertical', 'winwidth': 30, 'direction': 'topleft',
"             \ 'preview_height': &lines/2,
"             \ 'buffer_name': 'Defx', 'root_marker': '<Root>: ',
"             \ 'show_ignored_files': 0, 'ignored_files': '.*,*.png,*.jpg',
"             \ 'toggle': 1, 'resume': 1, 'focus': 1
"             \ })
"             " \ 'floating_preview': 1, 'wincol': &columns/4, 'winrow': &lines/3,
" " endfunction
"
" ""Define mappings
" autocmd FileType defx call s:defx_my_mappings()
" function! s:defx_my_mappings() abort
"     " nnoremap ; :
"     " nnoremap <C-l> <C-w>l
"     " nnoremap <C-h> <C-w>h
"     " nnoremap <C-j> <C-w>j
"     " nnoremap <C-k> <C-w>k
"     ""Actions available: :h defx-actions
"     " nnoremap <silent><buffer><expr> <CR>    defx#do_action('open')
"     nnoremap <silent><buffer><expr> <CR>    defx#do_action('call', 'DefxChoosewin')
"     nnoremap <silent><buffer><expr> c       defx#do_action('copy')
"     nnoremap <silent><buffer><expr> x       defx#do_action('move')
"     nnoremap <silent><buffer><expr> p       defx#do_action('paste')
"     nnoremap <silent><buffer><expr> E       defx#do_action('open', 'vsplit')
"     nnoremap <silent><buffer><expr> P       defx#do_action('preview')
"     nnoremap <silent><buffer><expr> o       defx#do_action('open_tree', 'toggle')
"     nnoremap <silent><buffer><expr> N       defx#do_action('new_directory')
"     nnoremap <silent><buffer><expr> n       defx#do_action('new_file')
"     nnoremap <silent><buffer><expr> M       defx#do_action('new_multiple_files')
"     nnoremap <silent><buffer><expr> C       defx#do_action('toggle_columns', 'mark:git:indent:icons:icon:filename:type:size:time')
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
"     nnoremap <silent><buffer><expr> <C-a>   defx#do_action('toggle_select_all')
"     nnoremap <silent><buffer><expr> j       line('.') == line('$') ? 'gg' : 'j'
"     nnoremap <silent><buffer><expr> k       line('.') == 1 ? 'G' : 'k'
"     nnoremap <silent><buffer><expr> <C-l>   defx#do_action('redraw')
"     nnoremap <silent><buffer><expr> <C-g>   defx#do_action('print')
"     nnoremap <silent><buffer><expr> cd      defx#do_action('change_vim_cwd')
" endfunction

"============================\ choosewin /=============================
nnoremap <Tab> :ChooseWin<CR>
" nnoremap <Tab> :call ChooseWin()<CR>
let g:choosewin_color_label = {
            \ 'gui':   ['#af00ff', 'black', 'bold'],
            \ 'cterm': [129, 16, 'bold']
            \}
let g:choosewin_color_label_current = {
            \ 'gui':   ['#afafff', 'white', 'bold'],
            \ 'cterm': [147, 15, 'bold']
            \ }
let g:choosewin_color_overlay = g:choosewin_color_label
let g:choosewin_color_overlay_current = g:choosewin_color_label_current
let g:choosewin_color_land = {
            \ 'gui':   ['#00ffff', 'Black', 'bold,underline'],
            \ 'cterm': [51, 15]
            \}
let g:choosewin_label_fill = 0
let g:choosewin_blink_on_land = 0
let g:choosewin_return_on_single_win = 0
""Use statusline or overlay
let g:choosewin_statusline_replace = 0
let g:choosewin_overlay_enable = 1
let g:choosewin_overlay_shade = 1
" let s:keymap = {
"             \ '0':     'tab_first',
"             \ '[':     'tab_prev',
"             \ ']':     'tab_next',
"             \ '$':     'tab_last',
"             \ 'x':     'tab_close',
"             \ ';':     'win_land',
"             \ '-':     'previous',
"             \ 's':     'swap',
"             \ 'S':     'swap_stay',
"             \ "\<CR>": 'win_land',
"             \ }
""Default filetype that will be ignored.
let s:choosewin_ignore_filetypes = []


"============================\ vista.vim /=============================
""See the full list of executivs via :echo g:vista#executives
let g:vista_default_executive = 'ctags'
""Don't sort tags
let g:vista_ctags_project_opts = '--sort=no -R -o .tags'
let g:vista_executive_for = {
            \ 'vimwiki': 'markdown',
            \ 'pandoc': 'markdown',
            \ 'markdown': 'toc',
            \ }
" let g:vista_finder_alternative_executives = ['coc']
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
let g:vista_close_on_jump = 1
let g:vista_stay_on_open = 1
""Disable blink
let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]
"let g:vista_disable_statusline = exists('g:loaded_airline') || exists('g:loaded_lightline')
""Use beautiful icons
"let g:vista#renderer#enable_icon = exists('g:vista#renderer#icons') || exists('g:airline_powerline_fonts')
let g:vista#renderer#icons = {
            \   "function": "\uf794",
            \   "variable": "\uf71b",
            \  }
" function! NearestMethodOrFunction() abort
"     return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
autocmd FileType vista,vista_kind nnoremap <buffer> <silent> f :<c-u>call vista#finder#fzf#Run()<CR>

"============================\ vim-devicons /=============================
let g:webdevicons_enable = 1
let g:webdevicons_enable_airline_tabline = 1

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
let g:airline_symbols.branch = ''
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

"============================\ ultisnips /=============================
" Plug 'alohaia/vim-snippets'               " snips for snipmate and ultisnips
""An array of relative directory names OR an array with a single absolute path.
" let g:UltiSnipsSnippetDirectories=["Ultisnips"]
" Defines how the edit window is opened.
let g:UltiSnipsEditSplit= 'context'
""Enable snippmate snippets (dirs named 'snippets' under dirs in &runtimepath)
" let g:UltiSnipsEnableSnipMate = 1
let g:UltiSnipsRemoveSelectModeMappings = 0
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-space>"
" 在代码段内跳转
let g:UltiSnipsJumpForwardTrigger="<M-j>"
let g:UltiSnipsJumpBackwardTrigger="<M-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
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
command! RunDefault AsyncTask default-run
command! BuildDefault AsyncTask default-build
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
let g:AutoPairsShortcutToggle=''
" 将一对 pair 后面的内容移到 pair 中（在 pair 内按下快捷键）
let g:AutoPairsShortcutFastWrap='<M-e>'
let g:AutoPairsShortcutJump=''
let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', '`':'`'}
au FileType html let b:AutoPairs['<'] = '>'
au FileType vim let b:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '`':'`', '<':'>'}
" 使用 Backspace 删除时会删除 pair 中的另一个
let g:AutoPairsMapBs=1
" 让使用 <C-h> 删除时不会删除 pair 中的另一个
let g:AutoPairsMapCh=0
""在pairs间输入空格
let g:AutoPairsMapSpace=1
" 将回车键映射为插入空行的操作
let g:AutoPairsMapCR=1

""FlyMode, 输入 ")", "}", "]" 总是会跳转到后方的 ")", "}", "]" 后面
let g:AutoPairsFlyMode=0
""纠正错误跳转
let g:AutoPairsShortcutBackInsert='<M-b>'


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
let g:indentLine_char = '┆'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
au BufEnter python IndentLinesEnable
au BufLeave python IndentLinesDisable

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

"==============================\ suda.vim /===============================
let g:suda#prefix = 'sudo:'

"============================\ calendar.vim /=============================
"noremap \\c :Calendar -position=here<CR>
noremap \\c :Calendar -view=clock -position=here<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
augroup calendar-mappings
    autocmd!
    " diamond cursor
    autocmd FileType calendar nnoremap <buffer> u <Plug>(calendar_up)
    autocmd FileType calendar nnoremap <buffer> n <Plug>(calendar_left)
    autocmd FileType calendar nnoremap <buffer> e <Plug>(calendar_down)
    autocmd FileType calendar nnoremap <buffer> i <Plug>(calendar_right)
    autocmd FileType calendar nnoremap <buffer> <c-u> <Plug>(calendar_move_up)
    autocmd FileType calendar nnoremap <buffer> <c-n> <Plug>(calendar_move_left)
    autocmd FileType calendar nnoremap <buffer> <c-e> <Plug>(calendar_move_down)
    autocmd FileType calendar nnoremap <buffer> <c-i> <Plug>(calendar_move_right)
    autocmd FileType calendar nnoremap <buffer> k <Plug>(calendar_start_insert)
    autocmd FileType calendar nnoremap <buffer> K <Plug>(calendar_start_insert_head)
    " unmap <C-n>, <C-p> for other plugins
    nnoremap ． .
    autocmd FileType calendar nunmap <buffer> <C-n>
    autocmd FileType calendar nunmap <buffer> <C-p>
augroup END

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


""utf-8 icons \u259* ... \u2756
"▐ ░ ▒ ▓ ▔ ▕ ▖ ▗ ▘ ▙ ☁ ☂ ☃ ☄ ★ ☆ ☇ ☈ ☉ ▀ ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ ▉ "
"╰ ╱ ╲ ╳ ╴ ╵ ╶ ╷ ╸ ╹ ╠ ╡ ╢ ╣ ╤ ╥ ╦ ╧ ╨ ╩ ═ ║ ╒ ╓ ╔ ╕ ╖ ╗ ╘ ╙ "
"╀ ╁ ╂ ╃ ╄ ╅ ╆ ╇ ╈ ╉ ┰ ┱ ┲ ┳ ┴ ┵ ┶ ┷ ┸ ┹ ┠ ┡ ┢ ┣ ┤ ┥ ┦ ┧ ┨ ┩ "
"┐ ┑ ┒ ┓ └ ┕ ┖ ┗ ┘ ┙ ─ ━ │ ┃ ┄ ┅ ┆ ┇ ┈ ┉
"⌘ ❖ ❀ ❁ ✿ ✾ ⌖ ⚙ ⌚⌛⌬ ⌭ ⌮  ⌯  ⌰ ⌱ ⌲ ⌳ ⌴ ⌵ ⌶ ⌷ ⌸ ⌹ ﴿"
"♔ ♕ ♖ ♗ ♘ ♙ ♚ ♛ ♜ ♝ ♞ ♟ "
"⎗ ⎘ ⎙ ⎚ ⏍ ⏻ 🗂 "
"|¦┊
