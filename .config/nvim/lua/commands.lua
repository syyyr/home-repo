vim.api.nvim_create_user_command('Trailing', Custom.clean_extra_spaces, { nargs = 0 })
vim.api.nvim_set_keymap('n', '<A-t>', ':Trailing<cr>:nohlsearch<cr>', {noremap = true})

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

Custom.nnoremap('<A-,>', '<cmd>DiffToggle<cr>')

--" end with :Q XD
vim.api.nvim_create_user_command('Q', function(info) vim.cmd('q' .. (info.bang and '!' or '')) end, { nargs = 0, bang = 1 })
vim.api.nvim_create_user_command('Qa', function(info) vim.cmd('qa' .. (info.bang and '!' or '')) end, { nargs = 0, bang = 1 })

vim.api.nvim_create_user_command('SynStack', function() vim.cmd([[echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')]]) end, { nargs = 0 })

vim.api.nvim_create_user_command('SetMakePath', function(info) vim.o.makeprg = 'make -C ' .. info.args end, { nargs = 1 })

vim.api.nvim_create_user_command('CS', function(info) vim.lsp.buf.workspace_symbol(info.args ~= '' and info.args or vim.fn.expand('<cword>')) end, { nargs = '?' })
