let g:deoplete#enable_at_startup = 1

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['neosnippet']

call deoplete#custom#source('buffer', 'mark', 'ℬ')
call deoplete#custom#source('omni', 'mark', '⌾')
call deoplete#custom#source('file', 'mark', '')
call deoplete#custom#source('jedi', 'mark', '')
call deoplete#custom#source('neosnippet', 'mark', '')
call deoplete#custom#source('typescript',  'rank', 630)

autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml,markdown setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
