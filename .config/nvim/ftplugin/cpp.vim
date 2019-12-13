" deafult is /* */
set commentstring=//%s
command! -nargs=1 Print normal! ostd::cout << "<args> = " << <args> << std::endl;<esc>
nnoremap <buffer> <expr> é expand('%:e') == 'cpp' ? ':e %:r.hpp<cr>' : ':e %:r.cpp<cr>'
