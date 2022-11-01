function! s:PrintSomething(args, ...)
    if a:1 == '!'
        execute 'normal! oprint("' . a:args . '")'
    else
        execute 'normal! oprint("' . a:args . '", "=", ' . a:args . ')'
    endif
endfunction

function! s:PrintThis(delete)
    if a:delete == '!'
        normal! "kdd"kP
    else
        normal! "kyy"kP
    endif
    normal! ^y$i"pa = ", 
    normal! Iprint(
    normal! A)
endfunction

command! -bang -nargs=1 Print call s:PrintSomething("<args>", "<bang>")
command! -bang Printthis call s:PrintThis("<bang>")

setlocal keywordprg=:help
