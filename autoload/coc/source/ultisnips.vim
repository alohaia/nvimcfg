" vim source for ultisnips to intergrate with coc.nvim.

" function! s:merge_opts(dict, eopts)
"   return s:extend_opts(a:dict, a:eopts, 0)
" endfunction
"
" function! s:prepend_opts(dict, eopts)
"   return s:extend_opts(a:dict, a:eopts, 1)
" endfunction
"
" function! s:fzf(name, opts, extra)
"   let [extra, bang] = [{}, 0]
"   if len(a:extra) <= 1
"     let first = get(a:extra, 0, 0)
"     if type(first) == s:TYPE.dict
"       let extra = first
"     else
"       let bang = first
"     endif
"   elseif len(a:extra) == 2
"     let [extra, bang] = a:extra
"   else
"     throw 'invalid number of arguments'
"   endif
"
"   let eopts  = has_key(extra, 'options') ? remove(extra, 'options') : ''
"   let merged = extend(copy(a:opts), extra)
"   call s:merge_opts(merged, eopts)
"   return fzf#run(s:wrap(a:name, merged, bang))
" endfunction
"
" function! fzf#vim#snippets(...)
"   if !exists(':UltiSnipsEdit')
"     return s:warn('UltiSnips not found')
"   endif
"   let list = UltiSnips#SnippetsInCurrentScope()
"   if empty(list)
"     return s:warn('No snippets available here')
"   endif
"   let aligned = sort(s:align_lists(items(list)))
"   let colored = map(aligned, 's:yellow(v:val[0])."\t".v:val[1]')
"   return s:fzf('snippets', {
"   \ 'source':  colored,
"   \ 'options': '--ansi --tiebreak=index +m -n 1 -d "\t"',
"   \ 'sink':    s:function('s:inject_snippet')}, a:000)
" endfunction
"
" function! s:strip(str)
"   return substitute(a:str, '^\s*\|\s*$', '', 'g')
" endfunction
"
" function! s:inject_snippet(line)
"   let l:snip = split(a:line, "\t")[0]
"   execute 'normal! a'.s:strip(l:snip)."\<c-r>=UltiSnips#ExpandSnippet()\<cr>"
" endfunction

""""""""""  Optional Functions """""""""""""""
" coc#source#{name}#refresh(): called when user does a refresh action for source.
" coc#source#{name}#should_complete(option): called with completion option, returns 0 or other falsy value to skip completion for current completion.
" coc#source#{name}#get_startcol(option): called with completion option, should return completion start column number when function exists, other source is disabled if the returned column number is not option.col
" coc#source#{name}#on_complete(item): called with vim complete item when it's selected by user.

function! coc#source#ultisnips#init() abort
    return {
        \ 'priority': 9,
        \ 'shortcut': 'Ulti',
        \ 'triggerCharacters': ['']
        \}
endfunction

function! coc#source#ultisnips#complete(opt, cb) abort
    let items = keys(UltiSnips#SnippetsInCurrentScope())
    call a:cb(items)
    " call UltiSnips#ExpandSnippet()
endfunction

""""""""""""""""" Result of completion """"""""""""""
" Result are returned by a callback function (second argument). The result should be list of vim completion items, or falsy value for invalid results.
"
" Check out :h complete-items for available fields.
