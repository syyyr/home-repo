vim.o.termguicolors = true

-- colors
vim.g.PaperColor_Theme_Options = {
    theme = {
        default = {
            transparent_background = 0,
            allow_bold = 1,
            allow_italic = 1,
        },
    },
    language = {
        cpp = {
            highlight_standard_library = 1,
        },
    },
}

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'PaperColor',
    callback = function()
        local separator_colors = vim.o.background == 'dark' and 'guifg=#d0d0d0 guibg=#1c1c1c ctermfg=252 ctermbg=234' or 'guifg=#444444 guibg=#eeeeee ctermfg=255 ctermbg=238'

        -- Status underline.
        vim.cmd('highlight StatusLineNC ' .. separator_colors .. ' cterm=underline gui=underline')
        vim.cmd('highlight StatusLine ' .. separator_colors .. ' cterm=underline,bold gui=underline,bold')

        -- WinSeparator
        vim.cmd('highlight WinSeparator ' .. separator_colors)

        -- End of buffer
        vim.cmd('highlight clear EndOfBuffer')
        vim.cmd('highlight link EndOfBuffer NonText')

        -- Merge conflicts
        vim.cmd('highlight MergeConflict ctermbg=black ctermfg=red guibg=black guifg=red')

        -- Make TODO have a default background
        vim.cmd('highlight Todo cterm=bold ctermfg=0 ctermbg=11 gui=bold guifg=#00af5f guibg=default')

        -- LSP colors
        vim.cmd('highlight clear LspDiagnosticsDefaultError')
        vim.cmd('highlight LspDiagnosticsDefaultError ctermfg=124 guifg=#af0000')
        vim.cmd('highlight clear LspDiagnosticsDefaultWarning')
        vim.cmd('highlight LspDiagnosticsDefaultWarning gui=bold guifg=#00af5f')
        vim.cmd('highlight clear LspDiagnosticsDefaultInformation')
        vim.cmd('highlight LspDiagnosticsDefaultInformation gui=bold guifg=#00af5f')
        vim.cmd('highlight clear LspDiagnosticsDefaultHint')
        vim.cmd('highlight LspDiagnosticsDefaultHint gui=bold guifg=#00af5f')

        -- TODO: These didn't come up yet, so I don't know which color group to assign.
        -- FIXME: these can be removed probably
        vim.cmd('highlight! link LspKeyword Error')
        vim.cmd('highlight! link LspModifier Error')
        vim.cmd('highlight! link LspString Error')
        vim.cmd('highlight! link LspNumber Error')
        vim.cmd('highlight! link LspRegexp Error')
        vim.cmd('highlight! link LspDeprecated Error')
        vim.cmd('highlight! link LspAsync Error')
        vim.cmd('highlight! link LspModification Error')
        vim.cmd('highlight! link LspDocumentation Error')
        vim.cmd('highlight! link LspEvent Error')

        -- Treesitter
        vim.cmd('highlight! link @typeParameter Constant')
        vim.cmd('highlight! link @enum Constant')
        vim.cmd('highlight! link @macro Macro')
        vim.cmd('highlight! link @comment Comment')
        vim.cmd('highlight! link @variable NONE')
        vim.cmd('highlight! link @preproc NONE')
        vim.cmd('highlight! link @parameter NONE')
        vim.cmd('highlight! link @type NONE')
        vim.cmd('highlight! link @class NONE')
        vim.cmd('highlight! link @variable NONE')
        vim.cmd('highlight! link @namespace NONE')
        vim.cmd('highlight! link @property NONE')

        -- LSP semantic colors
        vim.cmd('highlight! link @lsp.type.class NONE')
        vim.cmd('highlight! link @lsp.type.enum Constant')
        vim.cmd('highlight! link @lsp.type.function NONE')
        vim.cmd('highlight! link @lsp.type.namespace NONE')
        vim.cmd('highlight! link @lsp.type.parameter NONE')
        vim.cmd('highlight! link @lsp.type.property NONE')
        vim.cmd('highlight! link @lsp.type.variable NONE')
    end,
    group = vim.api.nvim_create_augroup('PaperColorOverride', {clear = true})
})

vim.api.nvim_create_autocmd('Syntax', {
    callback = function ()
        vim.cmd([[syn match MergeConflict '\v^[<\|=|>]{7}([^=].+)?$']])
    end,
    group = vim.api.nvim_create_augroup('CustomSyntax', {clear = true})
})

vim.cmd('colorscheme PaperColor')
