TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}

  local mode = 'n'
  local rhs = string.format("<cmd>lua require('ryankoval.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

map_tele('<leader>t', 'find_files')
map_tele('<leader>E', 'current_dir_files')
map_tele('<leader>b', 'buffers')
map_tele('<leader>B', 'oldfiles')
map_tele('<leader><leader>h', 'help_tags')
map_tele('<leader><leader>e', 'lsp_workspace_diagnostics')
map_tele('<leader><leader>b', 'builtin')
map_tele('<leader><leader>d', 'dotfiles')
-- map_tele('<leader>a', 'custom_grep')
map_tele('<leader>/', 'live_grep')
map_tele('<leader>W', 'grep_string')