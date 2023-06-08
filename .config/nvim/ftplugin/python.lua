vim.cmd('packadd vim-python-pep8-indent')

local function escape_double_quotes(text)
    return text:gsub([["]], [[\"]])
end

require('custom').register_printing({
    print_var = function(var_name)
        return 'print("' .. escape_double_quotes(var_name) .. '", "=", ' .. var_name .. ')'
    end,
    print_text = function(text)
        return 'print("' .. escape_double_quotes(text) .. '")'
    end,
})
