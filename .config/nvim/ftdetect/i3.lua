vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '~/.config/i3/*',
    callback = function() vim.bo.filetype = 'i3config' end,
    group = vim.api.nvim_create_augroup('i3configDetection', {clear = true})
})
