scriptencoding utf8


let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
let g:tex_conceal = 'amgs' " default but don't conceal delimiters
packadd vimtex

" automatically try to compile after saving (works with update)
augroup compilingTex
    autocmd!
    autocmd BufWritePost *.tex silent Make!
augroup END

set makeprg=make

inoremap <buffer> \tit \textit{
inoremap <buffer> \ttt \texttt{
inoremap <buffer> "" \uv{
inoremap <buffer> C++ \Cpp{}
inoremap <buffer> \fn \footnote{
inoremap <buffer> \v \verb¨


set diffopt+=horizontal

" I don't want the global mapping in Tex files
inoremap <buffer> <nowait> { {
