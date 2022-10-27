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

    return ''
end
