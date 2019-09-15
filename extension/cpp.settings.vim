" vim: sts=2 sw=2

augroup altnvim_cpp
  autocmd!
  autocmd BufNewFile,BufReadPre *.c,*.cpp setlocal sw=2 sts=2
augroup END

call extend(g:Lf_WildIgnore['file'], ['*.[od]'])
call extend(g:NERDTreeIgnore, ['\.[od]$'])

if executable('ccls')
  call altnvim#LoadCocSettings(expand('<sfile>:r:r'))
else
  echomsg 'ccls not found'
endif
