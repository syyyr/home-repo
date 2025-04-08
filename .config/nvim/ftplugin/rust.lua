local syyyr = require('syyyr')

require('syyyr').register_printing({
    print_var = function(var_name)
        return ([[eprintln!("%s = '{:?}'", %s);]]):format(syyyr.escape_double_quotes(var_name), var_name)
    end,
    print_text = function(text)
        return ([[eprintln!("%s");]]):format(syyyr.escape_double_quotes(text))
    end,
})
