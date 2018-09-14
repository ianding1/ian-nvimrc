" vim:foldmethod=marker

set nocompatible

if filereadable(expand('~/.config/nvim/before.local.vim'))
    execute 'source '.expand('~/.config/nvim/before.local.vim')
endif

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
    " Remove trailing whitespaces on saving buffers.
    autocmd BufWritePre * :call <SID>tdvimrc_strip_spaces()
    " Find tags file recursively up the directory.
    set tags=./.tags;,.tags
    " Set the leader key to space.
    let mapleader=' '
    " Enable mouse in terminal mode.
    set mouse=a
    " Do not show mode in the last line.
    set noshowmode
    " Use <ESC> to exit terminal-mode.
    tnoremap <esc> <c-\><c-n>
    " Do not wrap lines.
    set nowrap
    " Persist the undo information in the file system.
    if has('persistent_undo')
        silent call system('mkdir -p ~/.vim-undo')
        set undodir=~/.vim-undo
        set undofile
    endif
    " Split the diff window vertically.
    set diffopt+=vertical
" }}}
" Plugins {{{
    " Prologue {{{
    call plug#begin('~/.local/share/nvim/plugged')
    " }}}
    " UI Enhancement {{{
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " }}}
    " Command Enhancement {{{
    Plug 'Yggdroot/LeaderF'
    Plug 'milkypostman/vim-togglelist'
    Plug 'mileszs/ack.vim'
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-unimpaired'
    Plug 'skywind3000/vim-preview'
    Plug 'brooth/far.vim'
    Plug 'godlygeek/tabular'
    " }}}
    " Text Objects {{{
    Plug 'kana/vim-textobj-user'
    Plug 'glts/vim-textobj-comment'
    Plug 'kana/vim-textobj-entire'
    Plug 'sgur/vim-textobj-parameter'
    Plug 'beloglazov/vim-textobj-quotes'
    Plug 'michaeljsmith/vim-indent-object'
    " }}}
    " Linting {{{
    Plug 'neomake/neomake'
    " }}}
    " Version Control {{{
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    " }}}
    " Tagging {{{
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'
    " }}}
    " Auto Completion {{{
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "Plug 'zchee/deoplete-jedi'
    Plug 'Shougo/echodoc.vim'
    " }}}
    " Snippets {{{
    Plug 'SirVer/ultisnips', { 'for': ['python', 'vim'] }
    " }}}
    " REPL {{{
    Plug 'BurningEther/iron.nvim'
    " }}}
    " Python {{{
    Plug 'Vimjas/vim-python-pep8-indent'
    " }}}
    " Haskell {{{
    Plug 'neovimhaskell/haskell-vim'
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
        colorscheme gruvbox
        " Don't use powerline symbols.
        let g:airline_powerline_fonts = 0
    " }}}
    " Command Enhancement {{{
        " Bind the toggling commands under <leader>t
        let g:toggle_list_no_mappings = 1
        nnoremap <leader>c :call ToggleQuickfixList()<cr>
        nnoremap <leader>l :call ToggleLocationList()<cr>

        " Command to toggle the undotree.
        function! <SID>tdvimrc_undotree_focus()
            UndotreeToggle
            UndotreeFocus
        endfunction
        nnoremap <leader>u :call <SID>tdvimrc_undotree_focus()<CR>

        " Do not use unicode separators in LeaderF status line.
        let g:Lf_StlSeparator = { 'left': '', 'right': '' }
        " Use the first ancestor directory that contains these directories and
        " files as the searching root.
        let g:Lf_RootMarkers = ['.svn', '.git', '.project']
        let g:Lf_WorkingDirectoryMode = 'Ac'

        " Map leaderf commands.
        nnoremap <leader>f :LeaderfFile<cr>
        nnoremap <leader>b :LeaderfBuffer<cr>
        nnoremap <leader>r :LeaderfMru<cr>
        nnoremap <leader>F :LeaderfFunction!<cr>

        " Use ag in Ack.vim
        if executable('ag')
          let g:ackprg = 'ag --vimgrep'
        endif

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

        " Use ag in far.vim
        let g:far#source = 'ag'
        noremap <silent> <leader>* :Ack!<cr>
    " }}}
    " Linting {{{
        " Automatically make when writing (no delay).
        call neomake#configure#automake('w')
        " Use only pylint as the python makers.
        let g:neomake_python_enabled_makers = ['pylint']
    " }}}
    " Version Control {{{
        " Bind fugitive key mappings.
        nnoremap <leader>gs :Gstatus<cr>
        nnoremap <leader>gw :Gwrite<cr>
        nnoremap <leader>gr :Gread<cr>
        nnoremap <leader>gd :Gdiff<cr>
        nnoremap <leader>gc :Gcommit --verbose<cr>

        " Disable the default key mapping, for it conflicts with
        " vim-textobj-python on ac/ic.
        let g:gitgutter_map_keys = 0

        " Bind gitgutter key mappings and text objects.
        nmap ]h <Plug>GitGutterNextHunk
        nmap [h <Plug>GitGutterPrevHunk

        omap ih <Plug>GitGutterTextObjectInnerPending
        omap ah <Plug>GitGutterTextObjectOuterPending
        xmap ih <Plug>GitGutterTextObjectInnerVisual
        xmap ah <Plug>GitGutterTextObjectOuterVisual

        nmap <leader>hs <Plug>GitGutterStageHunk
        nmap <leader>hu <Plug>GitGutterUndoHunk

        nmap <leader>tg <Plug>GitGutterToggle
        nmap <leader>tG <Plug>GitGutterLineHighlightsToggle
    " }}}
    " Tagging {{{
        " The directories containing the following files/directories are
        " considered as the root directory of the project being tagged.
        let g:gutentags_project_root = ['.git', '.root', '.svn', '.hg', '.project']
        " The tags file name to generate.
        let g:gutentags_ctags_tagfile = '.tags'
        " Save all the tag files to ~/.cache/tags in order not to pollute the
        " project directory.
        let s:vim_tags = expand('~/.cache/tags')
        let g:gutentags_cache_dir = s:vim_tags
        " Enable ctags and gtags-cscope if exists.
        let g:gutentags_modules = []
        if executable('ctags')
            let g:gutentags_modules += ['ctags']
        endif
        if executable('gtags-cscope') && executable('gtags')
            let g:gutentags_modules += ['gtags_cscope']
        endif
        " Let gtags use pygments
        let $GTAGSLABEL = 'native-pygments'
        let $GTAGSCONF = expand('~/.gtags.conf')
        " Detect and create ~/.cache/tags directory.
        if !isdirectory(s:vim_tags)
            silent! call mkdir(s:vim_tags, 'p')
        endif
        " The options passed to ctags program (we use universal ctags instead).
        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
        " Disable gutentags from autoloading gtags database.
        let g:gutentags_auto_add_gtags_cscope = 0
    " }}}
    " Auto Completion {{{
        " Do not auto show the function signature in preview.
        set completeopt-=preview
        " Enable deoplete at startup.
        let g:deoplete#enable_at_startup = 1
        " Use Python3 as the completer.
        let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3'
        " Enable echodoc at startup.
        let g:echodoc#enable_at_startup = 1
        " Use <tab> to select between the candidates (like in YCM).
        inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
        inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
        " Don't give ins-completion-menu messages.
        set shortmess+=c
    " }}}
    " Snippets {{{
        " Set the private snippet directory to ~/.config/nvim/UltiSnips
        let g:UltiSnipsSnippetsDir = expand('~/.config/nvim/UltiSnips')
        " Search the snippets only in our private UltiSnips.
        let g:UltiSnipsSnippetDirectories = [expand('~/.config/nvim/UltiSnips')]
        " Show the snippet window vertically.
        let g:UltiSnipsEditSplit = "vertical"

        " Bind the snippet commands.
        nnoremap <leader>se :UltiSnipsEdit<cr>
        nnoremap <leader>sa :UltiSnipsAddFiletypes<cr>

        " Trigger commands.
        let g:UltiSnipsExpandTrigger = '<c-j>'
        let g:UltiSnipsJumpForwardTrigger = '<c-j>'
        let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
    " }}}
    " REPL {{{
        " Split the window vertically.
        let g:iron_repl_open_cmd = 'vsplit'
    " }}}
    " Coq {{{
        let g:coqide_debug = 1
        let g:coqide_debug_file = 'coqide_debug.log'
    " }}}
" }}}
"
if filereadable(expand('~/.config/nvim/after.local.vim'))
    execute 'source '.expand('~/.config/nvim/after.local.vim')
endif
