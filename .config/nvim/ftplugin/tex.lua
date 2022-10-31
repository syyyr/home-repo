-- automatically try to compile after saving (works with update)
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.tex',
    command = 'silent Make!',
    group = vim.api.nvim_create_augroup('CompilingTex', {clear = true})
})

vim.o.makeprg = 'make'

Custom.inoremap('\\tit', '\\textit{', {buffer = true})
Custom.inoremap('\\ttt', '\\texttt{', {buffer = true})
Custom.inoremap('""', '\\uv{', {buffer = true})
Custom.inoremap('C++', '\\Cpp{}', {buffer = true})
Custom.inoremap('\\fn', '\\footnote{', {buffer = true})
Custom.inoremap('\\v', '\\verb¨', {buffer = true})

vim.opt.diffopt:append('horizontal')

-- I don't want the global mapping in Tex files
Custom.inoremap('{', '{', {buffer = true, nowait = true})
