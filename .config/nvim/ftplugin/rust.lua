local syyyr = require('syyyr')

require('syyyr').register_printing({
    print_var = function(var_name)
        return ([[dbg!(%s);]]):format(var_name)
    end,
    print_text = function(text)
        return ([[dbg!("%s");]]):format(syyyr.escape_double_quotes(text))
    end,
})
