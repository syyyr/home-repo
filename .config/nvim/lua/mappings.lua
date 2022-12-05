-- idk why it's NotLikeThis
Custom.nnoremap('Y', 'y$')

-- sane line movement
Custom.nnoremap('j', 'gj')
Custom.nnoremap('k', 'gk')
Custom.nnoremap('H', '^')
Custom.nnoremap('L', '$')
Custom.onoremap('H', '^')
Custom.onoremap('L', '$')
Custom.xnoremap('H', '^')
Custom.xnoremap('L', 'g_')

-- Fast saving. :update only saves if there are changes (it can't be used to
-- just update modified time)
Custom.nnoremap('<a-w>', '<cmd>update!<cr>')

-- searching with space
Custom.nnoremap('<space>', '/')
Custom.xnoremap('<space>', '/')

-- disable highlight
Custom.nnoremap('<a-cr>',function ()
    vim.fn['clever_f#reset']()
    vim.g.skip_diagnostic_float = true
    if vim.g.float_win_id then
        pcall(vim.api.nvim_win_close, vim.g.float_win_id, false) -- discard errors: the window might be already closed
        vim.g.float_win_id = nil
    end
    vim.cmd('nohlsearch')
    vim.notify('')
end)

-- jump to next merge conflict
Custom.nnoremap('<a-c>', [[<cmd>silent! keeppatterns /\v^[<|=>]{7}([^=].+)?$<cr><cmd>nohlsearch<cr>]])
Custom.xnoremap('<a-c>', [[/<c-U>\v^[<|=>]{7}([^=].+)?$<cr><esc><cmd>nohlsearch<cr>gv]])
Custom.onoremap('<a-c>', [[/<c-U>\v^[<|=>]{7}([^=].+)?$<cr>]])

-- smart way to move between windows
Custom.nnoremap('<c-j>', '<c-W>j')
Custom.nnoremap('<c-k>', '<c-W>k')
Custom.nnoremap('<c-h>', '<c-W>h')
Custom.nnoremap('<c-l>', '<c-W>l')

-- close everything with C-q
Custom.nnoremap('<c-q>', '<cmd>qa<cr>')

-- ability to move with hjkl in insert mode
Custom.inoremap('<c-j>', '<down>')
Custom.inoremap('<c-k>', '<up>')
Custom.inoremap('<c-h>', '<left>')
Custom.inoremap('<c-l>', '<right>')

-- toggle linenumbers
Custom.nnoremap('<a-n>', '<cmd>setlocal number!<cr>')

-- toggle dark/light bg
Custom.nnoremap('<a-b>', '<cmd>let &background = ( &background == "dark"? "light" : "dark" )<cr>')

-- buffer management
Custom.nnoremap('<a-d>', ':bdelete<cr>')
Custom.nnoremap('<a-h>', ':bprevious<cr>')
Custom.nnoremap('<a-l>', ':bnext<cr>')

-- move lines with alt+j,k
Custom.nnoremap('<a-j>', 'mz<cmd>m+<cr>`z')
Custom.nnoremap('<a-k>', 'mz<cmd>m-2<cr>`z')
Custom.xnoremap('<a-j>', [[:m'>+<cr>`<my`>mzgv`yo`z]])
Custom.xnoremap('<a-k>', [[:m'<-2<cr>`>my`<mzgv`yo`z]])

-- tabs
Custom.nnoremap('<a-;>', 'gt')
Custom.nnoremap('<a-+>', '1gt')
Custom.nnoremap('<a-ě>', '2gt')
Custom.nnoremap('<a-š>', '3gt')
Custom.nnoremap('<a-č>', '4gt')
Custom.nnoremap('<a-ř>', '5gt')
Custom.nnoremap('<a-ž>', '6gt')
Custom.nnoremap('<a-ý>', '7gt')
Custom.nnoremap('<a-á>', '8gt')
Custom.nnoremap('<a-í>', '9gt')
Custom.nnoremap('<a-é>', '<cmd>tablast<cr>')

-- map LR arrows to resize, but keep UD arrows for scrolling
Custom.nnoremap('<left>', ':vertical resize -2<cr>')
Custom.nnoremap('<right>', ':vertical resize +2<cr>')
Custom.nnoremap('<s-left>', ':vertical resize -4<cr>')
Custom.nnoremap('<s-right>', ':vertical resize +4<cr>')

-- underscore text object
Custom.xnoremap('i_', ':<c-u>normal! T_vt_<cr>')
Custom.onoremap('i_', '<cmd>normal vi_<cr>')

-- buffer text-object
Custom.xnoremap('i%', 'GoggV')
Custom.omap('i%', '<cmd><c-u>normal vi%<cr>')

-- auto complete brace
Custom.inoremap('{<cr>', '{<cr>}<Esc>O')

-- insert current line in cmd mode
Custom.cnoremap('<c-r><c-l>', [[<c-r>=getline('.')<cr>]])

Custom.noremap('<f7>', '<nop>')
Custom.inoremap('<f7>', '<nop>')
Custom.cnoremap('<f7>', '<nop>')

Custom.nnoremap('<c-n>', '<cmd>20Lexplore<cr>')

-- remain in visual after shift
Custom.xnoremap('>', '>gv')
Custom.xnoremap('<', '<gv')

-- don't jump after identifier search
Custom.nnoremap('*', '*N')
Custom.nnoremap('#', '#N')

Custom.nnoremap('<c-p>', '"0p')
Custom.xnoremap('<c-p>', '"0p')

Custom.tnoremap('<esc>', '<c-><c-N>')

Custom.nnoremap('Q', '<nop>')

Custom.nnoremap('q:', '<nop>')
Custom.cnoremap('CR', 'CR ')

Custom.nmap('úc', '<cmd>cprev<cr>')
Custom.nmap(')c', '<cmd>cnext<cr>')
