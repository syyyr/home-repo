syn keyword yangTodo TODO contained
hi link yangTodo Todo
syn region yangComment start=+/\*+ end=+\*/+  contains=@Spell,yangTodo
syn region yangComment start=+//+ end=/$/     contains=@Spell,yangTodo
