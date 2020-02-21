" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'godlygeek/tabular'
  Plug 'tpope/vim-markdown'
endfunction

function! s:Settings() abort
  " Enable fenced code block syntax highlighting.
  let g:markdown_fenced_languages = []

  " Enable markdown syntax concealing.
  let g:markdown_syntax_conceal = 1
endfunction

call altnvim#Use({
      \ 'name': 'markdown',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings'),
      \ })
