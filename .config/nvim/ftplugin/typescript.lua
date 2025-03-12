local syyyr = require('syyyr')
require('syyyr').register_printing({
    print_var = function(var_name)
        return 'console.log("' .. syyyr.escape_double_quotes(var_name) .. '", "=", ' .. var_name .. ');'
    end,
    print_text = function(text)
        return 'console.log("' .. text .. '");'
    end,
})
