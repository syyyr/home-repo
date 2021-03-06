nnoremap <buffer> <expr> <C-A> getline('.')[col('.')-1] =~ "[^0-9]" ? "" : "viw\<C-A>"
nnoremap <buffer> <expr> <C-X> getline('.')[col('.')-1] =~ "[-0]" ? "" : "viw\<C-X>"
nnoremap <buffer> <expr> - getline('.')[col('.')-1] == "-" ? "r-" : "ciw-\<esc>"
nnoremap <buffer> <expr> 0 getline('.')[col('.')-1] == "-" ? "r0" : "ciw0\<esc>"
nnoremap <buffer> <expr> 1 getline('.')[col('.')-1] == "-" ? "r1" : "ciw1\<esc>"
nnoremap <buffer> <expr> 2 getline('.')[col('.')-1] == "-" ? "r2" : "ciw2\<esc>"
nnoremap <buffer> <expr> 3 getline('.')[col('.')-1] == "-" ? "r3" : "ciw3\<esc>"
nnoremap <buffer> <expr> 4 getline('.')[col('.')-1] == "-" ? "r4" : "ciw4\<esc>"
nnoremap <buffer> <expr> 5 getline('.')[col('.')-1] == "-" ? "r5" : "ciw5\<esc>"
nnoremap <buffer> <expr> 6 getline('.')[col('.')-1] == "-" ? "r6" : "ciw6\<esc>"
nnoremap <buffer> <expr> 7 getline('.')[col('.')-1] == "-" ? "r7" : "ciw7\<esc>"
nnoremap <buffer> <expr> 8 getline('.')[col('.')-1] == "-" ? "r8" : "ciw8\<esc>"
nnoremap <buffer> <expr> 9 getline('.')[col('.')-1] == "-" ? "r9" : "ciw9\<esc>"
nnoremap <buffer> b ?\d\+<cr>:nohl<cr>
nnoremap <buffer> w /\d\+<cr>:nohl<cr>
nnoremap <buffer> H 0/\d\+<cr>:nohl<cr>
nnoremap <buffer> L $?\d\+<cr>:nohl<cr>
