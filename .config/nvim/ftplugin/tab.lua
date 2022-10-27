local get_char_under_cursor = function ()
    local column = vim.fn.col('.')
    return vim.fn.getline('.'):sub(column, column)
end
local callback =  function(i)
    return function ()
        if get_char_under_cursor() == '-' then
            return 'r' .. i .. ''
        else
            return 'ciw' .. i .. ''
        end
    end
end
for i = 0, 9 do
    Custom.nnoremap(tostring(i), '', { buffer = true, expr = true, callback = callback(i)})
end

Custom.nnoremap('-', '', { buffer = true, expr = true, callback = callback('-')})
Custom.nnoremap('<C-A>', '<C-X>', {buffer = true})
Custom.nnoremap('<C-X>', '<C-A>', {buffer = true})
Custom.nnoremap('t', 'rt', {buffer = true})
Custom.nnoremap('b', '?\\d\\+<cr>:nohl<cr>', {buffer = true})
Custom.nnoremap('w', '/\\d\\+<cr>:nohl<cr>', {buffer = true})
Custom.nnoremap('H', '0/\\d\\+<cr>:nohl<cr>', {buffer = true})
Custom.nnoremap('L', '$?\\d\\+<cr>:nohl<cr>', {buffer = true})
