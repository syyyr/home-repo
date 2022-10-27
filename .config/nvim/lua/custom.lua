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
