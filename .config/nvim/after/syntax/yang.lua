vim.cmd('syntax keyword yangTodo TODO contained')
vim.cmd('highlight link yangTodo Todo')
vim.cmd([[syntax region yangComment start=+/\*+ end=+\*/+  contains=@Spell,yangTodo]])
vim.cmd([[syntax region yangComment start=+//+ end=/$/     contains=@Spell,yangTodo]])
