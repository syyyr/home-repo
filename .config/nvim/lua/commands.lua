vim.api.nvim_create_user_command('Trailing', Custom.clean_extra_spaces, { nargs = 0 })
vim.api.nvim_set_keymap('n', '<A-t>', ':Trailing<cr>:nohlsearch<cr>', {noremap = true})

--" toggle unsaved changes diff
vim.api.nvim_create_user_command('DiffToggle', Custom.diff_toggle, { nargs = 0 })
vim.api.nvim_set_keymap('n', '<A-,>', '', {noremap = true, callback = Custom.diff_toggle })

--" end with :Q XD
vim.api.nvim_create_user_command('Q', function(info) vim.cmd('q' .. (info.bang and '!' or '')) end, { nargs = 0, bang = 1 })
vim.api.nvim_create_user_command('Qa', function(info) vim.cmd('qa' .. (info.bang and '!' or '')) end, { nargs = 0, bang = 1 })

vim.api.nvim_create_user_command('SynStack', function() vim.cmd([[echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')]]) end, { nargs = 0 })

vim.api.nvim_create_user_command('SetMakePath', function(info) vim.o.makeprg = 'make -C ' .. info.args end, { nargs = 1 })

vim.api.nvim_create_user_command('CS', function(info) vim.lsp.buf.workspace_symbol(info.args ~= '' and info.args or vim.fn.expand('<cword>')) end, { nargs = '?' })
