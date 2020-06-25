" deafult is /* */
set commentstring=//%s

function! s:PrintSomething(args, ...)
    if search('iostream', 'nw') == 0
        normal! ggO#include <iostream>
    endif
    if a:1 == '!'
        execute 'normal! ostd::cout << "' . a:args . '"' . " << std::endl;"
    else
        execute 'normal! ostd::cout << "' . a:args . '" << " = " << ' . a:args . " << std::endl;\<esc>"
    endif
endfunction

command! -bang -nargs=1 Print call s:PrintSomething("<args>", "<bang>")
nnoremap <buffer> <expr> é expand('%:e') == 'cpp' ? ':e %:r.hpp<cr>' : ':e %:r.cpp<cr>'

nnoremap <C-]> :CocDefinition<cr>
