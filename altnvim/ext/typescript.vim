" vim: sts=2 sw=2

function! s:Plugin() abort
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
endfunction

function! s:Settings() abort
  call extend(g:Lf_WildIgnore['dir'], ['node_modules'])
  augroup altnvim_typescript
    autocmd!
    autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
  augroup END
endfunction

call altnvim#Use({
      \ 'name': 'typescript',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings'),
      \ 'coc_extensions': ['coc-tsserver']
      \ })
