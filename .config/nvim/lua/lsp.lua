local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

vim.cmd('packadd! nvim-cmp')
vim.cmd('packadd! cmp-nvim-lsp')
vim.cmd('packadd! cmp-buffer')
vim.cmd('packadd! vim-vsnip')
vim.cmd('packadd! cmp-vsnip')
vim.cmd('packadd! cmp-path')

local cmp = require('cmp')
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<c-b>'] = cmp.mapping.scroll_docs(-4),
        ['<c-f>'] = cmp.mapping.scroll_docs(4),
        ['<c-space>'] = cmp.mapping.complete(),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<cr>'] = cmp.mapping.confirm({select = false}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn['vsnip#available'](1) == 1 then
                feedkey('<plug>(vsnip-expand-or-jump)', '')
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {'i', 's'}),

        ['<s-tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                feedkey('<plug>(vsnip-jump-prev)', '')
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

local on_attach = function(client, bufnr)
    local capabilities = client.server_capabilities
    if capabilities.semanticTokensProvider and capabilities.semanticTokensProvider.full then
        vim.api.nvim_create_autocmd("TextChanged", {
            group = vim.api.nvim_create_augroup("SemanticTokens", {}),
            buffer = bufnr,
            callback = vim.lsp.buf.semantic_tokens_full
        })
        -- fire it first time on load as well
        vim.lsp.buf.semantic_tokens_full()
    end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.cmd('packadd! nvim-lspconfig')
for _, lsp_name in ipairs({'bashls', 'cmake', 'pylsp', 'tsserver', 'vimls', 'yamlls'}) do
    require('lspconfig')[lsp_name].setup({
        on_attach = on_attach,
        capabilities = capabilities
    })
end

vim.cmd('packadd! plenary.nvim')
vim.cmd('packadd! null-ls.nvim')
local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.cmake_lint.with({
            extra_args = {
                '--disabled-codes',
                'C0103', -- invalid variable name
                'C0111', -- missing docstring
                'C0306', -- indentation
                'C0307', -- indentation
            }
        }),
        null_ls.builtins.diagnostics.gitlint.with({
            extra_args = {
                '--ignore',
                'body-is-missing'
            }
        }),
        null_ls.builtins.diagnostics.vint,
    },
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
                disable = {'empty-block'}
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
            },
        }
    }
})

vim.cmd('packadd! clangd_extensions.nvim')
require('clangd_extensions').setup({
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {'clangd', '--background-index', '-j=6', '--clang-tidy', '--header-insertion=never'}
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

vim.cmd('packadd! lsp_signature.nvim')
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

vim.cmd('packadd! nvim-custom-diagnostic-highlight')
require('nvim-custom-diagnostic-highlight').setup({})

vim.api.nvim_create_user_command('CF', function() vim.lsp.buf.code_action() end, {nargs = 0})
vim.api.nvim_create_user_command('Cref', vim.lsp.buf.references, {nargs = 0})
vim.api.nvim_create_user_command('CQ', function() vim.diagnostic.setloclist({severity = vim.diagnostic.severity.ERROR}) end, {nargs = 0})
vim.api.nvim_create_user_command('CQA', vim.diagnostic.setloclist, {nargs = 0})

Custom.nnoremap('<c-space>', function()
    vim.g.skip_diagnostic_float = true
    vim.lsp.buf.hover()
end)
Custom.nnoremap('<c-]>', vim.lsp.buf.definition)

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
        suffix = '',
        source = true,
        format = function(diagnostic)
            local res = diagnostic.message
            local code = diagnostic.code and diagnostic.code or 'unknown-code'
            return res .. ' (' .. code .. ')'
        end,
    }
})
