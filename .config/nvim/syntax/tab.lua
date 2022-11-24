if vim.b.current_syntax then
    return
end

vim.cmd([[syntax match tabSpecial '[a-z]' contained]])
vim.cmd([[syntax match tabNote '[a-z0-9]\+' contained contains=tabSpecial]])
vim.cmd([[syntax match tabStart '^[a-gA-G][#b ]\?|' contained]])
vim.cmd([[syntax region tabTabLine start='^[a-gA-G][#b ]\?|-' end='$' contains=CONTAINED oneline contained]])

vim.cmd([[syntax match tabText '^.\([^|].*\)\?' contains=tabTabLine,tabTextNote]])

vim.cmd('highlight link tabText Question')
vim.cmd('highlight link tabStart Type')
vim.cmd('highlight link tabSpecial Operator')
vim.cmd('highlight link tabNote Number')
vim.cmd('highlight tabTabLine ctermfg=14 gui=italic guifg=#808080')
