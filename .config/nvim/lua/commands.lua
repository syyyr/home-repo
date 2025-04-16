local syyyr = require('syyyr')
vim.api.nvim_create_user_command('Trailing', function()
    local save_cursor = vim.fn.getpos('.')
    local old_query = vim.fn.getreg('/')
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
    vim.fn.setreg('/', old_query)
end, { nargs = 0 })
syyyr.nnoremap('<a-t>', '<cmd>Trailing<cr><cmd>nohlsearch<cr>')

vim.api.nvim_create_user_command('DiffToggle', function()
    if not vim.b.scratch_winnr then
        local file_name = vim.fn.expand('%')--[[@as string]]
        if file_name == '' then
            vim.notify('DiffToggle: Empty file name.')
            return
        end
        if vim.fn.filereadable(file_name) == 0 then
            vim.notify("DiffToggle: File doesn't exist (or can't be opened).")
            return
        end

        local original_bufnr = vim.fn.bufnr()
        local original_bufname = vim.fn.expand('%')
        vim.cmd('vert new')
        vim.api.nvim_create_autocmd('BufHidden', {
            buffer = vim.fn.bufnr(),
            callback = function(info)
                vim.defer_fn(function()
                    vim.cmd('bdelete ' .. info.buf)
                    vim.b[original_bufnr].scratch_winnr = nil
                end, 0)
            end,
            once = true,
            group = vim.api.nvim_create_augroup('RemoveDiffToggleBuffer', {clear = true})
        })
        local scratch_winnr = vim.fn.win_getid()
        vim.b.scratch_winnr = scratch_winnr
        vim.cmd('file disk://' .. original_bufname)
        vim.opt.buftype = 'nofile'
        vim.cmd('read #')
        vim.cmd('0delete_')
        vim.cmd('diffthis')
        vim.cmd('wincmd p')
        vim.b.scratch_winnr = scratch_winnr
        vim.cmd('diffthis')
    else
        vim.api.nvim_win_close(vim.b.scratch_winnr, false)
    end
end, { nargs = 0 })

syyyr.nnoremap('<a-,>', '<cmd>DiffToggle<cr>')

vim.api.nvim_create_user_command('Q', function(info)
    vim.cmd('q' .. (info.bang and '!' or ''))
end, { nargs = 0, bang = true })

vim.api.nvim_create_user_command('Qa', function(info)
    vim.cmd('qa' .. (info.bang and '!' or ''))
end, { nargs = 0, bang = true })

vim.api.nvim_create_user_command('Cq', function(info)
    vim.cmd('cq' .. (info.bang and '!' or ''))
end, { nargs = 0, bang = true })

vim.api.nvim_create_user_command('SetMakePath', function(info)
    vim.opt.makeprg = 'make -C ' .. info.args
end, { nargs = 1 })

vim.api.nvim_create_user_command('CS', function(info)
    vim.lsp.buf.workspace_symbol(info.args ~= '' and info.args or vim.fn.expand('<cword>')--[[@as string]])
end, { nargs = '?' })

vim.api.nvim_create_user_command('TSUpdateAndQuit', function()
    local update_func = require('nvim-treesitter.install').update({ with_sync = true })
    update_func('all')
    vim.notify('') -- The install output does not have a newline at the end.
    vim.cmd.quit()
end, {nargs = 0})
