" vim: sw=2 sts=2

unlet! skip_defaults_vim
set nocompatible

let &runtimepath.=','.escape(expand('~/.altnvim'), '\,')
let &runtimepath.=','.escape(expand('~/.altnvim/local'), '\,')

let g:coc_user_config = {'languageserver': {}}

call altnvim#EnableExtensions([
      \ 'onedark',
      \ 'basic',
      \ 'git',
      \ 'asyncrun',
      \ 'coc',
      \ 'haskell',
      \ 'markdown',
      \ 'cpp',
      \ 'ocaml',
      \ 'python',
      \ 'vimscript',
      \ 'typescript',
      \ 'tex',
      \ 'sml',
      \ ])

runtime localinit.vim

call altnvim#LoadExtensions()
