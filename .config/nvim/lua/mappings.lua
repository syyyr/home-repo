local syyyr = require('syyyr')
syyyr.nnoremap('Y', 'y$')

syyyr.nnoremap('j', 'gj')
syyyr.nnoremap('k', 'gk')
syyyr.nnoremap('H', '^')
syyyr.nnoremap('L', '$')
syyyr.onoremap('H', '^')
syyyr.onoremap('L', '$')
syyyr.xnoremap('H', '^')
syyyr.xnoremap('L', 'g_')

syyyr.nnoremap('<a-w>', '<cmd>update!<cr>')

syyyr.nnoremap('<space>', '/')
syyyr.xnoremap('<space>', '/')

-- Jump to next merge conflict
syyyr.nnoremap('<a-c>', [[<cmd>silent! keeppatterns /\v^[<|=>]{7}([^=].+)?$<cr><cmd>nohlsearch<cr>]])
syyyr.xnoremap('<a-c>', [[/<c-U>\v^[<|=>]{7}([^=].+)?$<cr><esc><cmd>nohlsearch<cr>gv]])
syyyr.onoremap('<a-c>', [[/<c-U>\v^[<|=>]{7}([^=].+)?$<cr>]])

syyyr.nnoremap('<c-j>', '<c-W>j')
syyyr.nnoremap('<c-k>', '<c-W>k')
syyyr.nnoremap('<c-h>', '<c-W>h')
syyyr.nnoremap('<c-l>', '<c-W>l')

syyyr.nnoremap('<c-q>', '<cmd>qa<cr>')

syyyr.inoremap('<c-j>', '<down>')
syyyr.inoremap('<c-k>', '<up>')
syyyr.inoremap('<c-h>', '<left>')
syyyr.inoremap('<c-l>', '<right>')

syyyr.nnoremap('<a-n>', '<cmd>setlocal number!<cr>')

syyyr.nnoremap('<a-b>', '<cmd>let &background = ( &background == "dark"? "light" : "dark" )<cr>')

syyyr.nnoremap('<a-d>', ':bdelete<cr>')
syyyr.nnoremap('<a-h>', ':bprevious<cr>')
syyyr.nnoremap('<a-l>', ':bnext<cr>')

-- Move lines with alt+j,k
syyyr.nnoremap('<a-j>', 'mz<cmd>m+<cr>`z')
syyyr.nnoremap('<a-k>', 'mz<cmd>m-2<cr>`z')
syyyr.xnoremap('<a-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]])
syyyr.xnoremap('<a-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]])

syyyr.nnoremap('<a-;>', 'gt')
syyyr.nnoremap('<a-+>', '1gt')
syyyr.nnoremap('<a-ě>', '2gt')
syyyr.nnoremap('<a-š>', '3gt')
syyyr.nnoremap('<a-č>', '4gt')
syyyr.nnoremap('<a-ř>', '5gt')
syyyr.nnoremap('<a-ž>', '6gt')
syyyr.nnoremap('<a-ý>', '7gt')
syyyr.nnoremap('<a-á>', '8gt')
syyyr.nnoremap('<a-í>', '9gt')
syyyr.nnoremap('<a-é>', '<cmd>tablast<cr>')

syyyr.nnoremap('<left>', ':vertical resize -2<cr>')
syyyr.nnoremap('<right>', ':vertical resize +2<cr>')
syyyr.nnoremap('<s-left>', ':vertical resize -4<cr>')
syyyr.nnoremap('<s-right>', ':vertical resize +4<cr>')

-- Underscore text-object
syyyr.xnoremap('i_', ':<c-u>normal! T_vt_<cr>')
syyyr.onoremap('i_', '<cmd>normal vi_<cr>')

-- Buffer text-object
syyyr.xnoremap('i%', 'GoggV')
syyyr.omap('i%', '<cmd>normal vi%<cr>')

-- Auto complete brace
syyyr.inoremap('{<cr>', '{<cr>}<Esc>O')

-- insert current line in cmd mode
syyyr.cnoremap('<c-r><c-l>', [[<c-r>=getline('.')<cr>]])

syyyr.nnoremap('<f7>', '<nop>')
syyyr.inoremap('<f7>', '<nop>')
syyyr.cnoremap('<f7>', '<nop>')

-- Remain in visual after shift
syyyr.xnoremap('>', '>gv')
syyyr.xnoremap('<', '<gv')

-- Don't jump after identifier search
syyyr.nnoremap('*', '*N')
syyyr.nnoremap('#', '#N')

syyyr.nnoremap('<c-p>', '"0p')
syyyr.xnoremap('<c-p>', '"0p')

syyyr.tnoremap('<esc>', '<c-><c-N>')

syyyr.nnoremap('q:', '<nop>')
syyyr.cnoremap('CR', 'CR ')

syyyr.nmap('úc', '<cmd>cprev<cr>')
syyyr.nmap(')c', '<cmd>cnext<cr>')
syyyr.nmap('úd', function() vim.diagnostic.jump({count = -1}) end)
syyyr.nmap(')d', function() vim.diagnostic.jump({count = 1}) end)

syyyr.nmap('<a-f>', '<cmd>CF<cr>')

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })
        vim.bo[ev.buf].formatexpr = nil
    end,
})

-- Reset highlighting, floating windows etc.
syyyr.nnoremap('<a-cr>', function()
    vim.fn['clever_f#reset']()
    vim.b.skip_diagnostic_float = true
    syyyr.close_float()
    vim.cmd('nohlsearch')
    vim.notify('')
end)
