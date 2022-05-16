if not pcall(require, 'hop') then
  return
end

local hop = require('hop')

hop.setup()

vim.keymap.set('n', ' ', hop.hint_words)
