nnoremap <silent> gd :w!<cr>:GoDef<cr>
nnoremap <silent> gb :w!<cr>:GoDefPop<cr>
nnoremap <D-S-i> <Plug>(go-implements)
nnoremap <S-F6> :wa<cr>:GoRename<cr>
nnoremap gr :GoReferrers<cr>


au FileType go nmap <S-C-P> <Plug>(go-info)

" syntastic fix
let g:go_list_type = "locationlist"

" use goimports instead of gofmt
let g:go_fmt_command = "goimports"

" By default syntax-highlighting for Functions, Methods and Structs is disabled.
" Let's enable them!
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_snippet_engine = "neosnippet"
let g:go_gorename_prefill = 0
let g:go_guru_tags="integration"
