
runtime skeleton.lua
" custom commands, and their associated mappings
runtime commands.vim
" plugins and their options
runtime plugins.lua
" simple vim options "set smth="
if len(nvim_list_uis())
    runtime options.vim
    " advanced vim options
    runtime startup.lua
    " simple mappings
    runtime mappings.vim
    " syntax highlighting and various color changes
    runtime colors.vim
endif
