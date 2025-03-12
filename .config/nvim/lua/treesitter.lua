vim.cmd('packadd! nvim-treesitter')

local available_parsers = {
    'bash',
    'c',
    'comment',
    'cpon',
    'cpp',
    'dockerfile',
    'jsonc',
    'lua',
    'markdown',
    'python',
    'qmljs',
    'query',
    'rust',
    'typescript',
    'vim',
    'vimdoc',
}

local parser_install_dir = vim.fn.stdpath('data') .. '/treesitter'
vim.opt.runtimepath:prepend(parser_install_dir)

require('nvim-treesitter.configs').setup({
    ensure_installed = available_parsers,
    install_dir = parser_install_dir
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { '*' },
    callback = function(info)
        if vim.iter(available_parsers):find(info.match) then
            vim.treesitter.start()
            if vim.iter({'cpp', 'sh', 'rust'}):find(info.match) == nil then
                vim.bo.indentexpr = "nvim_treesitter#indent()"
            end
        end
    end
})
