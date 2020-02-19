" vim: sts=2 sw=2

function s:Settings() abort
  nnoremap <silent> [b :<c-u>bprevious<cr>
  nnoremap <silent> ]b :<c-u>bnext<cr>
endfunction

call altnvim#Use({
      \ 'name': 'brackets',
      \ 'settings': function('s:Settings'),
      \ })
