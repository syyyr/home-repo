require('custom').register_printing({
    print_var = function(var_name)
        return 'console.log("' .. var_name .. '", "=", ' .. var_name .. ')'
    end,
    print_text = function(text)
        return 'console.log("' .. text .. '")'
    end,
})
