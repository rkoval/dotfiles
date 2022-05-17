vim.g.SimplenoteUsername = 'ryan@ryankoval.com'
vim.g.SimplenotePassword = ''

vim.g.SimplenoteFiletype = 'markdown'
vim.g.SimplenoteSingleWindow = 1
vim.g.SimplenoteVertical = 1
-- add padding to format because new panes will cut it off otherwise
vim.g.SimplenoteNoteFormat = '%-30N%>[%T]    '
vim.g.SimplenoteListSize = 55

local opts = { noremap = true }
vim.keymap.set('n', '<Leader>snl', ':!gvim -c "SimplenoteList"<cr><cr>', opts)
vim.keymap.set('n', '<Leader>snn', ':SimplenoteNew<cr>', opts)
vim.keymap.set('n', '<Leader>snt', ':SimplenoteTag<cr>', opts)
vim.keymap.set('n', '<Leader>snx', ':SimplenoteTrash<cr>', opts)
