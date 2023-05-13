vim.cmd('packadd! nvim-treesitter')
vim.cmd('packadd! nvim-treesitter-playground')

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {'cpp'},
    },
    indent = {
        enable = true,
        disable = function(lang)
            if lang ~= 'python' then
                return true
            end
        end
    },
    ensure_installed = {
        'bash',
        'comment',
        'cpon',
        'cpp',
        'lua',
        'python',
        'qmljs',
        'typescript',
        'vim',
    },
    incremental_selection = {enable = false},
    textobjects = {enable = true},
})


