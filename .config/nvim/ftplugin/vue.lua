local syyyr = require('syyyr')
syyyr.register_printing({
    print_var = function(var_name)
        return string.format([[console.log(`%s = ${%s}`);]], var_name, var_name)
    end,
    print_text = function(text)
        return string.format([[console.log(`%s`)]], text)
    end,
})
