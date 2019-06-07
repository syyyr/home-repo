setlocal foldmethod=manual
setlocal statusline=%#Conceal#
execute 'setlocal fillchars+=eob:\ '
IndentLinesDisable
silent! read ~/.local/share/thinking.txt
call setpos('.', [0, 14, 91, 0])
setlocal modifiable
execute 'normal! r '
setlocal nomodifiable
