vim.cmd('packadd! nvim-treesitter')
vim.cmd('packadd! nvim-treesitter-playground')

require('nvim-treesitter.parsers').get_parser_configs().cpon = {
    install_info = {
        url = '/home/vk/git/tree-sitter-cpon', -- local path or git repo
        files = {'src/parser.c'},
        generate_requires_npm = false,
        requires_generate_from_grammar = true,
    }
}

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


