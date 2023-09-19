vim.cmd([[
  augroup dosini_ft
    autocmd!
    autocmd BufRead,BufNewFile .flowconfig,.pylintrc,airflow.cfg set filetype=dosini
  augroup END
]])
