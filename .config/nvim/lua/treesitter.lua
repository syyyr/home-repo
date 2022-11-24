vim.cmd('packadd! nvim-treesitter')
vim.cmd('packadd! nvim-treesitter-playground')

require('nvim-treesitter.parsers').get_parser_configs().cpon = {
    install_info = {
        url = '~/git/tree-sitter-cpon', -- local path or git repo
        files = {'src/parser.c'},
        -- optional entries:
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
    }
}

require('nvim-treesitter.configs').setup({
    -- Modules and its options go here
    highlight = {
        enable = true,
        disable = {'cpp'},
    },
    incremental_selection = {enable = true},
    textobjects = {enable = true},
})


