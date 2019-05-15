setlocal statusline=%=%=%20{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ '[no\ command]'}%r\ %-30.(ln\ %l\ col\ %c%)%=%#StatusLineNC#Quickfix%=
