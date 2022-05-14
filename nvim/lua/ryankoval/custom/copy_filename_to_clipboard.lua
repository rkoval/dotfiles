local Path = require('plenary.path')
local opts = { noremap = true, silent = true }

function get_current_buffer_filename()
  local path = vim.api.nvim_buf_get_name(0)
  local split_path = vim.split(path, Path.path.sep, true)
  local filename_with_extension = split_path[#split_path]
  local filename = vim.split(filename_with_extension, '.', true)[1]
  return filename
end

function copy_filename_to_clipboard(include_cword)
  local filename = get_current_buffer_filename()
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

vim.keymap.set('n', '<leader>C', copy_filename_to_clipboard, opts)
vim.keymap.set('n', '<leader><leader>C', copy_filename_with_cword_to_clipboard, opts)
