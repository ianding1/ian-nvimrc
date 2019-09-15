call add(g:coc_global_extensions, 'coc-texlab')

call altnvim#LoadCocSettings(expand('<sfile>:r:r'))

autocmd BufRead,BufNewFile *.tex setlocal tw=80 sts=2 sw=2
