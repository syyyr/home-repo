local syyyr = require('syyyr')

syyyr.register_printing({
    print_var = function(var_name)
        return string.format([[message(STATUS "'%s' = ${%s}")]], syyyr.escape_double_quotes(var_name), var_name)
    end,
    print_text = function(text)
        return string.format([[message(STATUS "'%s'")]], text)
    end,
})
