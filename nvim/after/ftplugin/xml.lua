" XML folding
vim.g.xml_syntax_folding = 1

" formatting XML
vim.bo.equalprg = "xmllint --format --recover - 2>/dev/null"