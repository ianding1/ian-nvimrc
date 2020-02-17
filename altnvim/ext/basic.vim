" vim: sw=2 sts=2

function! s:Init() abort
  " Use space globally instead of tab.
  set expandtab

  " Set indentation to 2 spaces by default.
  set shiftwidth=2
  set softtabstop=2

  " Show a visual line under the cursor's line.
  set cursorline

  " Complete Vim commands.
  set wildmenu
  set wildmode=longest,list,full

  " Enable case-insensitive incremental search and highlighting.
  set ignorecase
  set smartcase
  set incsearch

  " Make backspace full functional.
  set backspace=2

  " Use true colors in the terminal.
  set termguicolors

  " No backup, no swapfile, both because we have undotree and the backup
  " mechanism has conflicts with some language servers.
  set nobackup
  set nowritebackup
  set noswapfile

  " Find tags file recursively up the directory.
  set tags=./.tags;,.tags

  " Set the leader key to the space key.
  let g:mapleader=' '

  " Set the local leader key to the backslash key.
  let g:maplocalleader='\'

  " Enable mouse in the terminal. This requires the terminal to support mouse.
  set mouse=a

  " Do not show mode in the echo area.
  set noshowmode

  " Show the line number.
  set number

  " Persist the undo information in the file system.
  if has('persistent_undo')
      silent call system('mkdir -p ~/.cache/vim-undo')
      set undodir=~/.cache/vim-undo
      set undofile
  endif

  " Split the diff window vertically.
  set diffopt+=vertical

  " Set the text width to 80 and highlight column 81.
  set textwidth=80
  set colorcolumn=81

  " Don't wrap lines.
  set nowrap

  " Hide the buffer when switching to another buffer.
  set hidden

  " Preview the substitution.
  if has('nvim')
      set inccommand=nosplit
  endif

  " Use the system clipboard as the default clipboard.
  set clipboard=unnamed

  " Split the window below or on the right.
  set splitbelow
  set splitright

  " Switch between windows with Ctrl-hjkl
  nnoremap <silent> <c-h> <c-w>h
  nnoremap <silent> <c-j> <c-w>j
  nnoremap <silent> <c-k> <c-w>k
  nnoremap <silent> <c-l> <c-w>l

  " Use Emacs-like key mapping in Command mode.
  cmap <c-a> <Home>
  cmap <c-e> <End>
  cmap <c-f> <Right>
  cmap <c-b> <Left>
  cmap <c-n> <Down>
  cmap <c-p> <Up>
endfunction

function! s:Plugin() abort
  Plug 'vim-airline/vim-airline'
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'milkypostman/vim-togglelist'
  Plug 'Raimondi/delimitMate'
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdcommenter'
  Plug 'mbbill/undotree'
  Plug 'Yggdroot/LeaderF'
  Plug 'wincent/ferret'
endfunction

function! s:Settings() abort
  " Use unicode characters in airline.
  let g:airline_powerline_fonts = 1

  " Disable word count in airline.
  let g:airline#extensions#wordcount#enabled = 0

  " Toggle NERDTree.
  nnoremap <silent> <leader>1 :NERDTreeToggle<cr>

  " Ignore these files in NERDTree.
  let g:NERDTreeIgnore = ['\~$']

  " The default width (31) is too narrow. Set it to 40.
  let g:NERDTreeWinSize = 40

  " Toggle the quickfix and location window.
  let g:toggle_list_no_mappings = 1
  nnoremap <silent> <leader>2 :call ToggleQuickfixList()<cr>
  nnoremap <silent> <leader>3 :call ToggleLocationList()<cr>

  " Toggle the undotree.
  function! <SID>ToggleUndoTree()
      UndotreeToggle
      UndotreeFocus
  endfunction
  nnoremap <silent> <leader>u :call <SID>ToggleUndoTree()<cr>

  " Expand "(|)" to "( | )" when typing a space.
  let g:delimitMate_expand_space = 1

  " Expand "(|)" to "(\n|\n)" when typing a "\n".
  let g:delimitMate_expand_cr = 1

  " Find the first ancestor directory that contains these directories and/or
  " files as the Leaderf root.
  let g:Lf_RootMarkers = ['.git', '.svn', '.hg', '.root', '.project']
  let g:Lf_WorkingDirectoryMode = 'Ac'

  " Filter out these directories and files in Leaderf.
  let g:Lf_WildIgnore = {
              \ 'dir': ['.svn', '.git', '.hg'],
              \ 'file': ['*.sw?', '~$*', '*.bak']
              \ }

  " Map Leaderf commands.
  nnoremap <silent> <leader>f :LeaderfFile<cr>
  nnoremap <silent> <leader>b :LeaderfBuffer<cr>

  " Remove trailing spaces.
  function! <SID>TrimSpaces() abort
    let save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(save)
  endfunction
  command! TrimSpaces call <SID>TrimSpaces()

  " Don't map Ferret commands.
  let g:FerretMap = 0

  if has('gui_running')
    " Remove scrollbars and toolbars in GUI.
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    set guioptions-=T
    set guioptions-=b
  endif

  " Add health check command.
  command! AltnvimCheckHealth call altnvim#CheckHealth()
endfunction

call altnvim#Use({
      \ 'name': 'basic',
      \ 'init': function('s:Init'),
      \ 'plugin': function('s:Plugin'),
      \ 'settings': function('s:Settings')
      \ })
