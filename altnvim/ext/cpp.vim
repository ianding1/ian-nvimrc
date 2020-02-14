" vim: sw=2 sts=2

let s:has_ccls = executable('ccls')

function! s:Plugin() abort
  Plug 'bfrg/vim-cpp-modern'
endfunction

function! s:Settings() abort
  augroup altnvim_cpp
    autocmd!
    autocmd BufNewFile,BufReadPre *.c,*.cpp setlocal sw=2 sts=2
  augroup END

  call extend(g:Lf_WildIgnore['file'], ['*.[od]'])
  call extend(g:NERDTreeIgnore, ['\.[od]$'])
endfunction

function! s:CheckHealth() abort
  call append(line('$'), '- cpp')
  if s:has_ccls && g:altnvim_use_coc
    call append(line('$'), '  - OK')
  endif
  if !g:altnvim_has_coc
    call append(line('$'), '  - ERROR: coc is not enabled')
  endif
  if !s:has_ccls
    call append(line('$'), '  - ERROR: cannot find ccls in PATH')
  endif
endfunction

if s:has_ccls
  " TODO: Find the system header instead of hardcoding it
  let s:coc_config = {
        \ "languageserver": {
        \ "ccls": {
        \     "command": "ccls",
        \     "filetypes": [
        \         "c",
        \         "cpp",
        \         "objc",
        \         "objcpp"
        \     ],
        \    "rootPatterns": [
        \       ".ccls",
        \       "compile_commands.json",
        \       ".vim/",
        \       ".git/",
        \       ".hg/"
        \   ],
        \   "initializationOptions": {
        \       "cache": {
        \           "directory": "/tmp/ccls"
        \       },
        \       "clang": {
        \           "extraArgs": [
        \               "-isystem",
        \               "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include"
        \           ]
        \       }
        \   }
        \ }
        \ }
        \ }
else
  let s:coc_config = {}
endif

call altnvim#Use({
      \ 'name': 'cpp',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings'),
      \ 'coc_config': s:coc_config,
      \ 'check_health': function('s:CheckHealth')
      \ })
