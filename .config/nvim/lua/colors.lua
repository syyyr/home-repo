vim.opt.termguicolors = true

vim.g.PaperColor_Theme_Options = {
    theme = {
        ["default.light"] = {
            transparent_background = 0,
            allow_bold = 1,
            allow_italic = 1,
            override = {
                color00 = {'#eff1f5'},
                cursorline = {'#e6e9ef'}
            }
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
        local separator_colors = vim.o.background == 'dark' and 'guifg=#d0d0d0 guibg=#1c1c1c ctermfg=252 ctermbg=234' or 'guifg=#444444 guibg=#eff1f5 ctermfg=255 ctermbg=238'

        vim.cmd('highlight StatusLineNC ' .. separator_colors .. ' cterm=underline gui=underline')
        vim.cmd('highlight StatusLine ' .. separator_colors .. ' cterm=underline,bold gui=underline,bold')
        vim.cmd('highlight WinSeparator ' .. separator_colors)

        vim.cmd('highlight search ctermbg=11 guifg=#444444 guibg=#ffffaa')
        vim.cmd('highlight clear EndOfBuffer')
        vim.cmd('highlight MergeConflict ctermbg=black ctermfg=red guibg=black guifg=red')
        vim.cmd('highlight Todo ctermbg=NONE guibg=NONE')
        vim.cmd('highlight! Conceal guibg=NONE')
        vim.cmd('highlight! NonText guibg=NONE')

        vim.cmd('highlight DiagnosticOk gui=bold guifg=#629120')

        vim.cmd('highlight clear LspDiagnosticsDefaultError')
        vim.cmd('highlight LspDiagnosticsDefaultError ctermfg=124 guifg=#af0000')

        if vim.o.background == 'dark' then
            vim.cmd('highlight LspDiagnosticsDefaultWarning guifg=#00af5f')
            vim.cmd('highlight LspDiagnosticsUnderlineWarning guisp=#00af5f')
            vim.cmd('highlight Todo guifg=#00af5f')
        end

        vim.cmd('highlight LspDiagnosticsDefaultWarning guibg=NONE')
        for syntax_group, highlight_group in pairs({
            ['CurSearch'] = 'Search',
            ['EndOfBuffer'] = 'NonText',
            ['LowerCaseNote'] = 'Todo',
            ['ErrorMsg'] = 'LspDiagnosticsDefaultError',
            ['NormalFloat'] = 'Pmenu',
            ['DiagnosticFloatingError'] = 'LspDiagnosticsDefaultError',

            ['DiagnosticFloatingHint'] = 'LspDiagnosticsDefaultWarning',
            ['DiagnosticFloatingInfo'] = 'LspDiagnosticsDefaultWarning',
            ['DiagnosticFloatingWarn'] = 'LspDiagnosticsDefaultWarning',
            ['LspDiagnosticsDefaultHint'] = 'LspDiagnosticsDefaultWarning',
            ['LspDiagnosticsDefaultInformation'] = 'LspDiagnosticsDefaultWarning',
            ['LspInlayHint'] = 'Comment',

            ['@class'] = 'NONE',
            ['@comment'] = 'Comment',
            ['@enum'] = 'Constant',
            ['@keyword'] = 'Keyword',
            ['@keyword.conditional'] = 'Conditional',
            ['@keyword.import'] = 'Include',
            ['@keyword.repeat'] = 'Repeat',
            ['@macro'] = 'Macro',
            ['@module'] = 'NONE',
            ['@namespace'] = 'NONE',
            ['@parameter'] = 'NONE',
            ['@preproc'] = 'NONE',
            ['@property'] = 'NONE',
            ['@punctuation.bracket'] = 'NONE',
            ['@punctuation.special'] = 'Keyword',
            ['@punctuation.delimiter'] = 'NONE',
            ['@type'] = 'NONE',
            ['@type.builtin'] = 'Type',
            ['@typeParameter'] = 'Constant',
            ['@variable'] = 'NONE',

            ['@text.uri.comment'] = 'NONE',

            ['@lsp.type.class'] = 'NONE',
            ['@lsp.type.comment.lua'] = 'NONE',
            ['@lsp.type.enum'] = 'Constant',
            ['@lsp.type.function'] = 'NONE',
            ['@lsp.type.macro'] = 'Macro',
            ['@lsp.type.namespace'] = 'NONE',
            ['@lsp.type.parameter'] = 'NONE',
            ['@lsp.type.property'] = 'NONE',
            ['@lsp.type.typeParameter'] = 'Constant',
            ['@lsp.type.variable'] = 'NONE',

            ['@property.cpon'] = 'Identifier',

            ['@comment.error.comment'] = '@comment.todo.comment',

            ['@constant.builtin.nil'] = '@keyword',
            ['@keyword.import.bash'] = '@keyword',
            ['@keyword.return.cpp'] = 'Statement',
            ['@lsp.mod.deduced.cpp'] = 'Type',
            ['@lsp.type.typeParameter.cpp'] = 'NONE',
            ['@type.qualifier.c'] = 'cStorageClass',
            ['@type.qualifier.cpp'] = 'cStorageClass',

            ['@markup.heading.1.markdown'] = 'markdownH1',
            ['@markup.heading.2.markdown'] = 'markdownH2',
            ['@markup.heading.3.markdown'] = 'htmlH3',
            ['@markup.heading.4.markdown'] = 'markdownH2',
            ['@markup.heading.5.markdown'] = 'markdownH2',
            ['@markup.heading.6.markdown'] = 'markdownH2',
            ['@markup.heading.1.hash.markdown'] = 'Delimiter',
            ['@markup.heading.2.hash.markdown'] = 'Delimiter',
            ['@markup.heading.3.hash.markdown'] = 'Delimiter',
            ['@markup.heading.4.hash.markdown'] = 'Delimiter',
            ['@markup.heading.5.hash.markdown'] = 'Delimiter',
            ['@markup.heading.6.hash.markdown'] = 'Delimiter',
            ['@markup.link.label.markdown_inline'] = 'markdownLinkText',
            ['@markup.link.markdown_inline'] = 'markdownUrl',
            ['@markup.raw.markdown_inline'] = 'markdownCode',

            ['@function.method.vue'] = 'htmlArg',
            ['@tag.attribute.vue'] = 'htmlArg',
            ['@tag.vue'] = 'htmlTagName',
            ['@variable.member.vue'] = 'htmlArg',
        }) do
            vim.cmd(('highlight! link %s %s'):format(syntax_group, highlight_group))
        end

        vim.cmd('highlight @keyword.constexpr cterm=nocombine gui=nocombine')

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
