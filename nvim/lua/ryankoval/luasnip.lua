if not pcall(require, 'cmp') then
  return
end

local luasnip = require('luasnip')

require('luasnip.loaders.from_lua').load({ paths = '~/dotfiles/nvim/lua/ryankoval/snippets' })

luasnip.filetype_extend('typescript', { 'javascript' })
luasnip.filetype_extend('typescriptreact', { 'javascript' })
luasnip.filetype_extend('typescriptreact', { 'javascriptreact' })
