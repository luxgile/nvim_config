" Clear any existing syntax (good practice)
syn clear

" Keywords
syn keyword honey_keyword if loop fn struct enum

" Comments
syn match honey_comment "#.*"
syn region honey_multi_comment start="#+" end="+#"

" Strings
syn region honey_string start=/"/ skip=/\\"/ end=/"/

" Numbers
syn match honey_number "\<\d\+\(\.\d\+\)\?\>"
syn keyword honey_bool true false

syn keyword honey_primitives Int RawString Bool Float Void
syn match honey_type /\<[A-Z][a-zA-Z0-9_]*\>/
syn match honey_identifier /\<[a-z_][a-zA-Z0-9_]*\>/
syn match honey_fn "\<\h\w*\>(<tex>$[^)]*$</tex>)" contains=honey_string,honey_number
syn match honey_meta /\<@[a-z_][a-zA-Z0-9_]*\>/

" Functions (example: identifying a function call)
" syn match yourLanguageFunction "\<\h\w*\>(<tex>$[^)]*$</tex>)" contains=yourLanguageString,yourLanguageNumber

" Linking to standard highlight groups
" These are the standard highlight groups themes use
hi def link honey_keyword Keyword
hi def link honey_comment Comment
hi def link honey_multi_comment Comment
hi def link honey_string String
hi def link honey_number Number
hi def link honey_bool Boolean
hi def link honey_primitives Type
hi def link honey_type Type
hi def link honey_identifier Identifier
hi def link honey_fn Function
hi def link honey_meta Function
" You can define custom highlight groups and link them to existing ones or define their colors directly
" hi yourLanguageMyCustomGroup guifg=#FF0000 ctermfg=Red

" Syncing regions (important for multi-line constructs like comments/strings)
" This tells Vim how far back to look to correctly highlight nested regions.
" Adjust this based on your language's complexity.
syn sync minlines=100
