" vim: sw=2 sts=2

let s:enabled_extensions = []


function! altnvim#EnableExtensions(extensions) abort
  let extension_map = {}
  for extension in s:enabled_extensions
    let extension_map[extension] = 1
  endfor

  for extension in a:extensions
    if !has_key(extension_map, extension)
      let extension_map[extension] = 1
      call add(s:enabled_extensions, extension)
    endif
  endfor
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


let s:used_exts = []

function! altnvim#Use(ext) abort
  " Check if the extension is valid.
  if !has_key(a:ext, 'name')
    throw 'Missing extension name'
  endif

  for ext_key in keys(a:ext)
    if index(['name', 'init', 'settings', 'plugins', 'coc_config',
          \ 'check_health', 'coc_extensions'], ext_key) == -1
      throw 'Invalid extension key:' . ext_key
    endif
  endfor

  " Return immediately if the extension is already used.
  for used_ext in s:used_exts
    if a:ext['name'] ==# used_ext['name']
      return
    endif
  endfor

  call add(s:used_exts, ext)
endfunction

let s:loaded = 0
let g:altnvim_has_coc = 0

function! altnvim#Load() abort
  " Return immediately if already loaded.
  if s:loaded
    return
  endif
  let s:loaded = 1

  " Execute the initialization functions.
  for ext in s:used_exts
    if has_key(ext, 'init')
      call ext['init']()
    endif
  endfor

  " Register the plugins.
  call plug#begin('~/.local/share/nvim/plugged')
  for ext in s:used_exts
    if has_key(ext, 'plugin')
      call ext['plugin']()
    endif
  endfor
  call plug#end()

  " Execute the setting functions.
  for ext in s:used_exts
    if has_key(ext, 'settings')
      call ext['settings']()
    endif
  endfor

  " Set up the coc.nvim configuration.
  if g:altnvim_has_coc
    let g:coc_user_config = {'languageserver': {}}
    let g:coc_global_extensions = []

    for ext in s:used_exts
      if has_key(ext, 'coc_extensions')
        call extend(g:coc_global_extensions, ext['coc_extensions'])
      endif

      if has_key(ext, 'coc_config')
        let coc_config = ext['coc_config']
        for key in keys(coc_config)
          if key ==# 'languageserver'
            call extend(g:coc_user_config['languageserver'],
                  \ coc_config['languageserver'])
          else
            let g:coc_user_config[key] = coc_config[key]
          endif
        endfor
      endif
    endfor
  endif
endfunction

function! altnvim#CheckHealth() abort
  tabnew
  setlocal buftype=nofile
  setlocal filetype=markdown
  call append(line('0'), '# check health')
  call append(line('$'), ['## enabled extensions', ''])
  for ext in s:used_exts
    call append(line('$'), '- ' . ext['name'])
  endfor

  call append(line('$'), ['', '## extension availability', ''])
  for ext in s:used_exts
    if has_key(ext, 'check_health')
      call ext['check_health']()
    endif
  endfor
endfunction
