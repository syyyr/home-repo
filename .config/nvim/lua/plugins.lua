vim.cmd('packadd! nvim-lspconfig')
vim.cmd('packadd! nvim-cmp')
vim.cmd('packadd! cmp-nvim-lsp')
vim.cmd('packadd! cmp-buffer')
vim.cmd('packadd! lsp_signature.nvim')
vim.cmd('packadd! clangd_extensions.nvim')
vim.cmd('packadd! vim-vsnip')
vim.cmd('packadd! cmp-vsnip')
vim.cmd('packadd! cmp-path')
vim.cmd('packadd! inc-rename.nvim')
vim.cmd('packadd! i3config.vim')
vim.cmd('packadd! vim-colon-therapy')
vim.cmd('packadd! vim-pug')
vim.cmd('packadd! undotree')
vim.cmd('packadd! vim-better-whitespace')
vim.cmd('packadd! yang.vim')
vim.cmd('packadd! vim-commentary')
vim.cmd('packadd! vim-qml')
vim.cmd('packadd! vim-cpp-modern')
vim.cmd('packadd! readline.vim')
vim.cmd('packadd! vim-icalendar')
vim.cmd('packadd! nvim-treesitter')
vim.cmd('packadd! nvim-treesitter-playground')
vim.cmd('packadd! indent-blankline.nvim')

vim.cmd('packadd! git-blame.nvim')
vim.g.gitblame_enabled = 0
vim.g.gitblame_highlight_group = 'Question'
vim.g.gitblame_set_extmark_options = {hl_mode = 'combine'}

vim.api.nvim_create_user_command('GT', 'GitBlameToggle', {nargs = 0})
vim.api.nvim_create_user_command('GSHA', 'GitBlameCopySHA', {nargs = 0})
vim.api.nvim_create_user_command('GURL', 'GitBlameOpenCommitURL', {nargs = 0})

vim.cmd('packadd vimtex')
vim.g.vimtex_compiler_latexmk = {build_dir = 'build'}
vim.g.tex_conceal = 'amgs' -- default but don't conceal delimiters

-- FIXME: tabstop gets overriden by the autocommand in startup.vim
vim.cmd('packadd! vim-linux-coding-style')
vim.g.linuxsty_patterns = {'/linux/'}

vim.cmd('packadd! clever-f.vim')
vim.g.clever_f_smart_case = 1

vim.cmd('packadd goyo.vim')
local goyoFixGroup = vim.api.nvim_create_augroup('goyoFix', {clear = true})
vim.api.nvim_create_autocmd('User', {
    pattern = 'GoyoEnter',
    command = 'set eventignore = FocusGained',
    group = goyoFixGroup,
    nested = true
})
vim.api.nvim_create_autocmd('User', {
    pattern = 'GoyoLeave',
    command = 'set eventignore =',
    group = goyoFixGroup,
    nested = true
})

vim.cmd('packadd! vim-dispatch')
vim.g.dispatch_no_maps = 1

vim.api.nvim_create_user_command('CF', function() vim.lsp.buf.code_action() end, {nargs = 0})
vim.api.nvim_create_user_command('Cref', vim.lsp.buf.references, {nargs = 0})
vim.api.nvim_create_user_command('CQ', function() vim.diagnostic.setloclist({severity = vim.diagnostic.severity.ERROR}) end, {nargs = 0})
vim.api.nvim_create_user_command('CQA', vim.diagnostic.setloclist, {nargs = 0})

vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        if vim.g.skip_diagnostic_float then
            vim.g.skip_diagnostic_float = false
            return
        end
        vim.diagnostic.open_float(nil, {focus = false, scope = 'cursor'})
    end,
    group = vim.api.nvim_create_augroup('LSPDiagnostic', {clear = true})
})
vim.fn.sign_define('DiagnosticSignHint', {text = '--', texthl = 'DiagnosticSignHint'})
vim.fn.sign_define('DiagnosticSignInfo', {text = '--', texthl = 'DiagnosticSignInfo'})
vim.fn.sign_define('DiagnosticSignWarn', {text = '--', texthl = 'DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignError', {text = '>>', texthl = 'DiagnosticSignError'})
vim.diagnostic.config({
    virtual_text = {
        severity = 'error',
    },
    severity_sort = true,
    float = {
        header = '',
        source = true,
        format = function(diagnostic)
            local res = diagnostic.message
            local code = diagnostic.code and diagnostic.code or 'unknown-code'
            return res .. ' (' .. code .. ')'
        end
    }
})

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


local cmp = require('cmp')
if cmp == nil then
    error('cmp is missing!')
end

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm({select = false}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn['vsnip#available'](1) == 1 then
                feedkey('<Plug>(vsnip-expand-or-jump)', '')
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {'i', 's'}),

        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                feedkey('<Plug>(vsnip-jump-prev)', '')
            end
        end, {'i', 's'}),

    }),
    sources = cmp.config.sources({
        {name = 'nvim_lsp'},
        {name = 'buffer',},
        {name = 'vsnip'},
        {name = 'path'}
    }),
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
})

cmp.setup.filetype('cpp', {
    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.recently_used,
            require('clangd_extensions.cmp_scores'),
            cmp.config.compare.exact,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

local on_attach = function(client, bufnr)
    local bufopts = {noremap = true, silent = true, buffer = bufnr}
    vim.keymap.set('n', '<C-Space>', function()
        vim.g.skip_diagnostic_float = true
        vim.lsp.buf.hover()
    end, bufopts)
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)

    local capabilities = client.server_capabilities
    if capabilities.semanticTokensProvider and capabilities.semanticTokensProvider.full then
        local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
        vim.api.nvim_create_autocmd("TextChanged", {
            group = augroup,
            buffer = bufnr,
            callback = vim.lsp.buf.semantic_tokens_full
        })
        -- fire it first time on load as well
        vim.lsp.buf.semantic_tokens_full()
    end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('clangd_extensions').setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {'clangd', '--background-index', '-j=6', '--clang-tidy', '--header-insertion=never'}
    },
})

require('lspconfig').vimls.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require('lspconfig').diagnosticls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {'vim'},
    init_options = {
        linters = {
            vint = {
                sourceName = 'vint',
                command = 'vint',
                args = { '--enable-neovim', '--json', '%tempfile' },
                debounce = 100,
                parseJson = {
                    line = 'line_number',
                    column = 'column_number',
                    security = 'severity',
                    message = '[vint] ${description} [${policy_name}]',
                },
                securities = {
                    error = 'error',
                    warning = 'warning',
                    style_problem = 'info',
                },
            },
        },
        filetypes = {
            vim = 'vint',
        },
    }
})

require('lspconfig').pylsp.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require('lspconfig').cmake.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require('lspconfig').bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require('lspconfig').tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require('lspconfig').yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities
})

require('lspconfig').sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
        }
    }
})

require('inc_rename').setup({
    cmd_name = 'CR'
})

vim.g.netrw_banner = 0

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.cpon = {
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

require('indent_blankline').setup({
    char = '▏',
    buftype_exclude = {'tab', 'help'}
})

require('lsp_signature').setup({
    bind = true,
    handler_opts = {
      border = "rounded"
    },
    hint_enable = false
})

vim.cmd('packadd! nvim-semantic-tokens')
require("nvim-semantic-tokens").setup {
    preset = "default",
    highlighters = { require('nvim-semantic-tokens.table-highlighter') }
}

local on_full = require('nvim-semantic-tokens.semantic_tokens').on_full
vim.api.nvim_create_user_command('LspInspectTokenCursor', function ()
    vim.cmd('normal! viwo')
    local params = vim.lsp.util.make_given_range_params()
    vim.lsp.buf_request(
        0,
        "textDocument/semanticTokens/full",
        params,
        vim.lsp.with(on_full, {
            on_token = function(_, token)
                if token.line == params.range.start.line and token.start_char == params.range.start.character then
                    vim.notify(token.type)
                end
            end,
        })
    )
end, {nargs = 0})
