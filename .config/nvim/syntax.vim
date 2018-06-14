" highlight git merge conflicts
highlight MergeConflict ctermbg=black ctermfg=red
autocmd ColorScheme PaperColor highlight MergeConflict ctermbg=black ctermfg=red
autocmd Syntax * syn match MergeConflict '\v^[<\|=|>]{7}([^=].+)?$'
