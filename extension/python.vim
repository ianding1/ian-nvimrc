" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'Vimjas/vim-python-pep8-indent'
endfunction

function! s:Settings() abort
  call extend(g:Lf_WildIgnore['file'], ['*.py[co]'])
  call extend(g:NERDTreeIgnore, ['\.py[oc]$'])

  augroup altnvim_python
    autocmd!
    autocmd FileType python setlocal sw=4 sts=4 cc=80 tw=79
  augroup END
endfunction

call altnvim#Use({
      \ 'name': 'python',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings'),
      \ 'coc_extensions': ['coc-python']
      \ })
