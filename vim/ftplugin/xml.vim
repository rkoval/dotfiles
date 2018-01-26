" XML folding
let g:xml_syntax_folding=1
setlocal foldmethod=manual
setlocal foldlevel=50
setlocal fdc=1

" formatting XML
setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
