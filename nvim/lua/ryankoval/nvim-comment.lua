require('nvim_comment').setup({ create_mappings = false })

local opts = { silent = true }
vim.keymap.set('n', '<D-/>', ':CommentToggle<cr><Up>', opts)
vim.keymap.set('v', '<D-/>', ':CommentToggle<cr>', opts)
vim.keymap.set('i', '<D-/>', ':CommentToggle<cr>', opts)
