" vim: sw=2 sts=2

let s:enabled_extensions = []


function! altnvim#EnableExtensions(extensions) abort
  call extend(s:enabled_extensions, a:extensions)
endfunction


function! altnvim#LoadExtensions() abort

  for extension in s:enabled_extensions
    execute 'runtime extension/' . extension . '/init.vim'
  endfor

  call plug#begin('~/.local/share/nvim/plugged')

  for extension in s:enabled_extensions
    execute 'runtime extension/' . extension . '/plug.vim'
  endfor

  call plug#end()

  for extension in s:enabled_extensions
    execute 'runtime extension/' . extension . '/settings.vim'
  endfor
endfunction


function! altnvim#IsExtensionEnabled(extension) abort
  return index(s:enabled_extensions, a:extension) != -1
endfunction


function! altnvim#DeepExtend(target, source) abort
  if type(a:target) == v:t_list && type(a:source) == v:t_list
    call extend(a:target, a:source)
  elseif type(a:target) == v:t_dict && type(a:source) == v:t_dict
    for key in keys(a:source)
      if has_key(a:target, key)
        if index([v:t_list, v:t_dict], type(a:target[key])) != -1
          call s:DeepExtend(a:target[key], a:source[key])
        else
          let a:target[key] = a:source[key]
        endif
      else
        let a:target[key] = a:source[key]
      endif
    endfor
  else
    throw 'Unsupported types'
  endif
endfunction


function! altnvim#LoadCocSettings(extension_dir) abort
  let coc_settings_path = a:extension_dir . '/coc-settings.json'
  let coc_settings = json_decode(readfile(coc_settings_path, 'b'))

  for key in keys(coc_settings)
    call coc#config(key, coc_settings[key])
  endfor
endfunction
