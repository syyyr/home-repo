vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = 'tsconfig.json,*.cjson ',
    callback = function () vim.bo.filetype = 'jsonc' end,
    group = vim.api.nvim_create_augroup('JsoncDetection', {clear = true})
})
