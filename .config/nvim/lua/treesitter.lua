vim.cmd('packadd! nvim-treesitter')
vim.cmd('packadd! nvim-treesitter-playground')

require('nvim-treesitter.parsers').get_parser_configs().cpon = {
    install_info = {
        url = 'https://github.com/fvacek/tree-sitter-cpon.git', -- local path or git repo
        files = {'src/parser.c'},
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    }
}

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {'cpp'},
    },
    indent = {
        enable = 'python'
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


