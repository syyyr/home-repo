vim.loader.enable()
-- skeletons for new files
require('skeleton')
-- custom commands, and their associated mappings
require('commands')
-- simple vim options "set smth="
require('options')
-- advanced vim options
require('startup')
-- simple mappings
require('mappings')
-- syntax highlighting and various color changes
require('colors')
-- plugins and their options
require('plugins')
-- syntax highlighting via treesitter
require('treesitter')
-- LSP settings
require('lsp')
