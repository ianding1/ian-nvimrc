" vim: sw=2 sts=2

let s:enabled_extensions = []


function! altnvim#EnableExtensions(extensions) abort
  call extend(s:enabled_extensions, a:extensions)
endfunction


function! altnvim#LoadExtensions() abort

  for extension in s:enabled_extensions
    execute 'runtime extension/' . extension . '.init.vim'
  endfor

  call plug#begin('~/.local/share/nvim/plugged')

  for extension in s:enabled_extensions
    execute 'runtime extension/' . extension . '.plug.vim'
  endfor

  call plug#end()

  for extension in s:enabled_extensions
    execute 'runtime extension/' . extension . '.settings.vim'
  endfor
endfunction


function! altnvim#IsExtensionEnabled(extension) abort
  return index(s:enabled_extensions, a:extension) != -1
endfunction


function! altnvim#DisableExtensions(extensions) abort
  let extensions_to_be_removed = {}

  for extension in a:extensions
    let extensions_to_be_removed[extension] = 1
  endfor

  let new_enabled_extensions = []

  for extension in s:enabled_extensions
    if !has_key(extensions_to_be_removed, extension)
      call add(new_enabled_extensions, extension)
    endif
  endfor

  let s:enabled_extensions = new_enabled_extensions
endfunction


function! altnvim#LoadCocSettings(extension_path_prefix) abort
  let coc_settings_path = a:extension_path_prefix . '.coc-settings.json'
  let coc_settings = json_decode(join(readfile(coc_settings_path), "\n"))

  for key in keys(coc_settings)
    if key ==# 'languageserver'
      for ls in keys(coc_settings[key])
        let g:coc_user_config[key][ls] = coc_settings[key][ls]
      endfor
    else
      let g:coc_user_config[key] = coc_settings[key]
    endif
  endfor
endfunction
