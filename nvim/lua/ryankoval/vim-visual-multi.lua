-- vim.g.VM_maps = {}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<D-d>', '<Plug>(VM-Find-Under)', opts)
vim.keymap.set('v', '<D-d>', '<Plug>(VM-Visual-Add)', opts)
vim.keymap.set('n', '<D-S-d>', '<Plug>(VM-Select-All)', opts)
vim.keymap.set('v', '<D-S-d>', '<Plug>(VM-Visual-All)', opts)
