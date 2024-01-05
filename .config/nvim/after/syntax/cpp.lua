vim.cmd('syn clear cStatement')
vim.cmd('syn keyword cStatement break return continue asm')
vim.cmd('syntax keyword Error goto')
vim.cmd([[syn keyword LowerCaseNote Note contained containedin=cCommentL]])
