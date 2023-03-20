require('custom').register_printing({
    print_var = function(var_name)
        return 'print("' .. var_name .. '", "=", ' .. var_name .. ')'
    end,
    print_text = function(text)
        return 'print("' .. text .. '")'
    end,
})

vim.bo.keywordprg = ':help'
