vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.qml,*.qml.in',
    callback = function() vim.bo.filetype = 'qml' end,
    group = vim.api.nvim_create_augroup('QmlDetection', {clear = true})
})
