" XML folding
let g:xml_syntax_folding=1

" formatting XML
setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
