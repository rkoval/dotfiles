vim.g.mapleader = ','

  require('ryankoval.cmp')
require('ryankoval.gitsigns')
require('ryankoval.nvimtree')
require('ryankoval.treesitter')
require('ryankoval.indent-blankline')
require('ryankoval.telescope')
require('ryankoval.lsp')
require('ryankoval.luasnip')
require('ryankoval.lualine')

local parsers = require('nvim-treesitter.parsers')
local configs = parsers.get_parser_configs()
local ft_str = table.concat(
  vim.tbl_map(function(ft)
    return configs[ft].filetype or ft
  end, parsers.available_parsers()),
  ','
)
vim.cmd('autocmd Filetype ' .. ft_str .. ' setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()')
