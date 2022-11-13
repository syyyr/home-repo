local function print_variable(var_name, prefix, infix, suffix, callback)
    callback()
    vim.cmd('normal! o' .. prefix .. var_name .. infix .. var_name .. suffix)
end

local function print_text(text, prefix, suffix, callback)
    callback()
    vim.cmd('normal! o' .. prefix .. text .. suffix)
end

local function add_iostream()
    if vim.fn.search('iostream', 'nw') == 0 then
        vim.fn.append(0, '#include <iostream>')
    end
end

vim.api.nvim_create_user_command('Print', function(info)
    if info.bang then
        print_text(info.args, 'std::cerr << "', '" << "\\n";', add_iostream)
    else
        print_variable(info.args, 'std::cerr << "', '" << " = " << ', ' << "\\n";', add_iostream)
    end
end, {nargs = 1, bang = true})

vim.api.nvim_create_user_command('Printthis', function(info)
    add_iostream()
    local line = vim.api.nvim_get_current_line()
    line = line:gsub('^%s*', '')
    if line:sub(-1, -1) == ';' then
        line = line:sub(1, -2)
    end
    print_variable(line, 'std::cerr << "', '" << " = " << ', ' << "\\n";', add_iostream)
    if info.bang then
        vim.cmd('normal! k"_dd')
    end
end, {bang = true})

vim.cmd([[iabbrev <buffer> DOCSUB DOCTEST_SUBCASE("")<Left><Left>]])
vim.o.cinoptions='j1,(0,ws,Ws,:0,l1,N-s,E-s'
