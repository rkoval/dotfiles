vim.g.gui_font_default_size = 13
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = 'Anonymice Nerd Font Mono'

RefreshGuiFont = function()
  vim.opt.guifont = string.format('%s:h%s', vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'i' }, '<D-=>', function()
  ResizeGuiFont(1)
end, opts)
vim.keymap.set({ 'n', 'i' }, '<D-->', function()
  ResizeGuiFont(-1)
end, opts)
vim.keymap.set({ 'n', 'i' }, '<D-0>', function()
  ResetGuiFont()
end, opts)
