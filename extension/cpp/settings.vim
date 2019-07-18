" vim: sts=2 sw=2

augroup altnvim_cpp
  autocmd!
  autocmd BufNewFile,BufReadPre *.c,*.cpp setlocal sw=2 sts=2
augroup END

if altnvim#IsExtensionEnabled('leaderf')
  call extend(g:Lf_WildIgnore['file'], ['*.[od]'])
endif

if altnvim#IsExtensionEnabled('nerdtree')
  call extend(g:NERDTreeIgnore, ['\.[od]$'])
endif


if executable('ccls')
  call altnvim#LoadCocSettings(expand('<sfile>:p:h'))
else
  echomsg 'ccls not found'
endif
