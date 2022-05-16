local telescope = require('telescope.builtin')
local Files = require('ryankoval.util.files')

local map_options = {
  noremap = true,
  silent = true,
}
local map_tele = function(key, f, options)
  options = options or {}
  function callback()
    local default_text = options.construct_default_text and options.construct_default_text() or nil
    telescope[f]({
      default_text = default_text,
    })
  end

  vim.keymap.set('n', key, callback, map_options)
end

local function filename_default_text()
  return Files.get_current_filename_without_extension()
end
local function cword_default_text()
  return vim.fn.expand('<cword>')
end

map_tele('<leader>t', 'find_files')
map_tele('gw', 'find_files', {
  construct_default_text = cword_default_text,
})
map_tele('<leader>E', 'current_dir_files')
map_tele('<leader>b', 'buffers')
map_tele('<leader>B', 'oldfiles')
map_tele('<leader><leader>h', 'help_tags')
map_tele('<leader>l', 'diagnostics')
map_tele('<leader><leader>b', 'resume')
map_tele('<leader><leader>d', 'dotfiles')
map_tele('<leader>a', 'custom_grep')
map_tele('<leader>/', 'live_grep')
map_tele('<D-S-R>', 'treesitter')
map_tele('<leader>*', 'live_grep', {
  construct_default_text = cword_default_text,
})
