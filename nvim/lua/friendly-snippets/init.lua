if not pcall(require, 'cmp') then
  return
end

-- we want this file to be separate from our other snippets so that this doesn't get reloaded every time we :Src
require('luasnip.loaders.from_vscode').load({ paths = '~/.local/share/nvim/site/pack/packer/start/friendly-snippets' })
