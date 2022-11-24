vim.wo.statusline =
    '%=%=' .. -- Separators.
    [[%20{exists('w:quickfix_title')? ' '.w:quickfix_title : '[no command]'}]] .. -- Show Quickfix title
    '%r' .. -- Show [RO] sign.
    ' ' .. -- A literal space.
    '%-30.' .. -- Add minimal width.
    '(ln %l col %c%)' .. -- Show line number and column number.
    '%=' .. -- Separator.
    '%#StatusLineNC#' .. -- Set highlight group
    'Quickfix' .. -- Literal "Quickfix", as a filetype.
    '%='-- Separator.
