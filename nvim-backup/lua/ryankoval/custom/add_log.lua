local Files = require('ryankoval.util.files')

local function javascript(selection)
  return "console.log('" .. selection:gsub("'", "\\'") .. "', " .. selection .. ')'
end

local function lua(selection)
  return "vim.pretty_print('" .. selection:gsub("'", "\\'") .. "', " .. selection .. ')'
end

local function go(selection)
  return 'log.Printf("' .. selection:gsub("'", "\\'") .. ' %#v", ' .. selection .. ')'
end

local function python(selection)
  return 'print("' .. selection:gsub("'", "\\'") .. '", ' .. selection .. ')'
end

local filetype_handlers = {
  ['javascript'] = javascript,
  ['javascriptreact'] = javascript,
  ['typescript'] = javascript,
  ['typescriptreact'] = javascript,
  ['lua'] = lua,
  ['go'] = go,
  ['python'] = python,
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
  local selection = Files.get_selection()
  local text = handler(selection)
  local indentation = get_indentation()
  vim.fn.append('.', indentation .. text)
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<D-S-l>', add_log, opts)
vim.keymap.set('v', '<D-S-l>', add_log, opts)
