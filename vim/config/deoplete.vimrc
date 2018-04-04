let g:deoplete#enable_at_startup = 1

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['neosnippet']

call deoplete#custom#source('buffer', 'mark', 'ℬ')
call deoplete#custom#source('omni', 'mark', '⌾')
call deoplete#custom#source('file', 'mark', '')
call deoplete#custom#source('jedi', 'mark', '')
call deoplete#custom#source('neosnippet', 'mark', '')
call deoplete#custom#source('typescript',  'rank', 630)
call deoplete#custom#source('LanguageClient',  'sorters', ['sorter_rank'])
call deoplete#custom#source('LanguageClient',  'rank', 400)
call deoplete#custom#source('LanguageClient',  'min_pattern_length', 2)

autocmd FileType html,markdown setlocal omnifunc=
autocmd FileType xml,markdown setlocal omnifunc=
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
