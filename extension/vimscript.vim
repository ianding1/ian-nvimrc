" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'junegunn/vader.vim'
endfunction

call altnvim#Use({
      \ 'name': 'vimscript',
      \ 'plugin': function('s:Plugin'),
      \ 'coc_extensions': ['coc-vimlsp']
      \ })
