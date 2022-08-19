local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<D-d>', '<Plug>(VM-Find-Under)', opts)
vim.keymap.set('n', '<D-S-d>', '<Plug>(VM-Select-All)', opts)
