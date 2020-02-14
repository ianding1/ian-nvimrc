" vim: sts=2 sw=2

let s:coc_config =
      \ {
      \ "latex.build.onSave": true
      \ }

call altnvim#Use({
      \ 'name': 'tex',
      \ 'coc_config': s:coc_config,
      \ 'coc_extensions': ['coc-texlab']
      \ })
