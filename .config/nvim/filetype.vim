" automatically try to compile a tex file
au BufWritePost *.tex silent make

" comments for cpp
au Filetype cpp set commentstring=//%s

" markdown todo
highlight def link mdTodo Todo
autocmd Filetype markdown syn keyword mdTodo TODO
