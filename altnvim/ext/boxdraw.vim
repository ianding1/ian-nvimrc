" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'gyim/vim-boxdraw'
endfunction

function! s:Settings() abort
endfunction

call altnvim#Use({
      \ 'name': 'boxdraw',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings'),
      \ })
