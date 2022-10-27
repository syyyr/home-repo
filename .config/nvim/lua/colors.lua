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

local function get_statusline_colors()
    if vim.o.background == 'dark' then
        return 'guifg=#d0d0d0 guibg=#1c1c1c ctermfg=252 ctermbg=234'
    else
        return 'guifg=#444444 guibg=#eeeeee ctermfg=255 ctermbg=238'
    end
end

-- PaperColor overrides
local status_underline = vim.api.nvim_create_augroup('StatusUnderline', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'PaperColor',
    callback = function() vim.cmd('highlight StatusLineNC ' .. get_statusline_colors() .. ' cterm=underline gui=underline') end,
    group = status_underline
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'PaperColor',
    callback = function() vim.cmd('highlight StatusLine ' .. get_statusline_colors() .. ' cterm=underline,bold gui=underline,bold') end,
    group = status_underline
})

local function get_vertsplit_colors()
    if vim.o.background == 'dark' then
        return 'guifg=#1c1c1c guibg=#d0d0d0 ctermfg=252 ctermbg=234'
    else
        return 'guifg=#eeeeee guibg=#444444 ctermfg=255 ctermfg=238'
    end
end

local vert_split = vim.api.nvim_create_augroup('VertSplit', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'PaperColor',
    callback = function() vim.cmd('highlight VertSplit ' .. get_vertsplit_colors() .. ' cterm=underline gui=underline') end,
    group = vert_split
})

local end_of_buffer = vim.api.nvim_create_augroup('EndOfBuffer', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'PaperColor',
    callback = function ()
        vim.cmd('highlight clear EndOfBuffer')
        vim.cmd('highlight link EndOfBuffer NonText')
    end,
    group = end_of_buffer
})

local merge_conflict = vim.api.nvim_create_augroup('MergeConflict', {clear = true})
vim.api.nvim_create_autocmd('Syntax', {
    command = [[syn match MergeConflict '\v^[<\|=|>]{7}([^=].+)?$']],
    group = merge_conflict
})
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'PaperColor',
    command = 'highlight MergeConflict ctermbg=black ctermfg=red guibg=black guifg=red',
    group = merge_conflict
})

local todo_color = vim.api.nvim_create_augroup('TodoColor', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'PaperColor',
    command = 'highlight Todo cterm=bold ctermfg=0 ctermbg=11 gui=bold guifg=#00af5f guibg=default',
    group = todo_color
})

local lsp_colors = vim.api.nvim_create_augroup('LspColors', {clear = true})
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'PaperColor',
    callback = function ()
        vim.cmd('highlight clear LspDiagnosticsDefaultError')
        vim.cmd('highlight LspDiagnosticsDefaultError ctermfg=124 guifg=#af0000')
        vim.cmd('highlight clear LspDiagnosticsDefaultWarning')
        vim.cmd('highlight LspDiagnosticsDefaultWarning gui=bold guifg=#00af5f')
        vim.cmd('highlight clear LspDiagnosticsDefaultInformation')
        vim.cmd('highlight LspDiagnosticsDefaultInformation gui=bold guifg=#00af5f')
        vim.cmd('highlight clear LspDiagnosticsDefaultHint')
        vim.cmd('highlight LspDiagnosticsDefaultHint gui=bold guifg=#00af5f')
    end,
    group = lsp_colors
})

vim.cmd('colorscheme PaperColor')
