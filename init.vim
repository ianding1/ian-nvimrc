" vim: sw=2 sts=2

unlet! skip_defaults_vim
set nocompatible

let g:altnvim_extensions = [
      \ 'basic',
      \ 'onedark',
      \ 'git',
      \ 'markdown',
      \ 'coc',
      \ 'cpp',
      \ 'ocaml',
      \ 'python',
      \ 'tex',
      \ 'typescript',
      \ 'vimscript',
      \ ]

command! AltnvimCheckHealth call altnvim#CheckHealth()

runtime localinit.vim

for ext_name in g:altnvim_extensions
    execute 'runtime extension/' . ext_name . '.vim'
endfor

call altnvim#Load()
