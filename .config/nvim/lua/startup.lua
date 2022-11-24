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
    callback = function()
        vim.cmd([[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
    end,
    group = vim.api.nvim_create_augroup('LastPostion', {clear = true})
})

vim.api.nvim_create_autocmd({'BufReadPost', 'TextChanged', 'InsertLeave'}, {
    callback = function()
        local id = vim.fn.jobstart({'grep', '-n', '-m', '1', '\\s$'}, {
            on_stdout = function(_, data)
                local first_line = data[1]
                local startIndex, endIndex = first_line:find('%d+')
                if not startIndex then
                    vim.b.TrailingNr = ''
                else
                    vim.b.TrailingNr = first_line:sub(startIndex, endIndex)
                end
            end,
            stdout_buffered = 1
        })
        vim.fn.chansend(id, vim.api.nvim_buf_get_lines(0, 0, -1, true))
        vim.fn.chanclose(id, 'stdin')
    end,
    group = vim.api.nvim_create_augroup('StatuslineIntegration', {clear = true})
})

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        vim.cmd([[execute "if search('^	', 'n') | set noexpandtab | set tabstop=4 | else | set softtabstop=4 | set expandtab | endif"]])
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

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
