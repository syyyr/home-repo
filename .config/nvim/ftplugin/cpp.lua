local function add_iostream()
    if vim.fn.search('iostream', 'nw') == 0 then
        vim.fn.append(0, '#include <iostream>')
    end
end

require('custom').register_printing({
    print_var = function(var_name)
        add_iostream()
        return [[std::cout << "]] .. var_name .. [[" << "=" << ]] .. var_name .. [[ << "\n"]]
    end,
    print_text = function(text)
        add_iostream()
        return [[std::cout << "]] .. text .. [[\n";]]
    end,
})

vim.cmd([[iabbrev <buffer> DOCSUB DOCTEST_SUBCASE("")<Left><Left>]])
vim.o.cinoptions='j1,(0,ws,Ws,:0,l1,N-s,E-s'
