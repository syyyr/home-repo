vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.tab',
    callback = function () vim.bo.filetype = 'tab' end,
    group = vim.api.nvim_create_augroup('TabDetection', {clear = true})
})
