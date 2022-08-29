scriptencoding utf8

function! s:AddIostream()
    if search('iostream', 'nw') == 0
        normal! ggO#include <iostream>
    endif
endfunction

function! s:PrintSomething(args, ...)
    call s:AddIostream()
    if a:1 == '!'
        execute 'normal! ostd::cerr << "' . a:args . '\n";'
    else
        execute 'normal! ostd::cerr << "' . a:args . '" << " = " << ' . a:args . ' << "\n";'
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
    normal! ^y$i"pa = " << 
    normal! Istd::cerr << 
    normal! A << "\n";
endfunction

command! -bang -nargs=1 Print call s:PrintSomething("<args>", "<bang>")
command! -bang Printthis call s:PrintThis("<bang>")

nnoremap <C-]> :CocDefinition<cr>
nnoremap <C-W><C-]> <c-w><c-s>:CocDefinition<cr>

iabbrev <buffer> DOCSUB DOCTEST_SUBCASE("")<Left><Left>
set cinoptions=j1,(0,ws,Ws,:0,l1
