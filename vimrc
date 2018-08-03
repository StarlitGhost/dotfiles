" We're not using Vi, so don't pretend we are
set nocompatible

" Set the runtime path (where .vim dir is) to include my $REALHOME var
let &runtimepath = printf('%s,%s', expand($REALHOME . '/.vim'), &runtimepath)
let &runtimepath = printf('%s,%s', expand($REALHOME . '/.vim/bundles/repos/github.com/Shougo/dein.vim'), &runtimepath)

" Plugin system
if dein#load_state(expand('$REALHOME/.vim/bundles'))
    call dein#begin(expand('$REALHOME/.vim/bundles'))
    call dein#add('$REALHOME/.vim/bundles/repos/github.com/Shougo/dein.vim')

    call dein#add('ctrlpvim/ctrlp.vim')   " Fuzzy file, buffer, etc finder (ctrl+p)
    call dein#add('scrooloose/nerdtree')  " Tree file browser
    call dein#add('bling/vim-airline')    " Fancy status and tablines
    call dein#add('airblade/vim-gitgutter') " git integration ([c ]c jump hunks, \hp preview, \hs stage, \hu undo)
    call dein#add('luochen1990/rainbow')  " rainbow parentheses
    call dein#add('vim-syntastic/syntastic') " Syntax checking via external programs
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    "call dein#add('guns/xterm-color-table.vim') " xterm colors with rgb equivalents (:XtermColorTable)
    call dein#add('roxma/nvim-completion-manager')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#add('rust-lang/rust.vim')   " All kinds of rust stuff
    call dein#add('racer-rust/vim-racer')
    let g:racer_cmd = expand($REALHOME . '/.cargo/bin/racer')
    call dein#add('roxma/nvim-cm-racer')
    call dein#add('vim-scripts/Conque-GDB') " GDB within vim
"    call dein#add('ervandew/supertab')    " Makes Tab the insert-mode completion key for everything
    call dein#add('terryma/vim-multiple-cursors') " Multiple cursors like Sublime Text. ctrl+n
    call dein#add('nfvs/vim-perforce')    " Perforce integration
    call dein#add('vim-scripts/supp.vim') " valgrind suppression file syntax highlighting
    call dein#add('PotatoesMaster/i3-vim-syntax') " i3 config syntax highlighting
    call dein#add('bogado/file-line')     " Enables 'vim file:20' to open file scrolled to line 20
    call dein#add('xolox/vim-misc')
    call dein#add('xolox/vim-reload')     " Auto-reload various types of vim scripts when edited
    call dein#add('yuratomo/w3m.vim')     " Web Browser (:W3m [url])
"    call dein#add('Shougo/vinarise.vim')  " Hex Editor  (:Vinarise [options] [path])
"    let g:vinarise_enable_auto_detect = 1

    call dein#end()
    call dein#save_state()
endif

if !has('vim_starting') && dein#check_install()
    " Installation check.
    call dein#install()
endif

"let g:deoplete#enable_profile = 1
"call deoplete#enable_logging('DEBUG', 'deoplete.log')
"call deoplete#custom#set('jedi', 'debug_enabled', 1)

" Basic vim options
syntax on                   " turn on syntax highlighting
filetype plugin indent on   " determine filetypes by name and contents, for auto-indent and plugins
set number                  " enable line numbering...
if exists('+relativenumber') " (option was added in vim version 7.3)
    set relativenumber      " ...and make it relative to the current line
endif
set shell=zsh               " use my preferred shell, csh is garbage
set encoding=utf-8          " use the only sensible text encoding
set t_Co=256                " use 256 colours, this isn't the 80s
set mouse=a                 " enable mouse support
set backspace=2             " make backspace work like any other editor in insert mode
set tabstop=4               " set the width of the tab character
set softtabstop=4           " set the amount of whitespace to insert when the tab key is pressed
set shiftwidth=4            " how much whitespace to indent/unindent by
set expandtab               " convert tab keypresses to spaces, obeying softtabstop
set ignorecase smartcase    " case-insensitive search, except when using capital letters
set autoindent              " auto-indent even if the filetype doesn't have indent settings
set hlsearch incsearch      " highlight search matches, incrementally
if exists('&inccommand')    " option only exists in neovim 1.7+
    set inccommand=nosplit  " highlight and live preview substitutions
endif
set showmatch               " highlight matching brackets
set scrolloff=5             " keep 5 lines above/below the current line
set sidescrolloff=5         " ...and cols on the left/right (if wrap is off)
"set textwidth=100           " hard-wrap typed text past this column, at the nearest whitespace
set textwidth=0             " turn off hard word wrap
set colorcolumn=100         " highlight the 100th column
set listchars=tab:▸\ ,eol:¬ " characters to use for tab and end-of-line in visible whitespace mode
set wildmenu                " tab completion menu stuff
set wildmode=list:longest,full
set showcmd                 " show (partial) command in status line
set cursorline              " highlight the current line
"set cursorcolumn            " highlight the current column
set autoread                " automatically refresh unchanged files if they have edits on disk
autocmd FocusGained,BufEnter * :checktime
if has('unnamedplus')
    set clipboard=unnamedplus " disable system clipboard integration, too slow when X isn't running
endif
set pastetoggle=<F2>        " toggle paste-mode with F2 - disables autoindent, among other things
set timeoutlen=200          " reduce timeout for command sequences (default 1000)

" Make undo history persistent
if has('persistent_undo')
    let myUndoDir = expand($REALHOME . '/.vim/undodir')
    " Create undodir if it doesn't exist
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
    set undolevels=1000
    set undoreload=10000
endif

" Highlight the 80th column, and all columns >100
" 500 seems reasonable since you have to give an upper limit
if exists('+colorcolumn')
    let &colorcolumn="80,".join(range(101,500),",")
endif

" Enable mouse resizing of vim windows inside tmux/screen
if &term =~ '^screen'
    set ttymouse=xterm2
endif

" Automatically source ~/.vimrc when it is saved
autocmd BufWritePost .vimrc source $MYVIMRC

" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Filetype mappings for unrecognised extensions
""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.cshrc setfiletype csh

autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo

" Change the cursor shape for insertion and replacement mode,
" if the terminal supports that
"if &term =~ '^(xterm\\|screen\\|rxvt)'
    " Insert mode
    let &t_SI .= "\<Esc>[5 q" " blinking vertical bar
    " Replacement mode
    if v:version > 704 || v:version == 704 && has('patch687')
        let &t_SR .= "\<Esc>[3 q" " blinking underscore
    end
    " Normal mode
    let &t_EI .= "\<Esc>[2 q" " solid block
"endif

" Key mappings
"""""""""""""""
" Exit insert mode with jj 
inoremap jj <Esc>
" Not really sure? It accompanied the jj bind online
nnoremap JJJJ <Nop>
" Insert newlines without going into insert mode
nnoremap oo m`o<Esc>``
nnoremap OO m`O<Esc>``
" Swap ; & : in normal and visual modes, for shift-less commands
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
" Open .vimrc in a new tab
nnoremap <leader>v :tabedit $MYVIMRC<CR>
" Esc twice to clear the last search
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
" Use tab for completion
inoremap <expr> <Tab> (pumvisible() ? "\<C-n>" : "\<Tab>")
inoremap <expr> <S-Tab> (pumvisible() ? "\<C-p>" : "\<S-Tab>")
" F5 to save & execute the current python buffer
autocmd FileType python nnoremap <buffer> <F5> <ESC>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" c(hange) o(ption) _ mappings
"""""""""""""""""""""""""""""""
" Toggle word wrapping
nnoremap <silent> cow :set wrap!<CR>
" Toggle visible whitespace characters
nnoremap <silent> cos :set list!<CR>
" Toggle line numbering
nnoremap <silent> con :set number! relativenumber!<CR>
" Toggle relative line numbering (cor & con don't play well, remembering state would be cool)
nnoremap <silent> cor :set relativenumber!<CR>
" Toggle the GitGutter
nnoremap <silent> cog :GitGutterToggle<CR>
" Toggle NerdTree
nnoremap <silent> cot :NERDTreeToggle<CR>

" Colour settings
""""""""""""""""""
highlight LineNr ctermbg=234 ctermfg=DarkGray
highlight CursorLineNr ctermbg=Black ctermfg=White
highlight CursorLine cterm=NONE ctermbg=Black
highlight CursorColumn cterm=NONE ctermbg=Black
highlight ColorColumn ctermbg=234
highlight Visual ctermbg=238
highlight NonText ctermfg=237
highlight SpecialKey ctermfg=237
highlight MatchParen cterm=Bold ctermbg=33 ctermfg=17
highlight Search ctermbg=202 ctermfg=0
highlight Folded ctermbg=NONE

" Plugin Settings
""""""""""""""""""
" Powerline/airline options
let g:airline_powerline_fonts = 1   " enable powerline symbols for airline
let g:airline#extensions#tabline#enabled = 1 " enable tab line
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
set laststatus=2            " always show statusline
set noshowmode              " disable the default mode display

" ctrlp.vim options
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

" GitGutter options
set updatetime=2000         " vim default of 4000ms is way too long

" Rainbow Brackets options
let g:rainbow_active = 1

" jedi options
let g:jedi#show_call_signatures = "2"
