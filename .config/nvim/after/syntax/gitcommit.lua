vim.cmd([[syn clear gitcommitSummary]])
vim.cmd([[syn match gitcommitSummary "^.*\%<81v." contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell]])
