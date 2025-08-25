vim.cmd('packadd vim-python-pep8-indent')

local syyyr = require('syyyr')
syyyr.register_printing({
    print_var = function(var_name)
        return string.format([[print(f'%s = {%s}')]], syyyr.escape_single_quotes(var_name), var_name)
    end,
    print_text = function(text)
        return string.format([[print('%s')]], syyyr.escape_single_quotes(text))
    end,
})
