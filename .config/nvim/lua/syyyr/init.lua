local M = {}

function M.filter(input, f)
    local new_table = {}
    for i, v in pairs(input) do
        if f(v) then
            if type(i) == "number" then
                table.insert(new_table, v)
            else
                new_table[i] = v
            end
        end
    end
    return new_table
end

function M.map(table, f)
    local new_table = {}
    for i, v in pairs(table) do
        new_table[i] = f(v)
    end
    return new_table
end

function M.all(table, f)
    for _, v in pairs(table) do
        if not f(v) then
            return false
        end
    end

    return true
end

function M.escape_double_quotes(text)
    return text:gsub([["]], [[\"]])
end

function M.none(table, f)
    return M.all(table, function(elem)
        return not f(elem)
    end)
end

local function format_statusline_diagnostics(type, lnum)
    return string.format('%s: ln %s', type, lnum)
end

function M.statusline_diagnostics()
    for _, severity in pairs({"ERROR", "WARN", "INFO", "HINT"}) do
        local diagnostic = vim.diagnostic.get(0, {severity = vim.diagnostic.severity[severity]})[1]
        if diagnostic then
            return format_statusline_diagnostics(severity:sub(1, 1), diagnostic.lnum + 1)
        end
    end
    if vim.b.TrailingNr and vim.b.TrailingNr ~= '' and vim.api.nvim_get_mode() ~= 'i' then
        return format_statusline_diagnostics('WS', vim.b.TrailingNr)
    end

    return ' ' -- Have to return something here, otherwise padding won't be applied.
end

local function print_something(what)
    vim.cmd('normal! o' .. what)
    vim.cmd('normal! ^')
end

function M.register_printing(opts)
    vim.api.nvim_buf_create_user_command(0, 'Print', function(info)
        print_something(info.bang and opts.print_text(info.args) or opts.print_var(info.args))
    end, {nargs = 1, bang = true})

    if opts.no_printthis then
        return
    end

    vim.api.nvim_buf_create_user_command(0, 'Printthis', function(info)
        local to_print = vim.api.nvim_get_current_line()
        to_print = to_print:gsub('^%s*', '')
        if to_print:sub(-1, -1) == ';' then
            to_print = to_print:sub(1, -2)
        end

        print_something(opts.print_var(to_print))
        if info.bang then
            vim.cmd('normal! k"_dd')
        end
    end, {nargs = 0, bang = true})

end

local function impl_map(mode, noremap, lhs, rhs, opts)
    if not opts then
        opts = {}
    end

    opts.noremap = noremap

    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.nnoremap(lhs, rhs, opts) impl_map('n', true, lhs, rhs, opts) end
function M.xnoremap(lhs, rhs, opts) impl_map('x', true, lhs, rhs, opts) end
function M.onoremap(lhs, rhs, opts) impl_map('o', true, lhs, rhs, opts) end
function M.inoremap(lhs, rhs, opts) impl_map('i', true, lhs, rhs, opts) end
function M.cnoremap(lhs, rhs, opts) impl_map('c', true, lhs, rhs, opts) end
function M.tnoremap(lhs, rhs, opts) impl_map('t', true, lhs, rhs, opts) end
function M.noremap(lhs, rhs, opts) impl_map('', true, lhs, rhs, opts) end
function M.omap(lhs, rhs, opts) impl_map('o', false, lhs, rhs, opts) end
function M.nmap(lhs, rhs, opts) impl_map('', false, lhs, rhs, opts) end

return M