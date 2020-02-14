" vim: sw=2 sts=2

function! s:Plugin() abort
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
endfunction

function! s:Settings() abort
  " Don't set up any mappings.
  let g:gitgutter_map_keys = 0

  " Show git status in a new tab.
  nnoremap <silent> <leader>g :Gtabedit :<cr>
endfunction

call altnvim#Use({
      \ 'name': 'git',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings')
      \ })
