" custom functions, commands, and their associated mappings (must be first
" since some plugins may use custom functions)
runtime custom_commands.vim
" plugins and their options
runtime plugins_options.vim
" simple mappings, that don't use functions/commands
runtime basic_mapping.vim
" syntax highlighting and various color changes
runtime colors.vim
" filetype specific stuff
runtime filetype.vim
" simple vim options "set smth="
runtime vim_options.vim
" advanced vim options
runtime startup.vim
