local syyyr = require('syyyr')

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

local capabilities = vim.tbl_deep_extend("force",
    vim.lsp.protocol.make_client_capabilities(),
    require('cmp_nvim_lsp').default_capabilities()
)
capabilities.offsetEncoding = {'utf-16'}

vim.cmd('packadd! nvim-lspconfig')
for _, lsp_name in ipairs({
    'bashls',
    'cmake',
    'denols',
    'dockerls',
    'jsonls',
    'pkgbuild_language_server',
    'yang_lsp',
    'vimls'}) do
    require('lspconfig')[lsp_name].setup({
        capabilities = capabilities
    })
end
vim.cmd('packadd! rustaceanvim')

require('lspconfig').diagnosticls.setup({
    capabilities = capabilities,
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

require('lspconfig').denols.setup({
    capabilities = capabilities,
    root_dir = require('lspconfig.util').root_pattern("deno.json", "deno.jsonc"),
    single_file_support = true
})

require('lspconfig').yamlls.setup({
    capabilities = capabilities,
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
        null_ls.builtins.diagnostics.clazy,
        null_ls.builtins.diagnostics.selene,
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
                ruff = { enabled = true }
            }
        }
    }
})

require('lspconfig').qmlls.setup({
    capabilities = capabilities,
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
            require('clangd_extensions.cmp_scores'),
            cmp.config.compare.offset,
            cmp.config.compare.recently_used,
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
syyyr.nnoremap('<a-g>', function() vim.diagnostic.goto_next({cursor_position = {0, 0}}) end)

vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    local _
    _, vim.g.float_win_id = vim.lsp.handlers.hover(err, result, ctx, config)
end

local function filter_unused_diagnostics(diagnostics)
    return vim.iter(diagnostics):filter(function(diagnostic)
        return vim.iter({"unused", "not used", "never read", "never used"}):all(function(x) return not string.match(string.lower(diagnostic.message), x) end)
    end):totable()
end

local function wrap_filter_unused(original_handler)
    return function(namespace, bufnr, diagnostics, opts)
        original_handler(namespace, bufnr, filter_unused_diagnostics(diagnostics), opts)
    end
end

vim.diagnostic.handlers.underline.show = wrap_filter_unused(vim.diagnostic.handlers.underline.show)
vim.diagnostic.handlers.signs.show = wrap_filter_unused(vim.diagnostic.handlers.signs.show)

syyyr.nnoremap('<c-space>', function()
    vim.b.skip_diagnostic_float = true
    vim.lsp.buf.hover()
end)

vim.api.nvim_create_autocmd({'CursorHold', 'DiagnosticChanged'}, {
    callback = function()
        if vim.v.exiting ~= vim.NIL then
            return
        end
        if vim.b.skip_diagnostic_float then
            vim.b.skip_diagnostic_float = false
            return
        end
        syyyr.close_float()
        local _, new_float_win = vim.diagnostic.open_float(nil, {focus = false, scope = 'cursor'})
        _, vim.b.float_win_id = nil, new_float_win and new_float_win or vim.b.float_win_id
    end,
    group = vim.api.nvim_create_augroup('LSPDiagnostic', {clear = true})
})

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
            return (nil)--[[@as string]] -- The function does handle nil.
        end
    },
    severity_sort = true,
    float = {
        header = '',
        suffix = '',
        source = true,
        format = format_diagnostic
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '>>',
            [vim.diagnostic.severity.WARN] = '--',
            [vim.diagnostic.severity.INFO] = '--',
            [vim.diagnostic.severity.HINT] = '--'
        }
    }
})
