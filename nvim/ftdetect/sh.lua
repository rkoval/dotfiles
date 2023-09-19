vim.cmd([[
  augroup sh_ft
    autocmd!
    autocmd BufRead,BufNewFile */s6-services/*,*/cont-init.d/* set filetype=sh
  augroup END
]])
