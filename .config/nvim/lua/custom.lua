Custom = {}

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

local function parse_ws_grep(_, data)
    local first_line = data[1]
    local startIndex, endIndex = first_line:find('%d+')
    if not startIndex then
        vim.b.TrailingNr = ''
    else
        vim.b.TrailingNr = first_line:sub(startIndex, endIndex)
    end
end

function Custom.trailing_ws_check()
    local id = vim.fn.jobstart({'grep', '-n', '-m', '1', '\\s$'}, {
        on_stdout = parse_ws_grep,
        stdout_buffered = 1
    })
    vim.fn.chansend(id, vim.api.nvim_buf_get_lines(0, 0, -1, true))
    vim.fn.chanclose(id, 'stdin')
end

local diff_open = false

function Custom.diff_toggle()
    if not diff_open then
        diff_open = true
        if vim.o.diffopt == 'horizontal' then
            vim.cmd('new')
        else
            vim.cmd('vert new')
        end
        vim.cmd('file scratch')
        vim.o.buftype = 'nofile'
        vim.cmd('read #')
        vim.cmd('0delete_')
        vim.cmd('diffthis')
        vim.cmd('wincmd p')
        vim.cmd('diffthis')
    else
        diff_open = false
        vim.cmd('diffoff')
        vim.cmd('bdelete scratch')
    end
end

function Custom.clean_screen()
    vim.fn['clever_f#reset']()
    vim.cmd([[execute "normal \<C-Space>\<C-Space>\<C-Space>q"]])
end

function Custom.clean_extra_spaces()
    local save_cursor = vim.fn.getpos('.')
    local old_query = vim.fn.getreg('/')
    vim.cmd('silent! %s/\\s\\+$//e')
    vim.fn.setpos('.', save_cursor)
    vim.fn.setreg('/', old_query)
end
