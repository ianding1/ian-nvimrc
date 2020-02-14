" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'godlygeek/tabular'
endfunction

call altnvim#Use({
      \ 'name': 'markdown',
      \ 'plugin': function('s:Plugin')
      \ })
