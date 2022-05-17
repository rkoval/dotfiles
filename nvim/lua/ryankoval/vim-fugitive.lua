vim.keymap.set('n', '<leader>ha', ':Git blame<cr>', {
  noremap = true,
})
vim.keymap.set('n', '<leader>gs', ':Git<CR><C-w>20+', {
  noremap = true,
})
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }
