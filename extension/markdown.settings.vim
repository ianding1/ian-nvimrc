" The default mapping uses space, which conflicts with our leader key.
" Just disable it for now.
let g:markdown_enable_mappings = 0

autocmd BufReadPost *.md setlocal tw=80 nospell
