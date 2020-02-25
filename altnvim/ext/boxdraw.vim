" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'gyim/vim-boxdraw'
endfunction

function! s:Settings() abort
  " Enable virtual editing
  nnoremap +e :<c-u>set virtualedit=all

  " Disable virtual editing
  nnoremap +d :<c-u>set virtualedit=
endfunction

call altnvim#Use({
      \ 'name': 'boxdraw',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings'),
      \ })
