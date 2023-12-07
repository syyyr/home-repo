vim.cmd('packadd! nvim-treesitter')
vim.cmd('packadd! nvim-treesitter-playground')

local config = {
    highlight = {
        enable = true,
        disable = {'cpp', 'markdown'},
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
        'markdown',
        'python',
        'qmljs',
        'typescript',
        'vim',
        'vimdoc',
    },
    incremental_selection = {enable = false},
    textobjects = {enable = true},
}

require('nvim-treesitter.configs').setup(config--[[@as TSConfig]])
