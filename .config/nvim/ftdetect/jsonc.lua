local jsonc_detection = vim.api.nvim_create_augroup('JsoncDetection', {clear = true})
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = 'tsconfig.json,*.cjson ',
    callback = function () vim.bo.filetype = 'jsonc' end,
    group = jsonc_detection
})
