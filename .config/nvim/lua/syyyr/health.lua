local M = {}

M.check = function()
    vim.health.start("config check")
    local handle = io.popen([[luacheck --no-color -q "$HOME/.config/nvim" | grep --color=auto -v 'Total:']])
    if (not handle) then
        vim.health.error("Couldn't run luacheck")
        return
    end
    local output = handle:read("*a")
    vim.notify(output)
    if (output ~= '') then
        vim.health.error(output)
    else
        vim.health.ok("luacheck: no errors")
    end

end

return M

