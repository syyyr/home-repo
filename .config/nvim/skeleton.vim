scriptencoding utf8
augroup cSkeleton
    autocmd!
    autocmd BufNewFile main.c,main.cpp execute "normal! iint main(int argc, char* argv[])\n{\nreturn 0;\n}kk" | startinsert!
augroup END
augroup rsSkeleton
    autocmd!
    autocmd BufNewFile main.rs execute "normal! ifn main()\n{\n}k" | startinsert!
augroup END
