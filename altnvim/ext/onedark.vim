" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'joshdick/onedark.vim'
endfunction

function! s:Settings() abort
  let v:errmsg = ''
  silent! colorscheme onedark
  if v:errmsg == ''
    " Set airline theme to onedark.
    let g:airline_theme = 'onedark'
  endif
endfunction

call altnvim#Use({
      \ 'name': 'onedark',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings')
      \ })
