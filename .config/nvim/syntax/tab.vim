if exists("b:current_syntax")
  finish
endif

syntax match tabSpecial "[a-z]" contained
syntax match tabNote "[a-z0-9]\+" contained contains=tabSpecial
syntax match tabStart "^[eBGDCAE]|" contained
syntax region tabTabLine start="^[eBGDCAE]|-" end="$" contains=CONTAINED oneline contained

syntax match tabText "^.\([^|].*\)\?" contains=tabTabLine,tabTextNote

hi link tabText Question
hi link tabStart Type
hi link tabSpecial Operator
hi link tabNote Number
hi tabTabLine ctermfg=14 gui=italic guifg=#808080
