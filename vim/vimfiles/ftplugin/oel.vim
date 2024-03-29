" Vim filetype plugin file
" Language:	oel
" Maintainer:	Johannes Zellner <johannes@zellner.org>
" Last Change:	Don, 25 Jan 2001 20:10:04 +0100

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal cinkeys-=0#
"setlocal indentkeys-=0#
"setlocal include=\s*\\(from\\\|import\\)
"setlocal suffixesadd=.py

set cindent
set tabstop=4
set shiftwidth=4
set cinwords+=foreach,unless,when,comment
set cino=(0,w1
setlocal fo-=t fo+=croql
setlocal com& com^=sO:*\ -,mO:*\ \ ,exO:*/  " Behaves just like C
setlocal com^=s:\",mO:\",e:\" 

set textwidth=78
