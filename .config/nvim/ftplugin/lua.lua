local syyyr = require('syyyr')

syyyr.register_printing({
    print_var = function(var_name)
        return string.format('print([[%s]], [[=]], %s)', var_name, var_name)
    end,
    print_text = function(text)
        return string.format('print([[%s]])', text)
    end,
})

vim.bo.keywordprg = ':help'
