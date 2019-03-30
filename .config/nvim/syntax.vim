" highlight git merge conflicts
highlight MergeConflict ctermbg=black ctermfg=red
highlight def link mdTodo Todo
autocmd ColorScheme PaperColor highlight MergeConflict ctermbg=black ctermfg=red
autocmd Syntax * syn match MergeConflict '\v^[<\|=|>]{7}([^=].+)?$'
autocmd Filetype markdown syn keyword mdTodo TODO
