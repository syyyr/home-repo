local skeleton_group = vim.api.nvim_create_augroup('Skeletons', {clear = true})
---@param pattern string
---@param text string
---@param start_line integer
local function add_skeleton(pattern, text, start_line)
    local lines = {}
    for line in text:gmatch('[^\n]*[\n]') do
        table.insert(lines, line:sub(0, #line - 1))
    end
    vim.api.nvim_create_autocmd('BufNewFile', {
        pattern = pattern,
        callback = function()
            vim.api.nvim_buf_set_text(0, 0, 0, 0, 0, lines)
            vim.fn.cursor({start_line, 1})
            vim.fn.feedkeys('o')
        end,
        group = skeleton_group
    })
end

add_skeleton('main.c,main.cpp', [[
int main(int argc, char* argv[])
{
    return 0;
}
]], 2)

add_skeleton('main.rs', [[
fn main()
{
}
]], 2)

add_skeleton('index.html', [[
<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
<title>Page Title</title>
<meta name="viewport" content="width=device-widthinitial-scale=1">,
<link rel="stylesheet" href="style.css">
<style>
</style>
<body>
    <script src="index.js"></script>
</body>
</html>
]], 10)

add_skeleton('*.bash', [[
#!/bin/bash
set -euo pipefail
shopt -s inherit_errexit

]], 4)
