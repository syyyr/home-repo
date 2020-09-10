" deafult is /* */
scriptencoding utf8
set commentstring=//%s

function! s:AddIostream()
    if search('iostream', 'nw') == 0
        normal! ggO#include <iostream>
    endif
endfunction

function! s:PrintSomething(args, ...)
    call s:AddIostream()
    if a:1 == '!'
        execute 'normal! ostd::cout << "' . a:args . '\n";'
    else
        execute 'normal! ostd::cout << "' . a:args . '" << " = " << ' . a:args . ' << "\n";'
    endif
endfunction

function! s:PrintThis(delete)
    call s:AddIostream()
    if a:delete == '!'
        normal! "kdd"kP
    else
        normal! "kyy"kP
    endif
    substitute /;$//e
    normal! Istd::cout << 
    normal! A << "\n";
endfunction

command! -bang -nargs=1 Print call s:PrintSomething("<args>", "<bang>")
command! -bang Printthis call s:PrintThis("<bang>")
nnoremap <buffer> <expr> é expand('%:e') == 'cpp' ? ':e %:r.hpp<cr>' : ':e %:r.cpp<cr>'

nnoremap <C-]> :CocDefinition<cr>
