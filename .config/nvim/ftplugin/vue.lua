local syyyr = require('syyyr')
syyyr.register_printing({
    print_var = function(var_name)
        -- console.log is better at printing stuff than string interpolation.
        return string.format([[console.log('%s', '=', %s);]], var_name, var_name)
    end,
    print_text = function(text)
        return string.format([[console.log(`%s`)]], text)
    end,
})
