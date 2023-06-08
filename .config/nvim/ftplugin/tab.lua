local syyyr = require('syyyr')
local get_char_under_cursor = function()
    local column = vim.fn.col('.')
    return vim.fn.getline('.'):sub(column, column)
end
local callback =  function(i)
    return function()
        if get_char_under_cursor() == '-' then
            return 'r' .. i .. ''
        else
            return 'ciw' .. i .. ''
        end
    end
end
for i = 0, 9 do
    syyyr.nnoremap(tostring(i), '', { buffer = true, expr = true, callback = callback(i)})
end

syyyr.nnoremap('-', '', { buffer = true, expr = true, callback = callback('-')})
syyyr.nnoremap('<C-A>', '<C-X>', {buffer = true})
syyyr.nnoremap('<C-X>', '<C-A>', {buffer = true})
syyyr.nnoremap('t', 'rt', {buffer = true})
syyyr.nnoremap('H', [[0/\d\+<cr><cmd>nohl<cr>]], {buffer = true})
syyyr.nnoremap('L', [[$?\d\+<cr><cmd>nohl<cr>]], {buffer = true})
