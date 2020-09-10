" jsonc syntax file
" Copied from the default json syntax file but comments are not errors.

if !exists('main_syntax')
  " quit when a syntax file was already loaded
  if exists('b:current_syntax')
    finish
  endif
  let main_syntax = 'jsonc'
endif

syntax match   jsoncNoise           /\%(:\|,\)/

" NOTE that for the concealing to work your conceallevel should be set to 2

" Syntax: jsonc Keywords
" Separated into a match and region because a region by itself is always greedy
syn match  jsoncKeywordMatch /"\([^"]\|\\\"\)\+"[[:blank:]\r\n]*\:/ contains=jsoncKeyword
syn region  jsoncKeyword matchgroup=jsoncQuote start=/"/  end=/"\ze[[:blank:]\r\n]*\:/ contained

" Syntax: Strings
" Separated into a match and region because a region by itself is always greedy
" Needs to come after keywords or else a jsonc encoded string will break the
" syntax
syn match  jsoncStringMatch /"\([^"]\|\\\"\)\+"\ze[[:blank:]\r\n]*[,}\]]/ contains=jsoncString
	syn region  jsoncString oneline matchgroup=jsoncQuote start=/"/  skip=/\\\\\|\\"/  end=/"/ contains=jsoncEscape contained

" Syntax: jsonc does not allow strings with single quotes, unlike JavaScript.
syn region  jsoncStringSQError oneline  start=+'+  skip=+\\\\\|\\"+  end=+'+


" Syntax: Escape sequences
syn match   jsoncEscape    "\\["\\/bfnrt]" contained
syn match   jsoncEscape    "\\u\x\{4}" contained

" Syntax: Numbers
syn match   jsoncNumber    "-\=\<\%(0\|[1-9]\d*\)\%(\.\d\+\)\=\%([eE][-+]\=\d\+\)\=\>\ze[[:blank:]\r\n]*[,}\]]"

" ERROR WARNINGS **********************************************
if (!exists('g:vim_jsonc_warnings') || g:vim_jsonc_warnings==1)
	" Syntax: Strings should always be enclosed with quotes.
	syn match   jsoncNoQuotesError  "\<[[:alpha:]][[:alnum:]]*\>"
	syn match   jsoncTripleQuotesError  /"""/

	" Syntax: An integer part of 0 followed by other digits is not allowed.
	syn match   jsoncNumError  "-\=\<0\d\.\d*\>"

	" Syntax: Decimals smaller than one should begin with 0 (so .1 should be 0.1).
	syn match   jsoncNumError  "\:\@<=[[:blank:]\r\n]*\zs\.\d\+"

	" Syntax: No semicolons in jsonc
	syn match   jsoncSemicolonError  ";"

	" Syntax: No trailing comma after the last element of arrays or objects
	syn match   jsoncTrailingCommaError  ",\_s*[}\]]"

	" Syntax: Watch out for missing commas between elements
	syn match   jsoncMissingCommaError /\("\|\]\|\d\)\zs\_s\+\ze"/
	syn match   jsoncMissingCommaError /\(\]\|\}\)\_s\+\ze"/ "arrays/objects as values
	syn match   jsoncMissingCommaError /}\_s\+\ze{/ "objects as elements in an array
	syn match   jsoncMissingCommaError /\(true\|false\)\_s\+\ze"/ "true/false as value
endif

" Syntax: Comments
syn match   jsoncComment  "//.*"
syn region   jsoncComment  start=/\/\*/ end=/\*\//

" ********************************************** END OF ERROR WARNINGS
" Allowances for jsoncP: function call at the beginning of the file,
" parenthesis and semicolon at the end.
" Function name validation based on
" http://stackoverflow.com/questions/2008279/validate-a-javascript-function-name/2008444#2008444
syn match  jsoncPadding "\%^[[:blank:]\r\n]*[_$[:alpha:]][_$[:alnum:]]*[[:blank:]\r\n]*("
syn match  jsoncPadding ");[[:blank:]\r\n]*\%$"

" Syntax: Boolean
syn match  jsoncBoolean /\(true\|false\)\(\_s\+\ze"\)\@!/

" Syntax: Null
syn keyword  jsoncNull      null

" Syntax: Braces
syn region  jsoncFold matchgroup=jsoncBraces start="{" end=/}\(\_s\+\ze\("\|{\)\)\@!/ transparent fold
syn region  jsoncFold matchgroup=jsoncBraces start="\[" end=/]\(\_s\+\ze"\)\@!/ transparent fold

" Define the default highlighting.
" Only when an item doesn't have highlighting yet
hi def link jsoncPadding         Operator
hi def link jsoncString          String
hi def link jsoncTest          Label
hi def link jsoncEscape          Special
hi def link jsoncNumber          Number
hi def link jsoncBraces          Delimiter
hi def link jsoncNull            Function
hi def link jsoncBoolean         Boolean
hi def link jsoncKeyword         Label
hi def link jsoncComment         Comment

if (!exists('e:vim_jsonc_warnings') || g:vim_jsonc_warnings==1)
hi def link jsoncNumError        Error
hi def link jsoncSemicolonError  Error
hi def link jsoncTrailingCommaError     Error
hi def link jsoncMissingCommaError      Error
hi def link jsoncStringSQError        	Error
hi def link jsoncNoQuotesError        	Error
hi def link jsoncTripleQuotesError     	Error
endif
hi def link jsoncQuote           Quote
hi def link jsoncNoise           Noise

let b:current_syntax = 'jsonc'
if main_syntax ==# 'jsonc'
  unlet main_syntax
endif

" Vim settings
" vim: ts=8 fdm=marker

" MIT License
" Copyright (c) 2013, Jeroen Ruigrok van der Werven, Eli Parra
"Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the Software), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
"The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
"THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
"See https://twitter.com/elzr/status/294964017926119424
