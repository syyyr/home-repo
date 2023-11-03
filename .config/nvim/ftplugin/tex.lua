local syyyr = require('syyyr')
-- automatically try to compile after saving (works with update)
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.tex',
    command = 'silent Make!',
    group = vim.api.nvim_create_augroup('CompilingTex', {clear = true})
})

vim.opt.makeprg = 'make'

syyyr.inoremap([[\tit]], [[\textit{]], {buffer = true})
syyyr.inoremap([[\ttt]], [[\texttt{]], {buffer = true})
syyyr.inoremap('""', [[\uv{]], {buffer = true})
syyyr.inoremap('C++', [[\Cpp{}]], {buffer = true})
syyyr.inoremap([[\fn]], [[\footnote{]], {buffer = true})
syyyr.inoremap([[\v]], [[\verb¨]], {buffer = true})

vim.opt.diffopt:append('horizontal')

-- I don't want the global mapping in Tex files
syyyr.inoremap('{', '{', {buffer = true, nowait = true})
