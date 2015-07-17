" Some sort of magic for system-independence and reliability
set nocompatible

" Plugin system
"execute pathogen#infect()
filetype off
set rtp+=$REALHOME/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'
Bundle 'airblade/vim-gitgutter'
Bundle 'vim-scripts/Conque-Shell'
Bundle 'guns/xterm-color-table.vim'
Bundle 'luochen1990/rainbow'
filetype on

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
set sidescrolloff=5         " ...and on the left/right? not sure what this actually does
set colorcolumn=100         " highlight the 100th column
set wildmenu                " tab completion menu stuff?
set wildmode=list:longest,full
set showcmd                 " show (partial) command in status line
set cursorline              " highlight the current line
"set cursorcolumn            " highlight the current column
set autoread                " automatically refresh unchanged files if they have edits on disk
autocmd FocusGained,BufEnter * :silent! !
set clipboard=exclude:.*    " disable the system clipboard integration, way too slow when I don't have an X server running

" Highlight the 100th column and onwards
" 500 seems reasonable since you have to give a limit
if exists('+colorcolumn')
    let &colorcolumn=join(range(101,500),",")
endif

" Key mappings
inoremap jj <Esc>
nnoremap JJJJ <Nop>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <silent> <Esc><Esc> :let @/=""<CR>
autocmd FileType python nnoremap <buffer> <F5> <ESC>:w<CR>:exec '!python' shellescape(@%, 1)<CR>

" Colour settings
highlight LineNr ctermbg=234 ctermfg=DarkGray
highlight CursorLineNr ctermbg=Black ctermfg=White
highlight CursorLine cterm=NONE ctermbg=Black
highlight CursorColumn cterm=NONE ctermbg=Black
highlight ColorColumn ctermbg=234

" Powerline/airline options
let g:airline_powerline_fonts = 1   " enable powerline symbols for airline
set laststatus=2            " always show statusline
set noshowmode              " disable the default mode display

" GitGutter options
set updatetime=2000         " vim default of 4000ms is way too long

" Rainbow Brackets options
let g:rainbow_active = 1
