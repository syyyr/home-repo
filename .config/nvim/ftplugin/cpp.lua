local function add_iostream()
    if vim.fn.search('iostream', 'nw') == 0 then
        vim.fn.append(0, '#include <iostream>')
    end
end

local function escape_double_quotes(text)
    return text:gsub([["]], [[\"]])
end

require('custom').register_printing({
    print_var = function(var_name)
        add_iostream()
        return [[std::cerr << "]] .. escape_double_quotes(var_name) .. [[" << " = " << ]] .. var_name .. [[ << "\n";]]
    end,
    print_text = function(text)
        add_iostream()
        return [[std::cerr << "]] .. escape_double_quotes(text) .. [[\n";]]
    end,
})

vim.cmd([[iabbrev <buffer> DOCSUB DOCTEST_SUBCASE("")<Left><Left>]])
vim.o.cinoptions='j1,(0,ws,Ws,:0,l1,N-s,E-s'
