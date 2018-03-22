let g:deoplete#sources#ternjs#filetypes = [
	\ 'jsx',
	\ 'javascript.jsx',
	\ 'vue',
	\ 'javascript'
	\ ]

let g:deoplete#sources#ternjs#timeout = 3
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#file#enable_buffer_path=1
call deoplete#custom#source('tern', 'mark', '')
