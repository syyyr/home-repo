scriptencoding utf8
augroup cSkeleton
    autocmd!
    autocmd BufNewFile main.c,main.cpp execute 'normal! iint main(int argc, char* argv[])
augroup END
augroup rsSkeleton
    autocmd!
    autocmd BufNewFile main.rs execute 'normal! ifn main()
augroup END