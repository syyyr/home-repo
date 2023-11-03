local skeletons = vim.api.nvim_create_augroup('Skeletons', {clear = true})
local function add_skeleton(filenames, lines, start_line)
    vim.api.nvim_create_autocmd('BufNewFile', {
        pattern = filenames,
        callback = function()
            vim.api.nvim_buf_set_text(0, 0, 0, 0, 0, lines)
            vim.fn.cursor({start_line, 1})
            vim.fn.feedkeys('o')
        end,
        group = skeletons
    })
end

add_skeleton('main.c,main.cpp', {
    'int main(int argc, char* argv[])',
    '{',
    '    return 0;',
    '}'
}, 2)

add_skeleton('main.rs', {
    'fn main()',
    '{',
    '}'
}, 2)

add_skeleton('index.html', {
    '<!DOCTYPE html>',
    '<html lang="en">',
    '<meta charset="UTF-8">',
    '<title>Page Title</title>',
    '<meta name="viewport" content="width=device-width,initial-scale=1">',
    '<link rel="stylesheet" href="style.css">',
    '<style>',
    '</style>',
    '<body>',
    '    <script src="index.js"></script>',
    '</body>',
    '</html>'
}, 10)
