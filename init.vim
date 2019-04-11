" vim: set foldmethod=marker nofoldenable

set nocompatible

if filereadable(expand('~/.config/nvim/before.local.vim'))
    execute 'source '.expand('~/.config/nvim/before.local.vim')
endif

" Auxiliary functions and variables {{{
    function! s:IsUniversalCtags()
        let ver=system("ctags --version")
        return match(ver, "universal") != -1
    endfunction
    let s:project_root = ['.git', '.root', '.svn', '.hg', '.project']
" }}}
" Basic settings {{{
    " Trailing whitespace remover {{{
        function! <SID>tdvimrc_strip_spaces()
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            call cursor(l, c)
        endfunction
    " }}}
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
    " Do not wrap lines.
    set nowrap
    " Show the line number.
    set number
    " Persist the undo information in the file system.
    if has('persistent_undo')
        silent call system('mkdir -p ~/.cache/vim-undo')
        set undodir=~/.vim-undo
        set undofile
    endif
    " Split the diff window vertically.
    set diffopt+=vertical
    " Set the line width to be 80.
    set textwidth=80
    " Show a column bar at line 81.
    set colorcolumn=81
    " Set the buffer to hidden when switching out
    set hidden
" }}}
" Plugins {{{
    " Prologue {{{
    call plug#begin('~/.local/share/nvim/plugged')
    " }}}
    " UI Enhancement {{{
    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " }}}
    " Command Enhancement {{{
    Plug 'Yggdroot/LeaderF'
    Plug 'milkypostman/vim-togglelist'
    Plug 'wincent/ferret'
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-unimpaired'
    Plug 'skywind3000/vim-preview'
    Plug 'scrooloose/nerdcommenter'
    Plug 'Raimondi/delimitMate'
    Plug 'easymotion/vim-easymotion'
    Plug 'wellle/targets.vim'
    " }}}
    " Linting {{{
    Plug 'w0rp/ale'
    " }}}
    " Version Control {{{
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    " }}}
    " Tagging {{{
    Plug 'ludovicchabant/vim-gutentags'
    " }}}
    " Auto Completion {{{
    Plug 'Shougo/echodoc.vim'
    Plug 'Valloric/YouCompleteMe'
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
    " }}}
    " Auto Format {{{
    Plug 'Chiel92/vim-autoformat'
    " }}}
    " Snippets {{{
    Plug 'SirVer/ultisnips'
    " }}}
    " C/C++ {{{
    Plug 'bfrg/vim-cpp-modern'
    " }}}
    " Markdown {{{
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-markdown'
    " }}}
    " Latex {{{
    Plug 'LaTeX-Box-Team/LaTeX-Box'
    " }}}
    " Epilogue {{{
    if filereadable(expand('~/.config/nvim/plugin.local.vim'))
        execute 'source '.expand('~/.config/nvim/plugin.local.vim')
    endif
    call plug#end()
    " }}}
