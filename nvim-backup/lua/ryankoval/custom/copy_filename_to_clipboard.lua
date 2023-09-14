local Files = require('ryankoval.util.files')

function copy_filename_to_clipboard(include_cword)
  local filename = Files.get_current_filename_without_extension()
  if not filename then
    return
  end
  vim.fn.setreg('+', filename, 'c')
end

function copy_filename_with_cword_to_clipboard()
  local filename = Files.get_current_filename_without_extension()
  if not filename then
    return
  end
  vim.fn.setreg('+', filename .. '.' .. vim.fn.expand('<cword>'), 'c')
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>C', copy_filename_to_clipboard, opts)
vim.keymap.set('n', '<leader><leader>C', copy_filename_with_cword_to_clipboard, opts)
