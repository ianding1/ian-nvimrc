" vim: set foldmethod=marker nofoldenable

set nocompatible

if filereadable(expand('~/.config/nvim/before.local.vim'))
    execute 'source '.expand('~/.config/nvim/before.local.vim')
endif

" Basic settings {{{
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
    " Do not wrap lines.
    set nowrap
    " Break at word boundary if allowing wrapping lines
    set linebreak
    " Preserve line indentation on line break
    set breakindent
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
    " Show the substitution result when typing the substitution command
    if has('nvim')
        set inccommand=nosplit
    endif
    " The project root for LeaderF and gutentags
    let s:project_root = ['.git', '.root', '.svn', '.hg', '.project']
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
    " Language Server {
    function! s:has_coc_deps()
        call system('node --version')
        let has_node = !v:shell_error
        call system('yarn --version')
        let has_yarn = !v:shell_error
        return has_node && has_yarn
    endfunction

    if <SID>has_coc_deps()
        Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
    endif
    " }}}
    " Version Control {{{
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    " }}}
    " Tagging {{{
    Plug 'ludovicchabant/vim-gutentags'
    " }}}
    " C/C++ {{{
    Plug 'bfrg/vim-cpp-modern'
    " }}}
    " Markdown {{{
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-markdown'
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
        nnoremap <silent> <leader>] :LeaderfTag<cr>

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

        " Expand CR between parentheses
        let g:delimitMate_expand_cr = 1

        " Airline integration
        let g:airline_section_error = 
            \ '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
        let g:airline_section_warning = 
            \ '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
    " }}}
    " Language Server {{{
        if <SID>has_coc_deps()
            " Don't give ins-completion-menu messages.
            set shortmess+=c

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

            " Use <cr> for confirm completion, `<C-g>u` means break undo chain
            " at current position.  Coc only does snippet and additional edit on
            " confirm.
            inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
                if &filetype == 'vim'
                    execute 'h '.expand('<cword>')
                else
                    call CocAction('doHover')
                endif
            endfunction

            " Highlight symbol under cursor on CursorHold
            autocmd CursorHold * silent call CocActionAsync('highlight')

            " Remap for rename current word
            nmap <leader>r <Plug>(coc-rename)

            " Remap for format selected region
            vmap <leader>q  <Plug>(coc-format-selected)
            nmap <leader>q  <Plug>(coc-format-selected)

            augroup mygroup
                autocmd!
                " Setup formatexpr specified filetype(s).
                autocmd FileType typescript,json 
                            \ setl formatexpr=CocAction('formatSelected')
                " Update signature help on jump placeholder
                autocmd User CocJumpPlaceholder 
                            \ call CocActionAsync('showSignatureHelp')
            augroup end

            " Use `:Format` for format current buffer
            command! -nargs=0 Format :call CocAction('format')

            " Use `:Fold` for fold current buffer
            command! -nargs=? Fold :call CocAction('fold', <f-args>)

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
        endif
    " }}}
    " Version Control {{{
        " Bind fugitive key mappings.
        nnoremap <leader>gs :Gstatus<cr>
        nnoremap <leader>gw :Gwrite<cr>
        nnoremap <leader>gd :Gdiff<cr>
        nnoremap <leader>gc :Gcommit --verbose<cr>
    " }}}
    " Tagging {{{
        function! s:IsUniversalCtags()
            let ver=system("ctags --version")
            return match(ver, "universal") != -1
        endfunction

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
" }}}
"
if filereadable(expand('~/.config/nvim/after.local.vim'))
    execute 'source '.expand('~/.config/nvim/after.local.vim')
endif
