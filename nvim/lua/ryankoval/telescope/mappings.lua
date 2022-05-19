if not pcall(require, 'telescope') then
  return
end

package.loaded['ryankoval.telescope.mappings'] = nil

local telescope = require('ryankoval.telescope')
local Files = require('ryankoval.util.files')

local map_options = {
  noremap = true,
  silent = true,
}
local map_tele = function(mode, key, f, options)
  options = options or {}
  function fn()
    local default_text = options.construct_default_text and options.construct_default_text() or nil
    telescope[f](vim.tbl_extend('force', options, {
      default_text = default_text,
    }))
  end

  vim.keymap.set(mode, key, fn, map_options)
end

local function filename_default_text()
  return Files.get_current_filename_without_extension()
end
local function selection_default_text()
  return Files.get_selection()
end

map_tele('n', '<leader>t', 'git_files')
map_tele('n', 'gw', 'find_files', {
  construct_default_text = selection_default_text,
})
map_tele('n', '<leader>E', 'current_dir_files')
map_tele('n', '<leader>b', 'buffers')
map_tele('n', '<leader>B', 'oldfiles')
map_tele('n', '<leader><leader>h', 'help_tags')
map_tele('n', '<leader>l', 'diagnostics')
map_tele('n', '<leader><leader>b', 'resume')
map_tele('n', '<leader><leader>d', 'dotfiles')
map_tele('n', '<leader>a', 'custom_grep')
map_tele('n', '<leader>n', 'notifications')
map_tele('n', '<leader>/', 'live_grep')
map_tele('n', '<leader><leader>g', 'git_status')
map_tele('n', '<D-S-r>', 'lsp_dynamic_workspace_symbols', {
  ignore_symbols = { 'variable', 'constant' },
})
map_tele('n', '<leader>*', 'live_grep', {
  construct_default_text = selection_default_text,
})
map_tele('v', '<leader>*', 'live_grep', {
  construct_default_text = selection_default_text,
})
map_tele('n', '<leader>g*', 'live_grep', {
  construct_default_text = filename_default_text,
})
