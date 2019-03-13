" WeeChat Log syntax file
" Language:    weechatlog
" Maintainer:  Ghosty <hannah@starlitghost.xyz>
" Last Change: 11 Dec 2017
" Filenames:   *.weechatlog

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "weechatlog"

let s:keepcpo = &cpo
set cpo&vim

syn match wclLine '\v^.*$' contains=wclDate
syn match wclJoin '\v-->.+$' contained " \w+ \([^)]+\) has joined #\w+' contained
syn match wclData '\v.*$' contained contains=wclJoin
syn match wclTime '\v\d{2}:\d{2}:\d{2}' nextgroup=wclData skipwhite contained
syn match wclDate '\v^\d{4}-\d{2}-\d{2}' nextgroup=wclTime skipwhite contained

hi def wclDate ctermfg=DarkBlue
hi def wclTime ctermfg=DarkBlue
hi def wclJoin ctermfg=DarkGreen

" We don't need to look backwards to highlight correctly;
" this speeds things up greatly.
syntax sync minlines=1 maxlines=1

let &cpo = s:keepcpo
unlet s:keepcpo

finish
