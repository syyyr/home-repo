local Custom = {}

function Custom.filter(input, f)
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

function Custom.map(table, f)
    local new_table = {}
    for i, v in pairs(table) do
        new_table[i] = f(v)
    end
    return new_table
end

function Custom.all(table, f)
    for _, v in pairs(table) do
        if not f(v) then
            return false
        end
    end

    return true
end

function Custom.none(table, f)
    for _, v in pairs(table) do
        if f(v) then
            return false
        end
    end

    return true
end

local function format_statusline_diagnostics(type, lnum)
    return string.format('%s: ln %s', type, lnum)
end

function Custom.statusline_diagnostics()
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

local function print_something(opts)
    if opts.callback then
        opts.callback()
    end

    local to_print =
        opts.print_infix
        and opts.prefix .. opts.quote .. opts.text .. opts.quote .. opts.infix .. opts.text .. opts.var_suffix .. opts.suffix
        or opts.prefix .. opts.quote .. opts.text .. opts.quote .. opts.suffix

    vim.cmd('normal! o' .. to_print)
    vim.cmd('normal! ^')
end

function Custom.register_printing(opts)
    opts.var_suffix = opts.var_suffix or ''
    vim.api.nvim_create_user_command('Print', function(info)
        if info.bang then
            opts.print_infix = false
        else
            opts.print_infix = true
        end

        opts.text = info.args
        print_something(opts)
    end, {nargs = 1, bang = true})

    if opts.no_printthis then
        return
    end

    vim.api.nvim_create_user_command('Printthis', function(info)
        opts.text = vim.api.nvim_get_current_line()
        opts.text = opts.text:gsub('^%s*', '')
        if opts.text:sub(-1, -1) == ';' then
            opts.text = opts.text:sub(1, -2)
        end

        opts.print_infix = true
        print_something(opts)
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

function Custom.nnoremap(lhs, rhs, opts) impl_map('n', true, lhs, rhs, opts) end
function Custom.xnoremap(lhs, rhs, opts) impl_map('x', true, lhs, rhs, opts) end
function Custom.onoremap(lhs, rhs, opts) impl_map('o', true, lhs, rhs, opts) end
function Custom.inoremap(lhs, rhs, opts) impl_map('i', true, lhs, rhs, opts) end
function Custom.cnoremap(lhs, rhs, opts) impl_map('c', true, lhs, rhs, opts) end
function Custom.tnoremap(lhs, rhs, opts) impl_map('t', true, lhs, rhs, opts) end
function Custom.noremap(lhs, rhs, opts) impl_map('', true, lhs, rhs, opts) end
function Custom.omap(lhs, rhs, opts) impl_map('o', false, lhs, rhs, opts) end
function Custom.nmap(lhs, rhs, opts) impl_map('', false, lhs, rhs, opts) end

return Custom
