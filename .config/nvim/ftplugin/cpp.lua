local function add_iostream()
    if vim.fn.search('iostream', 'nw') == 0 then
        vim.fn.append(0, '#include <iostream>')
    end
end

local function get_stream()
    if vim.fn.search('#include <Q', 'nw') ~= 0 then
        return 'qDebug()'
    else
        add_iostream()
        return 'std::cerr'
    end
end

local syyyr = require('syyyr')

syyyr.register_printing({
    print_var = function(var_name)
        return get_stream() .. [[ << "]] .. syyyr.escape_double_quotes(var_name) .. [[" << " = " << ]] .. var_name .. [[ << "\n";]]
    end,
    print_text = function(text)
        return get_stream() .. [[ << "]] .. syyyr.escape_double_quotes(text) .. [[\n";]]
    end,
})

vim.cmd([[iabbrev <buffer> DOCSUB DOCTEST_SUBCASE("")<Left><Left>]])
vim.o.cinoptions='j1,(0,ws,Ws,:0,l1,N-s,E-s'
