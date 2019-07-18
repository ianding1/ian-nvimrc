call extend(g:Lf_WildIgnore['dir'], ['node_modules'])

call add(g:coc_global_extensions, 'coc-tsserver')

augroup altnvim_typescript
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
  autocmd FileType typescript,typescript.tsx setlocal sw=2 sts=2 cc=121
endgroup
