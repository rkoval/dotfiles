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

vim.api.nvim_set_keymap('', '<Backspace>', '10k', opts)
vim.api.nvim_set_keymap('', '<Space>', '10j', opts)

-- reflow paragraph with Q in normal and visual mode
vim.api.nvim_set_keymap('n', 'Q', 'gqap', opts)
vim.api.nvim_set_keymap('x', 'Q', 'gq', opts)

-- sane movement with wrap turned on
vim.api.nvim_set_keymap('n', 'j', 'gj', opts)
vim.api.nvim_set_keymap('n', 'k', 'gk', opts)
vim.api.nvim_set_keymap('x', 'j', 'gj', opts)
vim.api.nvim_set_keymap('x', 'k', 'gk', opts)
vim.api.nvim_set_keymap('n', '<Down>', 'gj', opts)
vim.api.nvim_set_keymap('n', '<Up>', 'gk', opts)
vim.api.nvim_set_keymap('x', '<Down>', 'gj', opts)
vim.api.nvim_set_keymap('x', '<Up>', 'gk', opts)
vim.api.nvim_set_keymap('i', '<Down>', '<C-o>gj', opts)
vim.api.nvim_set_keymap('i', '<Up>', '<C-o>gk', opts)

-- tab indents
vim.api.nvim_set_keymap('n', '<TAB>', '>>', opts)
vim.api.nvim_set_keymap('x', '<TAB>', '>gv', opts)
vim.api.nvim_set_keymap('x', '<S-TAB>', '<gv', opts)
vim.api.nvim_set_keymap('i', '<S-TAB>', '<C-d>', opts)

-- map jk to leave insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', {})
vim.api.nvim_set_keymap('i', 'Jk', '<Esc>', {})
vim.api.nvim_set_keymap('n', 'K', '<Esc>', {})

-- cmd+w should delete the buffer
vim.api.nvim_set_keymap('i', '<D-w>', '<esc>:bdelete<cr>', opts)
vim.api.nvim_set_keymap('n', '<D-w>', ':bdelete<cr>', opts)
vim.api.nvim_set_keymap('v', '<D-w>', ':bdelete<cr>', opts)

-- map find hotkeys
vim.api.nvim_set_keymap('n', '<D-f>', '/', {})
vim.api.nvim_set_keymap('n', '<D-r>', ':,$s/<C-r><C-w>//gc<Left><Left><Left>', {})
vim.api.nvim_set_keymap('x', '<D-r>', ':s/<C-r><C-w>//gc<Left><Left><Left>', {})

-- swap mark keys
vim.api.nvim_set_keymap('n', '`', "'", opts)
vim.api.nvim_set_keymap('n', "'", '`', opts)
