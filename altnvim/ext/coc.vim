" vim: sw=2 sts=2

" Check if the dependencies of coc.nvim are installed.
call system('node --version')
let s:has_node = !v:shell_error
if s:has_node
  let g:altnvim_has_coc = 1
endif

function! s:Plugin() abort
  if !s:has_node
    return
  endif
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endfunction

function! s:Settings() abort
  " Better experience for diagnostic messages.
  set updatetime=300

  " Always show sign column.
  set signcolumn=yes

  " Don't give ins-completion-menu messages.
  set shortmess+=c

  if !s:has_node
    return
  endif

  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped
  " by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position.  Coc only does snippet and additional edit on confirm. Must use
  " imap instead of inoremap to map <Plug>delimitMateCR to the correct command.
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<Plug>delimitMateCR"

  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K for show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if index(['vim','help'], &filetype) >= 0
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  augroup cocsettings
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json
          \ setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder
          \ call CocActionAsync('showSignatureHelp')
  augroup end

  " Fix autofix problem of current line
  nmap <m-cr>  <Plug>(coc-fix-current)

  " Use <tab> for select selections ranges, needs server support, like:
  " coc-tsserver, coc-python
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

  " Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` for fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR
        \ :call CocAction('runCommand', 'editor.action.organizeImport')

  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)

  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)

  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'

  " Use <C-k> for jump to previous placeholder, it's default of
  " coc.nvim
  let g:coc_snippet_prev = '<c-k>'

  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)
endfunction

function! s:CheckHealth() abort
  call append(line('$'), '- coc')
  if s:has_node
    call append(line('$'), '  - OK')
  else
    call append(line('$'), '  - ERROR: cannot find node in PATH')
  endif
endfunction

call altnvim#Use({
      \ 'name': 'coc',
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings'),
      \ 'check_health': function('s:CheckHealth'),
      \ 'coc_extensions': ['coc-json', 'coc-snippets']
      \ })
