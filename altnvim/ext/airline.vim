" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'vim-airline/vim-airline'
endfunction

function! s:Settings() abort
  " Use unicode characters in airline.
  let g:airline_powerline_fonts = 1

  " Disable word count in airline.
  let g:airline#extensions#wordcount#enabled = 0

  " Do not show mode in the echo area.
  set noshowmode
endfunction

call altnvim#Use({
      \ 'name': 'airline',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings')
      \ })
