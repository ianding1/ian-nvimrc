call add(g:coc_global_extensions, 'coc-vimtex')

" Indentation causes vim to be very slow when there are many parentheses and
" braces in a formula.
let g:vimtex_indent_enabled = 0

autocmd BufRead,BufNewFile *.tex setlocal tw=80 sts=2 sw=2
