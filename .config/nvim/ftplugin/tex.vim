" automatically try to compile after saving (works with update)
autocmd BufWritePost *.tex silent Make!

inoremap <buffer> \tit \textit{
inoremap <buffer> \ttt \texttt{
inoremap <buffer> "" \uv{
inoremap <buffer> C++ \Cpp{}
inoremap <buffer> \fn \footnote{
inoremap <buffer> \v \verb¨


set diffopt+=horizontal

" I don't want this mapping in Tex
augroup unmap
    autocmd!
    autocmd BufEnter *.tex silent! iunmap {<CR>
    autocmd BufLeave *.tex inoremap {<CR> {<CR>}<Esc>O
augroup END
