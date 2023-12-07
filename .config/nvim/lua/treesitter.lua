vim.cmd('packadd! nvim-treesitter')

local available_parsers = {
    'bash',
    'comment',
    'cpon',
    'lua',
    'python',
    'qmljs',
    'sh',
    'typescript',
    'vim',
    'vimdoc',
}

require('nvim-treesitter').setup({ ensure_install = available_parsers })

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function(info)
        if require('syyyr').contains(available_parsers, info.match) then
            vim.treesitter.start()
            if info.match ~= 'python' then
                vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
            end
        end
    end
})
