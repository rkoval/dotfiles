vim.cmd([[
  augroup nginx_ft
    autocmd!
    autocmd BufRead,BufNewFile *nginx.conf* set filetype=nginx
  augroup END
]])
