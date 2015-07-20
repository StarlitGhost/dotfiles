" Some sort of magic for system-independence and reliability
set nocompatible

" Plugin system
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/Conque-Shell'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'luochen1990/rainbow'
Plug 'guns/xterm-color-table.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'terryma/vim-multiple-cursors'
call plug#end()

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
set softtabstop=4           " set the tab-width to 4 rather than the vim default of 8
set shiftwidth=4            " something to do with tab sizes, I dunno?
set expandtab               " convert tabs to spaces
set ignorecase smartcase    " case-insensitive search, except when using capital letters
set autoindent              " auto-indent even if the filetype doesn't have indent settings
set hlsearch incsearch      " highlight search matches, incrementally
set showmatch               " highlight matching brackets
set scrolloff=5             " keep 5 lines above/below the current line
set sidescrolloff=5         " ...and cols on the left/right (if wrap is off)
set colorcolumn=100         " highlight the 100th column
set wildmenu                " tab completion menu stuff
set wildmode=list:longest,full
set showcmd                 " show (partial) command in status line
set cursorline              " highlight the current line
"set cursorcolumn            " highlight the current column
set autoread                " automatically refresh unchanged files if they have edits on disk
autocmd FocusGained,BufEnter * :silent! !
set clipboard=exclude:.*    " disable system clipboard integration, too slow when X isn't running
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
" 500 seems reasonable since you have to give a limit
if exists('+colorcolumn')
    let &colorcolumn="80,".join(range(101,500),",")
endif

" Enable mouse resizing of vim windows inside tmux/screen
if &term =~ '^screen'
    set ttymouse=xterm2
endif

" Key mappings
inoremap jj <Esc>
nnoremap JJJJ <Nop>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
" F5 to save & execute the current python buffer
autocmd FileType python nnoremap <buffer> <F5> <ESC>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" Colour settings
highlight LineNr ctermbg=234 ctermfg=DarkGray
highlight CursorLineNr ctermbg=Black ctermfg=White
highlight CursorLine cterm=NONE ctermbg=Black
highlight CursorColumn cterm=NONE ctermbg=Black
highlight ColorColumn ctermbg=234
highlight Visual ctermbg=238

" Powerline/airline options
let g:airline_powerline_fonts = 1   " enable powerline symbols for airline
set laststatus=2            " always show statusline
set noshowmode              " disable the default mode display

" GitGutter options
set updatetime=2000         " vim default of 4000ms is way too long

" Rainbow Brackets options
let g:rainbow_active = 0
