" vim: sts=2 sw=2

function s:Settings() abort
  nnoremap <silent> [b :<c-u>bprevious<cr>
  nnoremap <silent> ]b :<c-u>bnext<cr>
  nnoremap <silent> [t :<c-u>tabprevious<cr>
  nnoremap <silent> ]t :<c-u>tabnext<cr>
  nnoremap <silent> [q :<c-u>cprevious<cr>
  nnoremap <silent> ]q :<c-u>cnext<cr>
  nnoremap <silent> [l :<c-u>lprevious<cr>
  nnoremap <silent> ]l :<c-u>lnext<cr>
endfunction

call altnvim#Use({
      \ 'name': 'brackets',
      \ 'settings': function('s:Settings'),
      \ })
