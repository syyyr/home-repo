vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.cpon,eyassrv*.conf',
    callback = function() vim.bo.filetype = 'cpon' end,
    group = vim.api.nvim_create_augroup('CponDetection', {clear = true})
})
