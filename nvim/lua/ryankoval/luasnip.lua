if not pcall(require, 'cmp') then
  return
end

local luasnip = require('luasnip')

require('luasnip.loaders.from_lua').load({ paths = '~/dotfiles/nvim/lua/ryankoval/snippets' })
require('luasnip.loaders.from_vscode').load({ paths = '~/dotfiles/nvim/dein/repos/github.com/rafamadriz/friendly-snippets' })

luasnip.filetype_extend('typescript', { 'javascript' })
luasnip.filetype_extend('typescriptreact', { 'javascript' })
