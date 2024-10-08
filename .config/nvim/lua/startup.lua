local nightstart = os.getenv('NIGHTSTART') and tonumber(os.getenv('NIGHTSTART')) or 22
local daystart = os.getenv('DAYSTART') and tonumber(os.getenv('DAYSTART')) or 8
local current_hour = tonumber(os.date('%H'))
if current_hour < daystart or current_hour >= nightstart then
    vim.opt.background = 'dark'
else
    vim.opt.background = 'light'
end

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    group = vim.api.nvim_create_augroup('LastPostion', {clear = true})
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'gitcommit,gitrebase',
    callback = function()
        vim.api.nvim_win_set_cursor(0, {1, 0})
    end,
    group = vim.api.nvim_create_augroup('LastPostionGit', {clear = true})
})

local statusline_augroup = vim.api.nvim_create_augroup('StatuslineIntegration', {clear = true})

vim.api.nvim_create_autocmd({'BufReadPost', 'TextChanged', 'InsertLeave'}, {
    callback = function()
        vim.system({'grep', '--line-number', '--max-count', '1', [[\s$]]}, {
            stdin = vim.fn.join(vim.api.nvim_buf_get_lines(0, 0, -1, true), "\n"),
        }, function(res)
                if res.code ~= 0 then
                    vim.b.TrailingNr = nil
                else
                    local startIndex, endIndex = res.stdout:find('%d+')
                    vim.b.TrailingNr = startIndex and res.stdout:sub(startIndex, endIndex) or ''
                end
                vim.defer_fn(vim.cmd.redrawstatus, 0)
            end
        )
    end,
    group = statusline_augroup
})

vim.api.nvim_create_autocmd('DiagnosticChanged', {
    callback = function()
        if vim.api.nvim_buf_is_loaded(0) then
            vim.cmd.redrawstatus()
        end
    end,
    group = statusline_augroup
})

vim.filetype.add({
    extension = {
        cpon = 'cpon',
        tab = 'tab'
    }
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
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.netrw_banner = 0

vim.g.python_recommended_style = 0
