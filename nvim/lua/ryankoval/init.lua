vim.g.mapleader = ','

vim.opt.termguicolors = true

require('ryankoval.theme')

require('ryankoval.cmp')
require('ryankoval.gitsigns')
require('ryankoval.neotree')
require('ryankoval.treesitter')
require('ryankoval.indent-blankline')
require('ryankoval.telescope')
require('ryankoval.telescope.mappings')
require('ryankoval.lsp')
require('ryankoval.luasnip')
require('ryankoval.lualine')
require('ryankoval.barbar')
require('ryankoval.hop')
require('ryankoval.scrollbar')
require('ryankoval.nvim-autopairs')
require('ryankoval.nvim-lastplace')
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
-- being overridden by hop
-- vim.keymap.set('', '<Space>', '10j', opts)

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

-- cmd+w should close the window if only one buffer left
function close_buffer()
  local tabpages = vim.api.nvim_list_tabpages()
  local wins = vim.api.nvim_tabpage_list_wins(tabpages[1])
  vim.pretty_print('tabpages', tabpages)
  if #tabpages == 1 then
    local wins = vim.api.nvim_tabpage_list_wins(tabpages[1])

    vim.pretty_print('wins', wins)
    local should_quit = true
    for _, win in pairs(wins) do
      local filetype = vim.api.nvim_win_call(win, function()
        return vim.o.filetype
      end)
      if filetype ~= 'neo-tree' and filetype ~= '' then
        should_quit = false
        break
      end
    end
    if should_quit then
      vim.cmd(':q')
    end
  end

  vim.api.nvim_buf_delete(0, {})
end
vim.keymap.set('i', '<D-w>', close_buffer, opts)
vim.keymap.set('n', '<D-w>', close_buffer, opts)
vim.keymap.set('v', '<D-w>', close_buffer, opts)

-- map find hotkeys
vim.keymap.set('n', '<D-f>', '/', {})
vim.keymap.set('n', '<D-r>', ':,$s/<C-r><C-w>//gc<Left><Left><Left>', {})
vim.keymap.set('x', '<D-r>', ':s/<C-r><C-w>//gc<Left><Left><Left>', {})

-- swap mark keys
vim.keymap.set('n', '`', "'", opts)
vim.keymap.set('n', "'", '`', opts)

-- split navigation
local silent_opts = { noremap = true, silent = true }
vim.keymap.set('n', '<c-h>', ':wincmd h<cr>', silent_opts)
vim.keymap.set('n', '<c-j>', ':wincmd j<cr>', silent_opts)
vim.keymap.set('n', '<c-k>', ':wincmd k<cr>', silent_opts)
vim.keymap.set('n', '<c-l>', ':wincmd l<cr>', silent_opts)
