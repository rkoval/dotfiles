" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#max_list = 50
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\v(\.md|\.txt|\.git\/COMMIT_EDITMSG)'

set completeopt-=preview                        " disable preview window
let g:neocomplete#enable_auto_close_preview = 1 " automatically close preview window
set splitbelow                                  " preview should show up below, not above

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <expr><D-Enter> neocomplete#start_manual_complete()
let g:neocomplete#enable_auto_delimiter = 1

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><C-j>  pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k>  pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  pumvisible() ? neocomplete#smart_close_popup()."\<BS>" : delimitMate#BS()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
if !exists('g:neocomplete#sources#omni#functions')
  let g:neocomplete#sources#omni#functions = {}
endif
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
inoremap <expr><C-Space> neocomplete#start_manual_complete()

let g:neocomplete#keyword_patterns._ = '\h\k*(\?'
" let g:neocomplete#keyword_patterns.default = '\h\w*'

" python
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python let g:jedi#auto_vim_configuration = 0
autocmd FileType python let g:jedi#popup_on_dot = 0
autocmd FileType python let g:jedi#completions_enabled = 0
autocmd FileType python let g:jedi#smart_auto_mappings = 0
autocmd FileType python let g:jedi#goto_assignments_command="gd"
autocmd FileType python let g:jedi#goto_command="gD"
autocmd FileType python let g:jedi#show_call_signatures = "0"
let g:neocomplete#sources#omni#input_patterns.python =
	\ '[^. *\t]\.\w*\|\h\w*'
" autocmd FileType python let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" html / xml / markdown
autocmd FileType html,markdown,javascript,javascript.jsx let g:neocomplete#keyword_patterns.html = '</\?\%([[:alnum:]_:-]\+\s*\)\?\%(/\?>\)\?\|&\h\%(\w*;\)\?\|\h[[:alnum:]_:-]*'
autocmd FileType html,markdown,javascript,javascript.jsx setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml,markdown setlocal omnifunc=xmlcomplete#CompleteTags

" css
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS

" javascript
autocmd FileType javascript,javascript.jsx let g:neocomplete#force_omni_input_patterns.javascript =
	\ '[^. \t]\.\w*'
autocmd FileType javascript,javascript.jsx let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'
autocmd FileType javascript,javascript.jsx let g:neocomplete#sources#omni#functions.javascript = [
    \   'tern#Complete',
    \ ]
autocmd FileType javascript,javascript.jsx setlocal omnifunc=tern#Complete

" go
autocmd FileType go setlocal omnifunc=gocode#Complete
" autocmd FileType go let g:neocomplete#force_omni_input_patterns.go = '[^.[:digit:] *\t]\.'
autocmd FileType go let g:neocomplete#sources#omni#input_patterns.go =
	\ '[^.[:digit:] *\t]\.\w*'
