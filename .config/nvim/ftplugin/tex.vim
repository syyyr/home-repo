" automatically try to compile after saving (works with update)
autocmd BufWritePost *.tex silent Make!

inoremap <buffer> \tit \textit{
inoremap <buffer> \ttt \texttt{
inoremap <buffer> "" \uv{
inoremap <buffer> C++ \Cpp{}
inoremap <buffer> \fn \footnote{
inoremap <buffer> \v \verb¨


set diffopt+=horizontal

" I don't want the global mapping in Tex files. However, this doesn't solve
" the timeout issue :/
inoremap <buffer> <nowait> { {
