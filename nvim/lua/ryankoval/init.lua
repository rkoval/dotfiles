vim.g.mapleader = ','

vim.opt.termguicolors = true

require('ryankoval.theme')

require('ryankoval.cmp')
require('ryankoval.gitsigns')
require('ryankoval.neotree')
require('ryankoval.treesitter')
require('ryankoval.indent-blankline')
require('ryankoval.telescope')
require('ryankoval.lsp')
require('ryankoval.luasnip')
require('ryankoval.lualine')
require('ryankoval.barbar')
require('ryankoval.scrollbar')
require('ryankoval.nvim-autopairs')
require('ryankoval.custom.font')
require('ryankoval.custom.copy_filename_to_clipboard')
require('ryankoval.custom.add_log')

local parsers = require('nvim-treesitter.parsers')
local configs = parsers.get_parser_configs()
local ft_str = table.concat(
  vim.tbl_map(function(ft)
    return configs[ft].filetype or ft
  end, parsers.available_parsers()),
  ','
)
vim.cmd('autocmd Filetype ' .. ft_str .. ' setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()')

local opts = { noremap = true }

-- open help in new tab
vim.cmd(':cabbrev help tab help')

vim.keymap.set('', '<Backspace>', '10k', opts)
vim.keymap.set('', '<Space>', '10j', opts)

-- reflow paragraph with Q in normal and visual mode
vim.keymap.set('n', 'Q', 'gqap', opts)
vim.keymap.set('x', 'Q', 'gq', opts)

-- sane movement with wrap turned on
vim.keymap.set('n', 'j', 'gj', opts)
vim.keymap.set('n', 'k', 'gk', opts)
vim.keymap.set('x', 'j', 'gj', opts)
vim.keymap.set('x', 'k', 'gk', opts)
vim.keymap.set('n', '<Down>', 'gj', opts)
vim.keymap.set('n', '<Up>', 'gk', opts)
vim.keymap.set('x', '<Down>', 'gj', opts)
vim.keymap.set('x', '<Up>', 'gk', opts)
vim.keymap.set('i', '<Down>', '<C-o>gj', opts)
vim.keymap.set('i', '<Up>', '<C-o>gk', opts)

-- tab indents
vim.keymap.set('n', '<TAB>', '>>', opts)
vim.keymap.set('x', '<TAB>', '>gv', opts)
vim.keymap.set('x', '<S-TAB>', '<gv', opts)
vim.keymap.set('i', '<S-TAB>', '<C-d>', opts)

-- map jk to leave insert mode
vim.keymap.set('i', 'jk', '<Esc>', {})
vim.keymap.set('i', 'Jk', '<Esc>', {})
vim.keymap.set('n', 'K', '<Esc>', {})

-- cmd+w should delete the buffer
vim.keymap.set('i', '<D-w>', '<esc>:bdelete<cr>', opts)
vim.keymap.set('n', '<D-w>', ':bdelete<cr>', opts)
vim.keymap.set('v', '<D-w>', ':bdelete<cr>', opts)

-- map find hotkeys
vim.keymap.set('n', '<D-f>', '/', {})
vim.keymap.set('n', '<D-r>', ':,$s/<C-r><C-w>//gc<Left><Left><Left>', {})
vim.keymap.set('x', '<D-r>', ':s/<C-r><C-w>//gc<Left><Left><Left>', {})

-- swap mark keys
vim.keymap.set('n', '`', "'", opts)
vim.keymap.set('n', "'", '`', opts)
