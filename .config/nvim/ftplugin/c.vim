nnoremap <C-]> :CocDefinition<cr>
nnoremap <buffer> <expr> é expand('%:e') =~ 'c' ? (or(filereadable(expand('%:r') . '.hpp'), bufexists(expand('%:r') . '.hpp')) ? ':e %:r.hpp<cr>' : ':e %:r.h<cr>' ) : filereadable(expand('%:r') . '.c') ? ':e %:r.c<cr>' : ':e %:r.cpp<cr>'
set commentstring=//%s
