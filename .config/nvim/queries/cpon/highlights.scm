[
  (true)
  (false)
] @constant.builtin.boolean
(null) @constant.builtin
(number) @constant.numeric

(string) @string
(escape_sequence) @constant.character.escape
(ERROR) @error

"," @punctuation.delimiter
[
  "["
  "]"
  "{"
  "}"
  "<"
  ">"
] @punctuation.bracket

(pair
  key: (_) @keyword)
(ipair
  key: (_) @keyword)
(mpair
  key: (_) @keyword)
