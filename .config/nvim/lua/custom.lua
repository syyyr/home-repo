Custom = {}

function Custom.map(table, f)
    local new_table = {}
    for i, v in pairs(table) do
        new_table[i] = f(v)
    end
    return new_table
end

function Custom.statusline_diagnostics()
    for _, severity in pairs({"ERROR", "WARN", "INFO", "HINT"}) do
        local diagnostic = vim.diagnostic.get(0, {severity = vim.diagnostic.severity[severity]})[1]
        if diagnostic then
            return severity:sub(1, 1) .. ': ln ' .. diagnostic.lnum + 1
        end
    end
    if vim.b.TrailingNr and vim.b.TrailingNr ~= '' and vim.api.nvim_get_mode() ~= 'i' then
        return 'WS: ln ' .. vim.b.TrailingNr
    end

    return ' ' -- Have to return something here, otherwise padding won't be applied.
end

function Custom.clean_screen()
    vim.fn['clever_f#reset']()
    vim.cmd([[execute "normal \<c-space>\<c-space>\<c-space>q"]])
    vim.g.skip_diagnostic_float = true
end

local function print_variable(var_name, prefix, infix, suffix, callback, quote)
    if callback then
        callback()
    end
    vim.cmd('normal! o' .. prefix .. quote .. var_name .. quote .. infix .. var_name .. suffix)
end

local function print_text(text, prefix, suffix, callback, quote)
    if callback then
        callback()
    end
    vim.cmd('normal! o' .. prefix .. quote .. text .. quote .. suffix)
end

function Custom.register_printing(opts)
    vim.api.nvim_create_user_command('Print', function(info)
        if info.bang then
            print_text(info.args, opts.prefix, opts.text_suffix or opts.suffix, opts.callback, opts.quote)
        else
            print_variable(info.args, opts.prefix, opts.infix, opts.var_suffix or opts.suffix, opts.callback, opts.quote)
        end
    end, {nargs = 1, bang = true})

    if opts.no_printthis then
        return
    end

    vim.api.nvim_create_user_command('Printthis', function(info)
        local line = vim.api.nvim_get_current_line()
        line = line:gsub('^%s*', '')
        if line:sub(-1, -1) == ';' then
            line = line:sub(1, -2)
        end

        print_variable(line, opts.prefix, opts.infix, opts.var_suffix or opts.suffix, opts.callback, opts.quote)
        if info.bang then
            vim.cmd('normal! k"_dd')
        end
    end, {nargs = 0, bang = true})

end

local impl_map = function(mode, noremap, lhs, rhs, opts)
    if not opts then
        opts = {}
    end

    opts.noremap = noremap

    vim.keymap.set(mode, lhs, rhs, opts)
end

function Custom.nnoremap(lhs, rhs, opts) impl_map('n', true, lhs, rhs, opts) end
function Custom.xnoremap(lhs, rhs, opts) impl_map('x', true, lhs, rhs, opts) end
function Custom.onoremap(lhs, rhs, opts) impl_map('o', true, lhs, rhs, opts) end
function Custom.omap(lhs, rhs, opts) impl_map('o', false, lhs, rhs, opts) end
function Custom.inoremap(lhs, rhs, opts) impl_map('i', true, lhs, rhs, opts) end
function Custom.inoremap(lhs, rhs, opts) impl_map('i', true, lhs, rhs, opts) end
function Custom.cnoremap(lhs, rhs, opts) impl_map('c', true, lhs, rhs, opts) end
function Custom.tnoremap(lhs, rhs, opts) impl_map('t', true, lhs, rhs, opts) end
function Custom.noremap(lhs, rhs, opts) impl_map('', true, lhs, rhs, opts) end
function Custom.nmap(lhs, rhs, opts) impl_map('', false, lhs, rhs, opts) end
