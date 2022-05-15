local Files = require('ryankoval.util.files')

local function javascript(selection)
  return "console.log('" .. selection:gsub("'", "\\'") .. "', " .. selection .. ')'
end

local function lua(selection)
  return 'vim.pretty_print(' .. selection .. ')'
end

local filetype_handlers = {
  ['javascript'] = javascript,
  ['typescript'] = javascript,
  ['lua'] = lua,
}

local function get_indentation()
  local line = vim.api.nvim_get_current_line()
  local start_index, end_index = line:find('^%s*')
  local indentation = string.sub(line, start_index, end_index)
  return indentation
end

local function add_log()
  local filetype = vim.bo.filetype
  local handler = filetype_handlers[filetype]
  if not handler then
    return
  end
  local selection = Files.get_visual_selection() or vim.fn.expand('<cword>')
  local text = handler(selection)
  local indentation = get_indentation()
  vim.fn.append('.', indentation .. text)
end

local opts = { noremap = true, silent = true, callback = add_log }
vim.api.nvim_set_keymap('n', '<D-S-l>', '', opts)
vim.api.nvim_set_keymap('v', '<D-S-l>', '', opts)
