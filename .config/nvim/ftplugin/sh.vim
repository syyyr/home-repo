function! s:PrintSomething(args, ...)
    if a:1 == '!'
        execute 'normal! oecho "' . a:args . '"'
    else
        execute 'normal! oecho "' . a:args . '" = "$' . a:args . '"'
    endif
endfunction

command! -bang -nargs=1 Print call s:PrintSomething("<args>", "<bang>")
