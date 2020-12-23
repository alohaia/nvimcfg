" hi VimwikiLink cterm=underline ctermfg=32 gui=underline guifg=#0087df

" syntax match VimwikiLink /!\?\[.*\]\(.*\)/ conceal cchar=$2

" syntax region VimwikiLinkDes start=/!\?\[/ end=/](.*)/ contains=VimwikiLinkPos conceal
" syntax region VimwikiLinkDes start=/(/ end=/)/ contained conceal

syntax region VimwikiMdRef start=/^>\s/ end=/^$/
syntax region VimwikiHtmlLable start=/</ end=/>/
" syntax region VimwikiBlod start=/\*\*/ end=/\*\*/ contains=ALL

hi link VimwikiMdRef Comment
hi link VimwikiHtmlLable Comment

echomsg "Mine Loaded Successfully."

"![asdfa](sdfasdf)
