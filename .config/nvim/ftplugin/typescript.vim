packadd typescript-vim
function! s:PrintSomething(args, ...)
    if a:1 == '!'
        execute 'normal! oconsole.log("' . a:args . '");'
    else
        execute 'normal! oconsole.log("' . a:args . '", "=", ' . a:args . ');'
        execute 'normal! ostd::cout << "' . a:args . '" << " = " << ' . a:args . " << std::endl;\<esc>"
    endif
endfunction
command! -bang -nargs=1 Print call s:PrintSomething("<args>", "<bang>")
