" vim: sts=2 sw=2

let s:has_ocaml_ls = executable('ocaml-language-server')

function! s:Settings() abort
  call extend(g:NERDTreeIgnore, ['\.cm[oix]$'])
endfunction

function! s:CheckHealth() abort
  call append(line('$'), '- ocaml')
  if s:has_ocaml_ls && g:altnvim_use_coc
    call append(line('$'), '  - OK')
  endif
  if !g:altnvim_has_coc
    call append(line('$'), '  - ERROR: coc is not enabled')
  endif
  if !s:has_ocaml_ls
    call append(line('$'),
          \ '  - ERROR: cannot find ocaml-language-server in PATH')
  endif
endfunction

if s:has_ocaml_ls
  let s:coc_config = 
        \ {
        \ "languageserver": {
        \ "ocaml": {
        \    "command": "ocaml-language-server",
        \    "args": [
        \        "--stdio"
        \    ],
        \    "filetypes": [
        \        "ocaml",
        \        "reason"
        \    ]
        \ }
        \ }
        \ }
else
  let s:coc_config = {}
endif

call altnvim#Use({
      \ 'name': 'ocaml',
      \ 'settings': function('s:Settings'),
      \ 'coc_config': s:coc_config,
      \ 'check_health': function('s:CheckHealth')
      \ })
