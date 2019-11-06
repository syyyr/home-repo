" deafult is /* */
set commentstring=//%s
command! -nargs=1 Print normal! ostd::cout << "<args> = " << <args> << std::endl;<esc>
