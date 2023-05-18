local function add_stdio()
    if vim.fn.search('stdio.h', 'nw') == 0 then
        vim.fn.append(0, '#include <stdio.h>')
    end
end

-- TODO: refactor this function
local function escape_double_quotes(text)
    return text:gsub([["]], [[\"]])
end

require('custom').nnoremap('é', '<cmd>ClangdSwitchSourceHeader<cr>', {buffer = true})
vim.o.commentstring='//%s'

require('custom').register_printing({
    print_var = function(var_name)
        add_stdio()
        return [[fprintf(stderr, "%s = %d\n", "]] .. escape_double_quotes(var_name) .. [[", ]] .. var_name .. [[);]]
    end,
    print_text = function(text)
        add_stdio()
        return [[fprintf(stderr, "%s\n", ]] .. escape_double_quotes(text) .. [[);]]
    end,
})
