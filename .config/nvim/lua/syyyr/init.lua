---@class syyyr
local M = {}

---@param text string
---@return string
function M.escape_double_quotes(text)
    local ret, _ = text:gsub([["]], [[\"]])
    return ret
end

---@param text string
---@return string
function M.escape_single_quotes(text)
    local ret, _ = text:gsub([[']], [[\']])
    return ret
end

---@param type string
---@param lnum string
---@return string
local function format_statusline_diagnostics(type, lnum)
    return string.format('%s: ln %s', type, lnum)
end

---@return string
function M.statusline_diagnostics()
    for _, severity in pairs({vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN, vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT}) do
        local diagnostic = vim.diagnostic.get(0, {severity = severity})[1]
        if diagnostic then
            return format_statusline_diagnostics(vim.diagnostic.severity[severity]:sub(1, 1), tostring(diagnostic.lnum + 1))
        end
    end
    return ' ' -- Have to return something here, otherwise padding won't be applied.
end

---@param what string
---@return nil
local function print_something(what)
    vim.cmd('normal! o' .. what)
    vim.cmd('normal! ^')
end

---@class PrintingConfig
---@field no_printthis? boolean
---@field print_text fun(text: string): string
---@field print_var fun(var_name: string): string

---@param opts PrintingConfig
---@return nil
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

---@return nil
function M.close_float()
    if vim.b.float_win_id then
        pcall(vim.api.nvim_win_close, vim.b.float_win_id, false) -- discard errors: the window might be already closed
        vim.b.float_win_id = nil
    end

    if vim.b.lsp_floating_preview then
        pcall(vim.api.nvim_win_close, vim.b.lsp_floating_preview, false) -- discard errors: the window might be already closed
    end

end

---@return nil
function M.diff_adjacent_args()
    local buffer_list = vim.api.nvim_list_bufs()
    local buffer_count = #buffer_list
    local current_buffer = 1
    while current_buffer < buffer_count do
        vim.cmd.buffer(buffer_list[current_buffer])
        vim.diagnostic.enable(false)
        vim.cmd.vsplit()
        vim.cmd.buffer(buffer_list[current_buffer] + 1)
        vim.cmd.windo('diffthis')
        current_buffer = current_buffer + 2
        if current_buffer < buffer_count then
            vim.cmd.tabnew()
        end
    end
    vim.cmd.tabfirst()
end

---@param mode string
---@param noremap boolean
---@param lhs string
---@param rhs string|function
---@param opts table|nil
local function impl_map(mode, noremap, lhs, rhs, opts)
    if not opts then
        opts = {}
    end

    opts.noremap = noremap

    vim.keymap.set(mode, lhs, rhs, opts)
end

---@alias MapFunction fun(lhs: string, rhs: string|function, opts: table|nil)

---@type MapFunction
function M.nnoremap(...) impl_map('n', true, ...) end
---@type MapFunction
function M.xnoremap(...) impl_map('x', true, ...) end
---@type MapFunction
function M.onoremap(...) impl_map('o', true, ...) end
---@type MapFunction
function M.inoremap(...) impl_map('i', true, ...) end
---@type MapFunction
function M.snoremap(...) impl_map('s', true, ...) end
---@type MapFunction
function M.cnoremap(...) impl_map('c', true, ...) end
---@type MapFunction
function M.tnoremap(...) impl_map('t', true, ...) end
---@type MapFunction
function M.omap(...) impl_map('o', false, ...) end
---@type MapFunction
function M.nmap(...) impl_map('', false, ...) end

local loaded_plugins = {}

---@param plugin_name string
---@param command_to_run string|function
function M.lazy_load(plugin_name, command_to_run)
  return function()
    if not loaded_plugins[plugin_name] then
      vim.cmd('packadd ' .. plugin_name)
      loaded_plugins[plugin_name] = true
    end

    if type(command_to_run) == 'function' then
      command_to_run()
    else
      vim.cmd(command_to_run)
    end
  end
end

return M
