vim.opt.termguicolors = true

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

        vim.cmd('highlight StatusLineNC ' .. separator_colors .. ' cterm=underline gui=underline')
        vim.cmd('highlight StatusLine ' .. separator_colors .. ' cterm=underline,bold gui=underline,bold')

        vim.cmd('highlight WinSeparator ' .. separator_colors)

        vim.cmd('highlight search ctermbg=11 guifg=#444444 guibg=#ffffaa')
        vim.cmd('highlight! link CurSearch Search')

        vim.cmd('highlight clear EndOfBuffer')
        vim.cmd('highlight! link EndOfBuffer NonText')

        vim.cmd('highlight MergeConflict ctermbg=black ctermfg=red guibg=black guifg=red')

        vim.cmd('highlight Todo ctermbg=NONE guibg=NONE')

        vim.cmd('highlight! link LowerCaseNote Todo')

        vim.cmd('highlight! link ErrorMsg LspDiagnosticsDefaultError')

        vim.cmd('highlight! Conceal guibg=NONE')

        vim.cmd('highlight! link NormalFloat Pmenu')
        vim.cmd('highlight clear LspDiagnosticsDefaultError')
        vim.cmd('highlight LspDiagnosticsDefaultError ctermfg=124 guifg=#af0000')
        vim.cmd('highlight! link DiagnosticFloatingError LspDiagnosticsDefaultError')

        vim.cmd('highlight LspDiagnosticsDefaultWarning guibg=NONE')
        if vim.o.background == 'dark' then
            vim.cmd('highlight LspDiagnosticsDefaultWarning guifg=#00af5f')
            vim.cmd('highlight LspDiagnosticsUnderlineWarning guisp=#00af5f')
            vim.cmd('highlight Todo guifg=#00af5f')
        end

        for _, group in ipairs({
            'DiagnosticFloatingHint',
            'DiagnosticFloatingInfo',
            'DiagnosticFloatingWarn',
            'LspDiagnosticsDefaultHint',
            'LspDiagnosticsDefaultInformation'}) do
            vim.cmd('highlight! link ' .. group .. ' LspDiagnosticsDefaultWarning ')
        end

        -- Treesitter
        vim.cmd('highlight! link @class NONE')
        vim.cmd('highlight! link @comment Comment')
        vim.cmd('highlight! link @enum Constant')
        vim.cmd('highlight! link @keyword Keyword')
        vim.cmd('highlight! link @keyword.conditional Conditional')
        vim.cmd('highlight! link @keyword.import Include')
        vim.cmd('highlight! link @keyword.repeat Repeat')
        vim.cmd('highlight! link @macro Macro')
        vim.cmd('highlight! link @module NONE')
        vim.cmd('highlight! link @namespace NONE')
        vim.cmd('highlight! link @parameter NONE')
        vim.cmd('highlight! link @preproc NONE')
        vim.cmd('highlight! link @property NONE')
        vim.cmd('highlight! link @punctuation.bracket NONE')
        vim.cmd('highlight! link @type NONE')
        vim.cmd('highlight! link @type.builtin Type')
        vim.cmd('highlight! link @typeParameter Constant')
        vim.cmd('highlight! link @variable NONE')
        vim.cmd('highlight! link @variable NONE')

        vim.cmd('highlight! link @lsp.type.class NONE')
        vim.cmd('highlight! link @lsp.type.comment.lua NONE')
        vim.cmd('highlight! link @lsp.type.enum Constant')
        vim.cmd('highlight! link @lsp.type.function NONE')
        vim.cmd('highlight! link @lsp.type.macro Macro')
        vim.cmd('highlight! link @lsp.type.namespace NONE')
        vim.cmd('highlight! link @lsp.type.parameter NONE')
        vim.cmd('highlight! link @lsp.type.property NONE')
        vim.cmd('highlight! link @lsp.type.typeParameter Constant')
        vim.cmd('highlight! link @lsp.type.variable NONE')
        vim.cmd('highlight! link @text.uri.comment NONE')

        vim.cmd('highlight! link @type.qualifier.cpp cStorageClass')
        vim.cmd('highlight! link @keyword.return.cpp Statement')

        vim.cmd('highlight DiagnosticOk gui=bold guifg=#629120')
    end,
    group = vim.api.nvim_create_augroup('PaperColorOverride', {clear = true})
})

vim.api.nvim_create_autocmd({'BufWinEnter', 'WinEnter'}, {
    callback = function()
        if vim.w.custom_syntax_set then
            return
        end
        vim.w.custom_syntax_set = true
        vim.cmd([[match MergeConflict /\v^[<\|=|>]{7}([^=].+)?$/]])
    end,
    group = vim.api.nvim_create_augroup('CustomSyntax', {clear = true})
})

vim.cmd('colorscheme PaperColor')
