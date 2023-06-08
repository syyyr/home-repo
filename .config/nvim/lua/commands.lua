local syyyr = require('syyyr')
vim.api.nvim_create_user_command('Trailing', function()
    local save_cursor = vim.fn.getpos('.')
    local old_query = vim.fn.getreg('/')
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
    vim.fn.setreg('/', old_query)
end, { nargs = 0 })
syyyr.nnoremap('<a-t>', '<cmd>Trailing<cr><cmd>nohlsearch<cr>')

--" toggle unsaved changes diff
local diff_open = false
vim.api.nvim_create_user_command('DiffToggle', function()
    if not diff_open then
        diff_open = true
        if vim.o.diffopt == 'horizontal' then
            vim.cmd('new')
        else
            vim.cmd('vert new')
        end
        vim.cmd('file scratch')
        vim.o.buftype = 'nofile'
        vim.cmd('read #')
        vim.cmd('0delete_')
        vim.cmd('diffthis')
        vim.cmd('wincmd p')
        vim.cmd('diffthis')
    else
        diff_open = false
        vim.cmd('diffoff')
        vim.cmd('bdelete scratch')
    end
end, { nargs = 0 })

syyyr.nnoremap('<a-,>', '<cmd>DiffToggle<cr>')

--" end with :Q XD
vim.api.nvim_create_user_command('Q', function(info)
    vim.cmd('q' .. (info.bang and '!' or ''))
end, { nargs = 0, bang = 1 })

vim.api.nvim_create_user_command('Qa', function(info)
    vim.cmd('qa' .. (info.bang and '!' or ''))
end, { nargs = 0, bang = 1 })

vim.api.nvim_create_user_command('SynStack', function()
    print(vim.inspect(syyyr.map(vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.')), function(id)
        return vim.fn.synIDattr(id, 'name')
    end)))
end, { nargs = 0 })

vim.api.nvim_create_user_command('SetMakePath', function(info)
    vim.o.makeprg = 'make -C ' .. info.args
end, { nargs = 1 })

vim.api.nvim_create_user_command('CS', function(info)
    vim.lsp.buf.workspace_symbol(info.args ~= '' and info.args or vim.fn.expand('<cword>'))
end, { nargs = '?' })
