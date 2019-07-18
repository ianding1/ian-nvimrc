if altnvim#IsExtensionEnabled('leaderf')
  call extend(g:Lf_WildIgnore['file'], ['*.py[co]'])
endif

if altnvim#IsExtensionEnabled('nerdtree')
  call extend(g:NERDTreeIgnore, ['\.py[oc]$'])
endif

call add(g:coc_global_extensions, 'coc-python')
