vim.cmd('packadd! nvim-treesitter')

local available_parsers = {
    'bash',
    'c',
    'comment',
    'cpon',
    'lua',
    'python',
    'qmljs',
    'query',
    'sh',
    'typescript',
    'vim',
    'vimdoc',
}

require('nvim-treesitter').setup({
    ensure_install = available_parsers,
    install_dir = vim.fn.stdpath('data') .. '/treesitter',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function(info)
        if vim.iter(available_parsers):find(info.match) then
            vim.treesitter.start()
            if info.match ~= 'python' and info.match ~= 'sh' then
                vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
            end
        end
    end
})

vim.api.nvim_create_user_command('TSUpdateAndQuit', function()
    require('nvim-treesitter.install').update(nil, nil, function()
        vim.notify('') -- The install output does not have a newline at the end.
        vim.cmd.quit()
    end)
end, {nargs = 0})
