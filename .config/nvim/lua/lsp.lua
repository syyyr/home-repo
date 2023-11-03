local syyyr = require('syyyr')
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
        ['<cr>'] = cmp.mapping.confirm({select = false}),
        ['<tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn['vsnip#available'](1) == 1 then
                feedkey('<plug>(vsnip-expand-or-jump)', '')
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
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
        {
            name = 'buffer',
            option = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end
            }
        },
        {name = 'vsnip'},
        {name = 'path'}
    }),
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.offsetEncoding = {'utf-16'}

vim.cmd('packadd! nvim-lspconfig')
for _, lsp_name in ipairs({
    'bashls',
    'cmake',
    'jsonls',
    'pkgbuild_language_server',
    'tsserver',
    'yang_lsp',
    'vimls'}) do
    require('lspconfig')[lsp_name].setup({
        capabilities = capabilities
    })
end

require('lspconfig').diagnosticls.setup({
    filetypes = {'cpp'},
    init_options = {
        linters = {
            gitlab = {
                command = "/home/vk/apps/gitlab-review-diagnostic.bash",
                rootPatterns = {".git"},
                args = { "%filepath" },
                sourceName = "gitlab",
                parseJson = {
                    sourceName = "file",
                    sourceNameFilter = true,
                    line = "line",
                    endline = "endline",
                    message = "${message}",
                    security = "severity",
                },
                securities = {
                    warning = "warning"
                }
            }
        },
        filetypes = {
            cpp = "gitlab"
        }
    }
})

require('lspconfig').yamlls.setup({
    settings = {
        redhat = {
            telemetry = {
                enabled = false
            }
        },
        yaml = {
            keyOrdering = false
        }
    }
})

vim.cmd('packadd! plenary.nvim')
vim.cmd('packadd! none-ls.nvim')
local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.checkmake,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.vint,

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
                'body-is-missing,body-min-length,title-min-length',
            }
        }),
    },
})

require('lspconfig').lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT'
            },
            diagnostics = {
                globals = {'vim'},
                disable = {
                    'empty-block',
                    'trailing-space'
                }
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
        }
    }
})

require('lspconfig').pylsp.setup({
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pylint = { enabled = true }
            }
        }
    }
})

require('lspconfig').qmlls.setup({
    filetypes = {'qml'},
    cmd = {'qmlls6', '-b', 'build'}
})

vim.cmd('packadd! clangd_extensions.nvim')

require('lspconfig').clangd.setup({
    capabilities = capabilities,
    cmd = {'clangd', '--background-index', '-j=6', '--clang-tidy', '--header-insertion=never', '--completion-style=detailed'},
    on_attach = function ()
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
    end
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

vim.cmd('packadd! nvim-custom-diagnostic-highlight')
require('nvim-custom-diagnostic-highlight').setup({})

vim.api.nvim_create_user_command('CF', function() vim.lsp.buf.code_action({apply = true}) end, {nargs = 0})
vim.api.nvim_create_user_command('Cref', vim.lsp.buf.references, {nargs = 0})
vim.api.nvim_create_user_command('CQ', function() vim.diagnostic.setloclist({severity = vim.diagnostic.severity.ERROR}) end, {nargs = 0})
vim.api.nvim_create_user_command('CQA', vim.diagnostic.setqflist, {nargs = 0})

vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    local _
    _, vim.g.float_win_id = vim.lsp.handlers.hover(err, result, ctx, config)
end

local function filter_unused_diagnostics(diagnostics)
    return syyyr.filter(diagnostics, function(diagnostic)
        return syyyr.all({"unused", "never read"}, function(x) return not string.match(string.lower(diagnostic.message), x) end)
    end)
end

local original_underline_show = vim.diagnostic.handlers.underline.show
local original_signs_show = vim.diagnostic.handlers.signs.show

vim.diagnostic.handlers.underline.show = function(a, b, diagnostics, d, e)
    original_underline_show(a, b, filter_unused_diagnostics(diagnostics), d, e)
end

vim.diagnostic.handlers.signs.show = function(a, b, diagnostics, d, e)
    original_signs_show(a, b, filter_unused_diagnostics(diagnostics), d, e)
end

syyyr.nnoremap('<c-space>', function()
    vim.g.skip_diagnostic_float = true
    vim.lsp.buf.hover()
end)

vim.api.nvim_create_autocmd('CursorHold', {
    callback = function()
        if vim.g.skip_diagnostic_float then
            vim.g.skip_diagnostic_float = false
            return
        end
        local _, new_float_win = vim.diagnostic.open_float(nil, {focus = false, scope = 'cursor'})
        _, vim.g.float_win_id = nil, new_float_win and new_float_win or vim.g.float_win_id
    end,
    group = vim.api.nvim_create_augroup('LSPDiagnostic', {clear = true})
})
vim.fn.sign_define('DiagnosticSignHint', {text = '--', texthl = 'DiagnosticSignHint'})
vim.fn.sign_define('DiagnosticSignInfo', {text = '--', texthl = 'DiagnosticSignInfo'})
vim.fn.sign_define('DiagnosticSignWarn', {text = '--', texthl = 'DiagnosticSignWarn'})
vim.fn.sign_define('DiagnosticSignError', {text = '>>', texthl = 'DiagnosticSignError'})

local function format_diagnostic(diagnostic)
    local res = diagnostic.message
    local code = diagnostic.code and diagnostic.code or 'unknown-code'
    return res .. ' (' .. code .. ')'
end

vim.diagnostic.config({
    virtual_text = {
        format = function(diagnostic)
            if diagnostic.severity == vim.diagnostic.severity.ERROR or diagnostic.message:find('fix available') then
                return format_diagnostic(diagnostic)
            end
        end
    },
    severity_sort = true,
    float = {
        header = '',
        suffix = '',
        source = true,
        format = format_diagnostic
    }
})
