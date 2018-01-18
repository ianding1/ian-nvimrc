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
    function! <SID>tdvimrc_strip_spaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfunction
    " Remove trailing whitespaces on buffer save.
    function! <SID>tdvimrc_strip_spaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfunction
    autocmd BufWritePre * :call <SID>tdvimrc_strip_spaces()
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

    " File keys starting with <leader>f {{{
        " Search for the files recursively in the current directory.
        nnoremap <leader>ff :Files<cr>
        " Search for the files in the git repository.
        nnoremap <leader>fp :GFiles<cr>
        " Save the current file.
        nnoremap <leader>fs :w<cr>
    " }}}

    " Buffer keys: <leader>b {{{
        " Switch buffers.
        nnoremap <leader>bb :Buffers<cr>
        " Switch to the next buffer.
        nnoremap <leader>bn :bn<cr>
        " Switch to the previous buffer.
        nnoremap <leader>bp :bp<cr>
        " Kill the current buffer.
        nnoremap <leader>bd :q<cr>
    " }}}

    " Window keys: <leader>w {{{
        " Switching between windows.
        nnoremap <leader>ww <c-w><c-w>
        " Move to the window below.
        nnoremap <leader>wj <c-w><c-j>
        " Move to the window above.
        nnoremap <leader>wk <c-w><c-k>
        " Move to the window left.
        nnoremap <leader>wh <c-w><c-h>
        " Move to the window right.
        nnoremap <leader>wl <c-w><c-l>
        " Maximize the current window.
        nnoremap <leader>wm :only<cr>
        " Delete the current window.
        nnoremap <leader>wd :hide<cr>
        " Split the window vertically.
        nnoremap <leader>wv :vs<cr>
        " Split the window horizontally.
        nnoremap <leader>ws :split<cr>
    " }}}

    " Quickfix keys: <leader>e {{{
        " Toggle the quickfix window.
        nnoremap <leader>el :cw<cr>
        " Go to the next error.
        nnoremap <leader>en :cn<cr>
        " Go to the previous error.
        nnoremap <leader>ep :cp<cr>
    " }}}

    " Undotree: <leader>u {{{
        " Command to toggle the undotree.
        function! <SID>tdvimrc_undotree_focus()
            UndotreeToggle
            UndotreeFocus
        endfunction
        nnoremap <leader>u :call <SID>tdvimrc_undotree_focus()<CR>
    " }}}

    " Git keys: <leader>g {{{
        nnoremap <leader>gs :Gstatus<cr>
        nnoremap <leader>gc :Gcommit -v<cr>
        nnoremap <leader>gw :Gwrite<cr>
        nnoremap <leader>gd :Gdiff<cr>
        nnoremap <leader>gb :Gblame<cr>
    " }}}
" }}}

" Neomake {{{
    " Run neomake automatically when writing a buffer and on normal mode
    " changes after 1s.
    call neomake#configure#automake('nw', 1000)
" }}}

" Airline {{{
    let g:airline_theme='sol'
" }}}

" Undotree {{{
    " Persist the undo information in the file system.
    if has('persistent_undo')
        silent call system('mkdir -p ~/.vim-undo')
        set undodir=~/.vim-undo
        set undofile
    endif
" }}}

" The custom configurations that will be evaluated at last should be placed
" in the file "~/.config/nvim/epilogue.vim".
if filereadable(glob('~/.config/nvim/epilogue.vim'))
    source '~/.config/nvim/epilogue.vim'
endif
