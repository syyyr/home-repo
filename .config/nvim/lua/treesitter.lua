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
    'vue',
    'vim',
    'vimdoc',
}

local parser_install_dir = vim.fn.stdpath('data') .. '/treesitter'
vim.opt.runtimepath:prepend(parser_install_dir)

require('nvim-treesitter').setup({
    install_dir = parser_install_dir
})

require('nvim-treesitter').install(available_parsers)

vim.api.nvim_create_autocmd('FileType', {
    pattern = available_parsers,
    callback = function(info)
        vim.treesitter.start()
        if vim.iter({'vue', 'cpp', 'sh', 'rust'}):find(info.match) == nil then
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end
    end
})
