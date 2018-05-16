" vim:foldmethod=marker

set nocompatible

" Functions and commands {{{
    " Remove the trailing whitespaces.
    function! <SID>tdvimrc_strip_spaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfunction
" }}}
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
    " Remove trailing whitespaces on saving buffers.
    autocmd BufWritePre * :call <SID>tdvimrc_strip_spaces()
    " Find tags file recursively up the directory.
    set tags=./.tags;,.tags
    " Set the leader key to space.
    let mapleader=' '
    " Enable mouse in terminal mode.
    set mouse=a
" }}}
" Plugin list {{{
    " Specify the plugin directory.
    call plug#begin('~/.local/share/nvim/plugged')

    Plug 'morhetz/gruvbox'
    Plug 'mhinz/vim-signify'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'neomake/neomake'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'Valloric/YouCompleteMe'
    Plug 'SirVer/ultisnips'
    Plug 'tpope/vim-fugitive'
    Plug 'mbbill/undotree'
    Plug 'milkypostman/vim-togglelist'
    Plug 'Yggdroot/LeaderF'
    Plug 'Vimjas/vim-python-pep8-indent'
    Plug 'mileszs/ack.vim'

    Plug '~/Projects/vim-coqide'

    " Initialize the plugin system.
    call plug#end()
" }}}
" Gruvbox: an orangish color theme {{{
    set background=dark
    colorscheme gruvbox
" }}}
" Undotree: rolling back in a history tree {{{
    " Persist the undo information in the file system.
    if has('persistent_undo')
        silent call system('mkdir -p ~/.vim-undo')
        set undodir=~/.vim-undo
        set undofile
    endif

    " Command to toggle the undotree.
    function! <SID>tdvimrc_undotree_focus()
        UndotreeToggle
        UndotreeFocus
    endfunction
    nnoremap <leader>u :call <SID>tdvimrc_undotree_focus()<CR>
" }}}
" Airline: pretty status line {{{
    " Don't use powerline symbols.
    let g:airline_powerline_fonts = 0
" }}}
" Gutentags: generating tags file on the fly {{{
    " The file names that identify a project root directory.
    let g:gutentags_project_root = ['.git', '.root', '.svn', '.hg', '.project']
    " The tags file name to generate.
    let g:gutentags_ctags_tagfile = '.tags'
    " Save all the tag files to ~/.cache/tags in order not to pollute the
    " project directory.
    let s:vim_tags = expand('~/.cache/tags')
    let g:gutentags_cache_dir = s:vim_tags
    " The options passed to ctags program.
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
    " Detect and create ~/.cache/tags directory.
    if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
    endif
" }}}
" AsyncRun: running commands in the background {{{
    " Open quickfix automatically with height 6.
    let g:asyncrun_open = 6
    " The project root directory.
    let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
" }}}
" Fugitive: essential Git migration {{{
    nnoremap <leader>g :Gstatus<cr>
" }}}
" Neomake: an asynchronous syntax checking tool {{{
    " When reading a buffer (after 1s), and when writing (no delay).
    call neomake#configure#automake('rw', 1000)
" }}}
" Signify: showing modifications in the sign column {{{
    nnoremap <leader>d :SignifyDiff<cr>
" }}}
" LeaderF: fast fuzzy file finder and etc {{{
    " Do not use unicode separators.
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }
    " Use the first ancestor directory that contains these directories and
    " files as the searching root.
    let g:Lf_RootMarkers = ['.svn', '.git', '.project']
    let g:Lf_WorkingDirectoryMode = 'Ac'

    nnoremap <leader>f :LeaderfFile<cr>
    nnoremap <leader>b :LeaderfBuffer<cr>
    nnoremap <leader>r :LeaderfMru<cr>
    nnoremap <leader>h :LeaderfHelp<cr>
" }}}
" ToogleList: toggle quickfix and location list {{{
    let g:toggle_list_no_mappings = 1
    nnoremap <leader>e :call ToggleQuickfixList()<cr>
    nnoremap <leader>l :call ToggleLocationList()<cr>
" }}}
" YouCompleteMe: semantic completion framework {{{
    " Trigger the semantic completion after two characters. This is fast only
    " in Neovim or Vim8.
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
" }}}
" UltiSnips: snippet framework {{{
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
" Ack: grep enhancement {{{
    if executable('ag')
      let g:ackprg = 'ag --vimgrep'
    endif
" }}}
" CoqIDE: A Coq IDE {{{
    let g:coqide_debug = 1
    let g:coqide_debug_file = 'coqide_debug.log'
" }}}
