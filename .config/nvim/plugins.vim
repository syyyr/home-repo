scriptencoding utf8

packadd! nvim-lspconfig
packadd! nvim-cmp
packadd! cmp-nvim-lsp
packadd! cmp-buffer
packadd! cmp-nvim-lsp-signature-help
packadd! clangd_extensions.nvim
" set completeopt=menu,menuone,noselect

lua << EOF
vim.api.nvim_create_user_command('CF', function() vim.lsp.buf.code_action() end, { nargs = 0 })
vim.cmd([[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus = false, scope = 'cursor'})]])
vim.fn.sign_define('DiagnosticSignWarn', { text = '--', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignError', { text = '>>', texthl = 'DiagnosticSignError' })
vim.diagnostic.config({
    virtual_text = {
        severity = 'error',
    },
    severity_sort = true,
    float = {
        header = ''
    }
})

local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer', },
        { name = 'nvim_lsp_signature_help' }
    })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
    vim.keymap.set('n', '<C-Space>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
end

require("clangd_extensions").setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities
    },
})

require("lspconfig").vimls.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require("lspconfig").pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities
})
EOF


let g:gitblame_enabled = 0
let g:gitblame_highlight_group = "Question"
let g:gitblame_set_extmark_options = {
            \ 'hl_mode': 'combine',
            \ }
packadd! git-blame.nvim
command! GT GitBlameToggle
command! GSHA GitBlameCopySHA

packadd! i3config.vim
packadd! vim-colon-therapy
packadd! vim-pug
packadd! undotree
packadd! vim-better-whitespace
packadd! yang.vim
packadd! vim-commentary
packadd! vim-qml
packadd! vim-cpp-modern
packadd! readline.vim
packadd! vim-icalendar
packadd! nvim-treesitter
packadd! nvim-treesitter-playground

lua << EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.cpon = {
  install_info = {
    url = "~/git/tree-sitter-cpon", -- local path or git repo
    files = {"src/parser.c"},
    -- optional entries:
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  }
}
require'nvim-treesitter.configs'.setup {
    -- Modules and its options go here
    highlight = {
        enable = true,
        disable = { "cpp" },
    },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}
EOF

" FIXME: Why can't this be in ftplugin/tex.vim?
let g:vimtex_compiler_latexmk = {'build_dir': 'build'}
let g:tex_conceal = 'amgs' " default but don't conceal delimiters
packadd vimtex

packadd! indent-blankline.nvim
lua << EOF
require("indent_blankline").setup {
    char = '▏',
    buftype_exclude = {'tab', 'help'}
}
EOF

let g:no_default_tabular_maps = 1
packadd! tabular

let g:linuxsty_patterns = ['/linux/']
packadd! vim-linux-coding-style

packadd! clever-f.vim
let g:clever_f_smart_case = 1

packadd! goyo.vim
augroup goyoFix
    autocmd!
    autocmd User GoyoEnter nested set eventignore=FocusGained
    autocmd User GoyoLeave nested set eventignore=
augroup END

packadd! vim-dispatch
let g:dispatch_no_maps = 1

" remove netrw banner
let g:netrw_banner = 0