" }}}
" Plugin Configurations {{{
    " UI Enhancement {{{
        " Use the dark theme of gruvbox.
        set background=dark
        let v:errmsg = ''
        silent! colorscheme onedark
        if v:errmsg == ''
            " Set airline theme to onedark.
            let g:airline_theme = 'onedark'
        endif
        " Don't use powerline symbols.
        let g:airline_powerline_fonts = 0
    " }}}
    " Command Enhancement {{{
        " Bind the toggling commands under <leader>t
        let g:toggle_list_no_mappings = 1
        nnoremap <silent> <leader>2 :call ToggleQuickfixList()<cr>
        nnoremap <silent> <leader>3 :call ToggleLocationList()<cr>

        " Command to toggle the undotree.
        function! <SID>tdvimrc_undotree_focus()
            UndotreeToggle
            UndotreeFocus
        endfunction

        noremap <silent> <leader>u :call <SID>tdvimrc_undotree_focus()<cr>

        " Do not use unicode separators in LeaderF status line.
        let g:Lf_StlSeparator = { 'left': '', 'right': '' }
        " Use the first ancestor directory that contains these directories and
        " files as the searching root.
        let g:Lf_RootMarkers = s:project_root
        let g:Lf_WorkingDirectoryMode = 'Ac'

        " Filter out these directories and files in LeaderF.
        let g:Lf_WildIgnore = {
            \ 'dir': ['.svn', '.git', '.hg'],
            \ 'file': ['*.sw?', '~$*', '*.bak']
            \}

        " Map leaderf commands.
        nnoremap <silent> <leader>f :LeaderfFile<cr>
        nnoremap <silent> <leader>b :LeaderfBuffer<cr>
        nnoremap <silent> <leader>j :LeaderfTag<cr>

        " Don't bind ferret commands.
        let g:FerretMap = 0

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

        " Toggle NERDTree
        nnoremap <silent> <leader>1 :NERDTreeToggle<cr>

        " Ignore these files in NERDTree
        let g:NERDTreeIgnore = ['\~$']

        " Autoformat command
        nnoremap <silent> <leader>q :Autoformat<cr>

        " Expand CR between parentheses
        let g:delimitMate_expand_cr = 1
    " }}}
    " Linting {{{
    " }}}
    " Version Control {{{
        " Bind fugitive key mappings.
        nnoremap <leader>gs :Gstatus<cr>
        nnoremap <leader>gw :Gwrite<cr>
        nnoremap <leader>gd :Gdiff<cr>
        nnoremap <leader>gc :Gcommit --verbose<cr>
    " }}}
    " Tagging {{{
        " The directories containing the following files/directories are
        " considered as the root directory of the project being tagged.
        let g:gutentags_project_root = s:project_root
        " The tags file name to generate.
        let g:gutentags_ctags_tagfile = '.tags'
        " Save all the tag files to ~/.cache/tags in order not to pollute the
        " project directory.
        let s:vim_tags = expand('~/.cache/tags')
        let g:gutentags_cache_dir = s:vim_tags
        " Enable ctags if exists.
        let g:gutentags_modules = []
        if executable('ctags') && s:IsUniversalCtags()
            let g:gutentags_modules += ['ctags']
        endif
        " Detect and create ~/.cache/tags directory.
        if !isdirectory(s:vim_tags)
            silent! call mkdir(s:vim_tags, 'p')
        endif
        " The options passed to ctags program (we use universal ctags instead).
        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
    " }}}
    " Auto Completion {{{
        " Do not auto show the function signature in preview.
        set completeopt-=preview
        " Enable echodoc at startup.
        let g:echodoc#enable_at_startup = 1
        " Don't give ins-completion-menu messages.
        set shortmess+=c
        " Use Python3 as the interpreter
        let g:ycm_python_binary_path = '/usr/local/bin/python3'
        " Disable YCM from autocompletion (don't affect syntactic completion)
        let g:ycm_min_num_of_chars_for_completion = 99
        " Enable echodoc
        let g:echodoc#enable_at_startup = 1
    " }}}
    " Snippets {{{
        " Set the private snippet directory to ~/.config/nvim/UltiSnips
        let g:UltiSnipsSnippetsDir = expand('~/.config/nvim/UltiSnips')
        " Search the snippets only in our private UltiSnips.
        let g:UltiSnipsSnippetDirectories = [expand('~/.config/nvim/UltiSnips')]
        " Show the snippet window vertically.
        let g:UltiSnipsEditSplit = "vertical"

        " Trigger commands.
        let g:UltiSnipsExpandTrigger = '<c-j>'
        let g:UltiSnipsJumpForwardTrigger = '<c-j>'
        let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
    " }}}
    " OCaml {{{
        let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
        if g:opamshare != ''
            execute "set rtp+=" . g:opamshare . "/merlin/vim"
        endif
    " }}}
" }}}
"
if filereadable(expand('~/.config/nvim/after.local.vim'))
    execute 'source '.expand('~/.config/nvim/after.local.vim')
endif
