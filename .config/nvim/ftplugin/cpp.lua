local function add_iostream()
    if vim.fn.search('iostream', 'nw') == 0 then
        vim.fn.append(0, '#include <iostream>')
    end
end

require('custom').register_printing({
    callback = add_iostream,
    quote = '"',
    prefix = 'std::cerr << ',
    infix = ' << " = " << ',
    suffix = [[ << "\n";]]
})

vim.cmd([[iabbrev <buffer> DOCSUB DOCTEST_SUBCASE("")<Left><Left>]])
vim.o.cinoptions='j1,(0,ws,Ws,:0,l1,N-s,E-s'
