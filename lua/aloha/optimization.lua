local optimization = {}

function optimization:init()
-- function s:position_load()
--     if !exists('s:positions')
--         let s:positions = {}
--     endif
--     if !has_key(s:positions, bufnr())
--         " echo 'add a key'
--         let s:positions[bufnr()] = [line("'\""), col("'\"")]
--     endif
--     " echo 'jump to' s:positions[bufnr()]
--     call cursor(s:positions[bufnr()])
-- endfunction
-- 
-- function s:position_save()
--     let l:cursor_posi = getcurpos()
--     let s:positions[bufnr()] = l:cursor_posi[1:2]
--     " echo s:positions
--     " echo 'position saved:' s:positions[bufnr()]
-- endfunction
-- 
-- au BufEnter,WinEnter * call s:position_load()
-- au BufLeave,WinLeave * call s:position_save()
-- ""关闭缓冲区，保留窗口
-- nnoremap <leader>bd :call g:BufcloseCloseIt()<cr>
-- ""Close all the buffers
-- nnoremap <leader>ba :bufdo bd<cr>
-- ""Close all the other buffers
-- ""https://blog.csdn.net/magicpang/article/details/2308167
-- nnoremap <leader>bo :call DeleteAllBuffersInWindow('noforce')<cr>
-- nnoremap <leader>BO :call DeleteAllBuffersInWindow('force')<cr>
end

return optimization
