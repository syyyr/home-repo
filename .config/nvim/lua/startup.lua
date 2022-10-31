-- set dark theme at night
local nightstart = os.getenv('NIGHTSTART') and tonumber(os.getenv('NIGHTSTART')) or 22
local daystart = os.getenv('DAYSTART') and tonumber(os.getenv('DAYSTART')) or 8
local current_hour = tonumber(os.date('%H'))
if current_hour < daystart or current_hour >= nightstart then
    vim.o.background = 'dark'
else
    vim.o.background = 'light'
end

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function ()
        vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
    end,
    group = vim.api.nvim_create_augroup('LastPostion', {clear = true})
})

vim.api.nvim_create_autocmd({'BufReadPost', 'TextChanged', 'InsertLeave'}, {
    callback = function ()
        Custom.trailing_ws_check()
    end,
    group = vim.api.nvim_create_augroup('StatuslineIntegration', {clear = true})
})

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function ()
        vim.cmd([[execute "if search('^	', 'n') | set noexpandtab | set tabstop=4 | else | set softtabstop=4 | set shiftwidth=4 | set expandtab | endif"]])
    end,
    group = vim.api.nvim_create_augroup('TabsOrSpaces', {clear = true})
})

vim.g.tex_flavor = 'tex'
vim.g.is_bash = 1
vim.g.markdown_syntax_conceal = 0

vim.g.clipboard = {
    name = 'myClipboard',
    copy = {
        ['+'] = {'xclip', '-i', '-selection', 'clipboard'},
        ['*'] = {'xclip', '-i', '-selection', 'primary'},
    },
    paste = {
        ['+'] = {'xclip', '-o', '-selection', 'clipboard'},
        ['*'] = {'xclip', '-o', '-selection', 'primary'},
    },
    cache_enabled = 1,
}
