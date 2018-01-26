let g:vimpy_remove_unused = 1
let g:vimpy_prompt_resolve = 0

augroup AutoimportPython
  autocmd!
  autocmd BufWritePre *.py silent! VimpyCheckLine
augroup END
