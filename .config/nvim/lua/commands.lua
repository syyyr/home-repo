vim.api.nvim_create_user_command('Trailing', function() vim.cmd('call custom#CleanExtraSpaces()') end, { nargs = 0 })
vim.api.nvim_set_keymap('n', '<A-t>', ':Trailing<cr>', {noremap = true})

--" quick diff
vim.g.diff = 0
vim.api.nvim_create_user_command('DiffToggle', Custom.diff_toggle, { nargs = 0 })
--" toggle unsaved changes diff
vim.api.nvim_set_keymap('n', '<A-,>', '', {noremap = true, callback = Custom.diff_toggle })

--" end with :Q XD
vim.api.nvim_create_user_command('Q', function(info) vim.cmd('q' .. (info.bang and '!' or '')) end, { nargs = 0, bang = 1 })
vim.api.nvim_create_user_command('Qa', function(info) vim.cmd('qa' .. (info.bang and '!' or '')) end, { nargs = 0, bang = 1 })

vim.api.nvim_create_user_command('SynStack', function() vim.cmd([[echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')]]) end, { nargs = 0 })

vim.api.nvim_create_user_command('SetMakePath', function(info) vim.o.makeprg = 'make -C ' .. info.args end, { nargs = 1 })
