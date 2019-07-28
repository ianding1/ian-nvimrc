" vim: sw=2 sts=2

" Use English and the language of the editor.
let $LANG='en'
set langmenu=en
set encoding=utf-8

" Use UTF-8 and GBK, sequentially, as the encodings of files.
set fileencodings=utf-8,gbk

" Use space instead of tab.
set expandtab

" Set indentation to 4 spaces by default.
set shiftwidth=4
set softtabstop=4

" Show a visual line under the cursor's line.
set cursorline

" Complete in command.
set wildmenu
set wildmode=longest,list,full

" Enable case-insensitive incremental search and lighlight.
set ignorecase
set smartcase
set incsearch

" Make backspace full functional.
set backspace=2

" Use true colors.
set termguicolors

" No backup, no swapfile, because we have undotree.
set nobackup
set nowritebackup
set noswapfile
set nowritebackup

" Find tags file recursively up the directory.
set tags=./.tags;,.tags

" Set the leader key to space.
let mapleader=' '

" Set the local leader key to backslash.
let maplocalleader='\'

" Enable mouse in terminal mode.
set mouse=a

" Do not show mode in the last line.
set noshowmode

" Wrap lines.
set wrap

" Break at word boundary if allowing wrapping lines
set linebreak

" Preserve line indentation on line break
set breakindent

" Show > at the beginning of the continuation
let &showbreak='> '

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

" Show a column bar at line 81.
set colorcolumn=81

" Set the buffer to hidden when switching out
set hidden

" Show the substitution result when typing the substitution command.
if has('nvim')
    set inccommand=nosplit
endif

" Use the system clipboard as the default clipboard
set clipboard=unnamed

" Split the window below or in the right, which is more natural than default.
set splitbelow
set splitright

" Moving between windows with Ctrl+hjkl
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l
