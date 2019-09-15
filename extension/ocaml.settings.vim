autocmd BufNewFile,BufReadPre *.ml setlocal sw=2 sts=2

if altnvim#IsExtensionEnabled('nerdtree')
  call extend(g:NERDTreeIgnore, ['\.cm[oix]$'])
endif

if executable('ocaml-language-server')
  call altnvim#LoadCocSettings(expand('<sfile>:r:r'))
else
  echomsg 'ocaml-language-server not found'
endif
