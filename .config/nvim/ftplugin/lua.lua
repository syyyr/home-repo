local Custom = require('custom')

Custom.register_printing({
    print_var = function(var_name)
        return 'print("' .. Custom.escape_double_quotes(var_name) .. '", "=", ' .. var_name .. ')'
    end,
    print_text = function(text)
        return 'print("' .. Custom.escape_double_quotes(text) .. '")'
    end,
})

vim.bo.keywordprg = ':help'
