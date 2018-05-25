" vim:foldmethod=marker

set nocompatible

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
    Plug 'Yggdroot/LeaderF', { 'on': [ 'LeaderfFile',
                \ 'LeaderfBuffer', 'LeaderfMru', 'LeaderfHelp' ] }
    Plug 'milkypostman/vim-togglelist'
    Plug 'mileszs/ack.vim'
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-unimpaired'
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
    " }}}
    " Auto Completion {{{
    Plug 'Valloric/YouCompleteMe', { 'for': ['python', 'vim'] }
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
    " Coq {{{
    Plug 'thomasding/vim-coqide'
    " }}}
    " Epilogue {{{
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
        nnoremap <leader>tc :call ToggleQuickFixList()<cr>
        nnoremap <leader>tl :call ToggleLocationList()<cr>

        " Command to toggle the undotree.
        function! <SID>tdvimrc_undotree_focus()
            UndotreeToggle
            UndotreeFocus
        endfunction
        nnoremap <leader>tu :call <SID>tdvimrc_undotree_focus()<CR>

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

        " Use ag in Ack.vim
        if executable('ag')
          let g:ackprg = 'ag --vimgrep'
        endif
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

        nmap <leader>ghs <Plug>GitGutterStageHunk
        nmap <leader>ghu <Plug>GitGutterUndoHunk

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
        " The options passed to ctags program (we use universal ctags instead).
        let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
        let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
        let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
        " Detect and create ~/.cache/tags directory.
        if !isdirectory(s:vim_tags)
            silent! call mkdir(s:vim_tags, 'p')
        endif
    " }}}
    " Auto Completion {{{
        " YouCompleteMe {{{
            " Trigger the semantic completion after two characters.
            let g:ycm_semantic_triggers =  {
                        \ 'c,cpp,python,java,go': ['re!\w{2}'],
                        \ 'cs,lua,javascript': ['re!\w{2}'],
                        \ }
            " Enable the semantic completion only for these files.
            let g:ycm_filetype_whitelist = {
                        \ "c": 1,
                        \ "cpp": 1,
                        \ "python": 1,
                        \ "java": 1,
                        \ "go": 1,
                        \ "cs": 1,
                        \ "lua": 1,
                        \ "javascript": 1,
                        \ "objc": 1,
                        \ "sh": 1,
                        \ "zsh": 1,
                        \ "vim": 1,
                        \ }
            " Do not complete in comments and strings.
            let g:ycm_complete_in_comments = 0
            let g:ycm_complete_in_strings = 0
            " Do not show the completion preview.
            set completeopt-=preview
            " Do not show the diagnostic highlighting.
            let g:ycm_enable_diagnostic_highlighting = 0
            " Use Python3 for Python files.
            let g:ycm_python_binary_path = 'python3'
        " }}}
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

        " Bind keys.
        nnoremap <leader>ii :IronRepl<cr>
        nnoremap <leader>ip :IronPromptRepl<cr>
        nnoremap <leader>ic :IronPromptCommand<cr>
    " }}}
    " Coq {{{
        let g:coqide_debug = 1
        let g:coqide_debug_file = 'coqide_debug.log'
    " }}}
" }}}
