" automatically try to compile after saving (works with update)
autocmd BufWritePost *.tex silent Make!

inoremap \tit \textit{
inoremap \ttt \texttt{
inoremap "" \uv{
inoremap C++ \Cpp{}
inoremap \fn \footnote{
inoremap \v \verb¨


set diffopt+=horizontal

" I don't want this mapping in Tex
silent! iunmap {<CR>
