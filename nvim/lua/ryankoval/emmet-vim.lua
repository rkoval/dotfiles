vim.g.user_emmet_complete_tag = 0
vim.g.user_emmet_install_global = 0
vim.g.user_emmet_install_command = 0
vim.g.user_emmet_mode = 'iv' -- enable emmet functions for `i`nsert and `v`isual

vim.cmd([[
  autocmd FileType html,css,less,scss,vue EmmetInstall
]])

vim.keymap.set('i', '<C-Return>', '<Plug>(emmet-expand-abbr)', { noremap = true, silent = true })
