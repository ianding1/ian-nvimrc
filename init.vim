" vim: sw=2 sts=2

set nocompatible

call altnvim#EnableExtensions([
      \ 'onedark',
      \ 'basic',
      \ 'git',
      \ 'asyncrun',
      \ 'coc',
      \ 'haskell',
      \ 'markdown',
      \ 'cpp',
      \ 'python',
      \ 'ocaml',
      \ 'vimscript',
      \ 'typescript',
      \ ])

let &runtimepath.=','.escape(expand('<sfile>:p:h') . '/local', '\,')
runtime localinit.vim

call altnvim#LoadExtensions()
