local syyyr = require('syyyr')
syyyr.register_printing({
    print_var = function(var_name)
        -- console.log is better at printing stuff than string interpolation.
        return string.format([[console.log('%s', '=', %s);]], syyyr.escape_single_quotes(var_name), var_name)
    end,
    print_text = function(text)
        local quote = string.find(text, '${') ~= nil and [[`]] or [[']]
        return string.format([[console.log(%s%s%s);]], quote, text, quote)
    end,
})
