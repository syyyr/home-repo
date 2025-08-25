local syyyr = require('syyyr')
syyyr.register_printing({
    print_var = function(var_name)
        return string.format([[echo '%s' = "$%s"]], syyyr.escape_single_quotes(var_name), var_name)
    end,
    print_text = function(text)
        return string.format([[echo '%s']], text)
    end,
    no_printthis = true
})
