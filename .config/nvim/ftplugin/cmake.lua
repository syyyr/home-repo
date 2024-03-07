local syyyr = require('syyyr')

syyyr.register_printing({
    print_var = function(var_name)
        return 'message(STATUS "' .. var_name .. ' = ${' .. var_name .. '}")'
    end,
    print_text = function(text)
        return 'message(STATUS "' .. syyyr.escape_double_quotes(text) .. '")'
    end,
})
