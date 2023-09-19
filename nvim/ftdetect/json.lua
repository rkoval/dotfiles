vim.cmd([[
  augroup json_ft
    autocmd!
    autocmd BufRead,BufNewFile .babelrc,.eslintrc set filetype=json
  augroup END
]])
