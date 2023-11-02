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
vim.api.nvim_create_user_command('DiffToggle', function()
    if not vim.b.scratch_bufname then
        local file_name = vim.fn.expand('%')--[[@as string]]
        if file_name == '' then
            vim.notify('DiffToggle: Empty file name.')
            return
        end
        if vim.fn.filereadable(file_name) == 0 then
            vim.notify("DiffToggle: File doesn't exist (or can't be opened).")
            return
        end
        local scratch_bufname = 'disk:' .. vim.fn.expand('%')
        vim.b.scratch_bufname = scratch_bufname
        vim.cmd('vert new')
        vim.b.scratch_bufname = scratch_bufname
        vim.cmd('file ' .. vim.b.scratch_bufname)
        vim.o.buftype = 'nofile'
        vim.cmd('read #')
        vim.cmd('0delete_')
        vim.cmd('diffthis')
        vim.cmd('wincmd p')
        vim.cmd('diffthis')
    else
        vim.cmd('diffoff')
        vim.cmd('bdelete ' .. vim.b.scratch_bufname)
        vim.b.scratch_bufname = nil
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

vim.api.nvim_create_user_command('SetMakePath', function(info)
    vim.o.makeprg = 'make -C ' .. info.args
end, { nargs = 1 })

vim.api.nvim_create_user_command('CS', function(info)
    vim.lsp.buf.workspace_symbol(info.args ~= '' and info.args or vim.fn.expand('<cword>')--[[@as string]])
end, { nargs = '?' })
