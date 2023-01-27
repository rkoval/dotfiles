if not pcall(require, 'cmp') then
  return
end

local luasnip = require('luasnip')

require('luasnip.loaders.from_lua').lazy_load({ paths = '~/dotfiles/nvim/lua/ryankoval/snippets' })

local function leave_snippet()
  if
    vim.v.event.old_mode == 'i'
    and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
    and not luasnip.session.jump_active
  then
    luasnip.unlink_current()
  end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_create_autocmd('ModeChanged', {
  callback = leave_snippet,
})

luasnip.filetype_extend('typescript', { 'javascript' })
luasnip.filetype_extend('typescriptreact', { 'javascript' })
luasnip.filetype_extend('typescriptreact', { 'javascriptreact' })
