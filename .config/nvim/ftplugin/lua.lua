local syyyr = require('syyyr')

syyyr.register_printing({
    print_var = function(var_name)
        return 'print("' .. syyyr.escape_double_quotes(var_name) .. '", "=", ' .. var_name .. ')'
    end,
    print_text = function(text)
        return 'print("' .. syyyr.escape_double_quotes(text) .. '")'
    end,
})

vim.bo.keywordprg = ':help'
