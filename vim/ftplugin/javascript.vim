nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <S-F6> :call LanguageClient_textDocument_rename()<CR>

" type information
nnoremap <silent> <S-C-P> :call LanguageClient_textDocument_hover()<CR>

" folding
setlocal foldmethod=manual
setlocal foldlevel=50
setlocal fdc=1
