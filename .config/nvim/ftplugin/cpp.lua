local function add_iostream()
    if vim.fn.search('iostream', 'nw') == 0 then
        vim.fn.append(0, '#include <iostream>')
    end
end

local function add_thread()
    if vim.fn.search('<thread>', 'nw') == 0 then
        vim.fn.append(0, '#include <thread>')
    end
end

local syyyr = require('syyyr')

local function have_qt()
    return vim.iter({'#include <Q', 'QString', 'QDateTime'}):any(function(needle)
        return vim.fn.search(needle, 'nw') ~= 0
    end)
end

local function get_stream()
    if have_qt() then
        return 'qDebug().noquote()'
    else
        add_iostream()
        return 'std::cerr'
    end
end

syyyr.register_printing({
    print_var = function(var_name)
        return get_stream() .. [[ << "]] .. syyyr.escape_double_quotes(var_name) .. (have_qt() and [[" << "=" << ]] or [[" << " = " << ]]) .. var_name .. (have_qt() and ";" or [[ << "\n";]])
    end,
    print_text = function(text)
        return get_stream() .. [[ << "]] .. syyyr.escape_double_quotes(text) .. (have_qt() and [[";]] or [[\n";]])
    end,
})

vim.api.nvim_buf_create_user_command(0, 'Sleep', function(info)
    add_thread()
    vim.cmd.normal({args = {'ostd::this_thread::sleep_for(std::chrono::seconds(' .. info.args .. '));'}, bang = true})
end, { nargs = 1 })

vim.cmd([[iabbrev <buffer> DOCSUB DOCTEST_SUBCASE("")<Left><Left>]])
vim.opt.cinoptions = {'j1', '(0', 'ws', 'Ws', ':0', 'l1', 'N-s', 'E-s'}

local clazy_namespace_id = require('null-ls.diagnostics').get_namespace(require('null-ls.sources').get('clazy')[1].id)
vim.api.nvim_create_autocmd({'TextChanged', 'TextChangedI'}, {
    callback = function()
        vim.diagnostic.reset(clazy_namespace_id)
    end,
    group = vim.api.nvim_create_augroup('CppResetClazy', {clear = true})
})
