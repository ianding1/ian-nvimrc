" vim: sw=2 sts=2

" Use the dark theme of onedark
set background=dark

let v:errmsg = ''
silent! colorscheme onedark

if v:errmsg == ''
  " Set airline theme to onedark.
  let g:airline_theme = 'onedark'
endif
