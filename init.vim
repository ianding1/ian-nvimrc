" vim:foldmethod=marker

set nocompatible

" The custom configurations that will be evaluated at the very beginning
" should be placed in the file "~/.config/nvim/prologue.vim".
if filereadable(glob('~/.config/nvim/prologue.vim'))
    source '~/.config/nvim/prologue.vim'
endif

" Language and encodings {{{
    " Use English and the language of the editor.
    let $LANG='en'
    set langmenu=en
    set encoding=utf-8
    " Use UTF-8 and GBK, sequentially, as the encodings of files.
    set fileencodings=utf-8,gbk
" }}}

" Edit preferences {{{
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
    " Use the light theme.
    set background=light
    " Enable case-insensitive incremental search and lighlight.
    set ignorecase
    set smartcase
    set incsearch
    set hlsearch
    " Make backspace full functional.
    set backspace=2
    " Use true colors.
    set termguicolors
    " No backup, no swapfile, because we have undotree.
    set nobackup
    set noswapfile
" }}}

" Packages {{{
    " Specify the plugin directory.
    call plug#begin('~/.local/share/nvim/plugged')

    " Undotree permits rolling back to any previous editing states in an
    " editing history tree.
    Plug 'mbbill/undotree'

    " FZF allows super fast fuzzy matching for opening files, switching buffer
    " and so on.
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Neomake is an asynchronous universal syntax checker.
    Plug 'neomake/neomake'

    " Airline makes the state line more beautiful.
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Fugitive is the best git integration.
    Plug 'tpope/vim-fugitive'

    " GitGutter shows signs along the lines to indicate the lines being added,
    " removed and changed.
    Plug 'airblade/vim-gitgutter'

    " The custom plugins should be defined in the file
    " "~/.config/nvim/plugins.vim"
    if filereadable(glob('~/.config/nvim/plugins.vim'))
        source '~/.config/nvim/plugins.vim'
    endif

    " Initialize the plugin system.
    call plug#end()
" }}}

" Keybindings {{{
    " All the keybindings start with a whitespace, which is profoundly
    " influenced by the extraordinary Spacemacs.
    let mapleader=' '
" }}}

" Neomake {{{
    " Run neomake automatically when writing a buffer and on normal mode
    " changes after 1s.
    call neomake#configure#automake('nw', 1000)
" }}}

" Airline {{{
    let g:airline_theme='sol'
" }}}

" The custom configurations that will be evaluated at last should be placed
" in the file "~/.config/nvim/epilogue.vim".
if filereadable(glob('~/.config/nvim/epilogue.vim'))
    source '~/.config/nvim/epilogue.vim'
endif
