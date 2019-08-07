" Use powerline symbols.
" Install DejaVu Sans Mono for Powerline first.
" https://github.com/powerline/fonts/tree/master/DejaVuSansMono
let g:airline_powerline_fonts = 1

" Toggle NERDTree
nnoremap <silent> <leader>1 :NERDTreeToggle<cr>

" Ignore these files in NERDTree
let g:NERDTreeIgnore = ['\~$']

" Default with of 31 is too narrow in practice.
let g:NERDTreeWinSize = 40

" Bind the toggling commands under <leader>t
let g:toggle_list_no_mappings = 1
nnoremap <silent> <leader>2 :call ToggleQuickfixList()<cr>
nnoremap <silent> <leader>3 :call ToggleLocationList()<cr>

" Command to toggle the undotree.
function! <SID>tdvimrc_undotree_focus()
    UndotreeToggle
    UndotreeFocus
endfunction

nnoremap <silent> <leader>u :call <SID>tdvimrc_undotree_focus()<cr>

" Don't bind ferret commands.
let g:FerretMap = 0

" Don't mess up quickfix settings.
let g:FerretQFOptions = 0

" Bind Ferret commands.
nmap <leader>/ <Plug>(FerretAck)
nmap <leader>* <Plug>(FerretAckWord)

" Allow to scroll the preview window without leaving the current
" window.
noremap <silent> <m-]> :PreviewTag<cr>
noremap <silent> <m-u> :PreviewScroll -1<cr>
noremap <silent> <m-d> :PreviewScroll +1<cr>
inoremap <silent> <m-u> <c-\><c-o>:PreviewScroll -1<cr>
inoremap <silent> <m-d> <c-\><c-o>:PreviewScroll +1<cr>

" Allow to browse the quickfix items in preview.
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

" Expand space and returns between parentheses.
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1

" Use the first ancestor directory that contains these directories and
" files as the searching root.
let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.root', '.project']
let g:Lf_WorkingDirectoryMode = 'Ac'

" Filter out these directories and files in LeaderF.
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn', '.git', '.hg'],
            \ 'file': ['*.sw?', '~$*', '*.bak']
            \ }

" Map leaderf commands.
nnoremap <silent> <leader>f :LeaderfFile<cr>
nnoremap <silent> <leader>b :LeaderfBuffer<cr>
nnoremap <silent> <leader>] :LeaderfTag<cr>
