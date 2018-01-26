" " <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<C-n>"
	\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
	\ : (<SID>is_whitespace() ? "\<Tab>"
	\ : neocomplete#start_manual_complete()))

smap <silent><expr><Tab> pumvisible() ? "\<C-n>"
	\ : (neosnippet#jumpable() ? "\<Plug>(neosnippet_jump)"
	\ : (<SID>is_whitespace() ? "\<Tab>"
	\ : neocomplete#start_manual_complete()))

inoremap <expr><S-Tab>  pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:is_whitespace()
	let col = col('.') - 1
	return ! col || getline('.')[col - 1] =~? '\s'
endfunction

let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['javascript'] = 'javascript,javascript.jsx,javascript.es6'

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1
" let g:neosnippet#disable_runtime_snippets = {'_' : 1}
let g:neosnippet#snippets_directory=[
\ '~/.vim/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets',
\ '~/.vim/dein/repos/github.com/fatih/vim-go/gosnippets/snippets',
\ '~/.vim/snippets'
\]
