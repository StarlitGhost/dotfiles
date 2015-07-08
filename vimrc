" Some sort of magic for system-independence and reliability
set nocompatible

" Plugin system
execute pathogen#infect()

" Basic vim options
syntax on                   " turn on syntax highlighting
filetype plugin indent on   " determine filetypes by name and contents, for auto-indent and plugins
set relativenumber number   " enable current line number, and relative line numbering above/below
set encoding=utf-8          " use the only sensible text encoding
set t_Co=256                " use 256 colours, this isn't the 80s
set mouse=a                 " enable mouse support
set backspace=2             " make backspace work like any other editor in insert mode
set tabstop=4               " set the tab-width to 4 rather than the vim default of 8
set shiftwidth=4            " something to do with tab sizes, I dunno?
set expandtab               " convert tabs to spaces
set ignorecase smartcase    " case-insensitive search, except when using capital letters
set autoindent              " auto-indent even if the filetype doesn't have indent settings
set hlsearch                " highlight search matches

" Colour settings
highlight LineNr ctermfg=DarkGray
highlight CursorLineNr ctermfg=White

" Powerline/airline options
let g:airline_powerline_fonts = 1   " enable powerline symbols for airline
set laststatus=2            " always show statusline
set noshowmode              " disable the default mode display
