require('syyyr').register_printing({
    print_var = function(var_name)
        return [[echo ']] .. var_name .. [[' = ]] .. '"$' .. var_name .. '"'
    end,
    print_text = function(text)
        return [[echo ']] .. text .. [[']]
    end,
    no_printthis = true
})
