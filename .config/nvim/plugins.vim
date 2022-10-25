scriptencoding utf8

packadd! nvim-lspconfig
packadd! nvim-cmp
packadd! cmp-nvim-lsp
packadd! cmp-buffer
packadd! cmp-nvim-lsp-signature-help
packadd! clangd_extensions.nvim
packadd! vim-vsnip
packadd! cmp-vsnip

lua << EOF
vim.api.nvim_create_user_command('CF', function() vim.lsp.buf.code_action() end, { nargs = 0 })
vim.api.nvim_create_user_command('CR', function() vim.lsp.buf.rename() end, { nargs = 0 })
vim.cmd([[autocmd! CursorHold * lua vim.diagnostic.open_float(nil, {focus = false, scope = 'cursor'})]])
vim.fn.sign_define('DiagnosticSignHint', { text = '--', texthl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '--', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '--', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignError', { text = '>>', texthl = 'DiagnosticSignError' })
vim.diagnostic.config({
    virtual_text = {
        severity = 'error',
    },
    severity_sort = true,
    float = {
        header = '',
        source = true
    }
})

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),

    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer', },
        { name = 'nvim_lsp_signature_help' },
        { name = 'vsnip' }
    }),
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },

})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
    vim.keymap.set('n', '<C-Space>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
end

require("clangd_extensions").setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {"clangd", "--background-index", "-j=6", "--clang-tidy", "--header-insertion=never", "--suggest-missing-includes"}
    },
})

require("lspconfig").vimls.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require("lspconfig").pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require("lspconfig").cmake.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require("lspconfig").bashls.setup({
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
