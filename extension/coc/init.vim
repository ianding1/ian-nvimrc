function! s:HasCocDependencies() abort
    call system('node --version')
    let has_node = !v:shell_error
    call system('yarn --version')
    let has_yarn = !v:shell_error
    return has_node && has_yarn
endfunction


let g:has_coc_dependencies = s:HasCocDependencies()
