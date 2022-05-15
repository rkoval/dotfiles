local Files = require('ryankoval.util.files')

function copy_filename_to_clipboard(include_cword)
  local filename = Files.get_filename_without_extension(vim.api.nvim_buf_get_name(0))
  if not filename then
    return
  end
  vim.fn.setreg('+', filename, 'c')
end

function copy_filename_with_cword_to_clipboard()
  local filename = get_current_buffer_filename()
  if not filename then
    return
  end
  vim.fn.setreg('+', filename .. '.' .. vim.fn.expand('<cword>'), 'c')
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>C', copy_filename_to_clipboard, opts)
vim.keymap.set('n', '<leader><leader>C', copy_filename_with_cword_to_clipboard, opts)
