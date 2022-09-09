vim.g.mapleader = ','

vim.opt.termguicolors = true

require('ryankoval.theme')

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
map('n', '<c-s-tab>', ':tabprevious<CR>', opts)
map('n', '<c-tab>', ':tabnext<CR>', opts)
-- -- Goto buffer in position...
map('n', '<D-1>', '1gt', opts)
map('n', '<D-2>', '2gt', opts)
map('n', '<D-3>', '3gt', opts)
map('n', '<D-4>', '4gt', opts)
map('n', '<D-5>', '5gt', opts)
map('n', '<D-6>', '6gt', opts)
map('n', '<D-7>', '7gt', opts)
map('n', '<D-8>', '8gt', opts)
map('n', '<D-9>', '9gt', opts)

local function try_function(func, message_prefix)
  local ok, res = xpcall(func, debug.traceback)
  if not ok then
    vim.notify((message_prefix or '') .. res, 'error')
  end
  return res
end

try_function(function()
  require('ryankoval.nvim-notify')
end)

local modules = {
  'ryankoval.nvim-cmp',
  'ryankoval.gitsigns',
  'ryankoval.neotree',
  'ryankoval.treesitter',
  'ryankoval.indent-blankline',
  'ryankoval.telescope',
  'ryankoval.telescope.mappings',
  'ryankoval.lsp',
  'ryankoval.luasnip',
  'ryankoval.lualine',
  'ryankoval.nvim-tabline',
  'ryankoval.nvim-surround',
  'ryankoval.vim-visual-multi',
  'ryankoval.hop',
  'ryankoval.scrollbar',
  'ryankoval.nvim-autopairs',
  'ryankoval.nvim-lastplace',
  'ryankoval.custom.font',
  'ryankoval.custom.copy_filename_to_clipboard',
  'ryankoval.custom.add_log',
}

for i, module in pairs(modules) do
  local function init_module()
    require(module)
  end
  local message_prefix = 'Error initializing module "' .. module .. '": '
  try_function(init_module, message_prefix)
end

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
local silent_opts = { noremap = true, silent = true }

-- open help in new tab
vim.cmd(':cabbrev help tab help')

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

-- map jk to leave insert mode
vim.keymap.set('i', 'jk', '<Esc>', {})
vim.keymap.set('i', 'Jk', '<Esc>', {})
vim.keymap.set('n', 'K', '<Esc>', {})

-- cmd+w should close the window if only one buffer left
function close_buffer()
  local filetype = vim.api.nvim_win_call(vim.api.nvim_get_current_win(), function()
    return vim.o.filetype
  end)

  if filetype == 'neo-tree' then
    -- neotree should not be closable by cmd+w; force window close instead
    vim.cmd('wincmd l')
    vim.cmd('q')
    return
  end

  local tabpages = vim.api.nvim_list_tabpages()
  if #tabpages == 1 then
    local wins = vim.api.nvim_tabpage_list_wins(tabpages[1])

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
      vim.cmd('q')
    end
  end

  vim.cmd('q')
end
vim.keymap.set('i', '<D-w>', close_buffer, opts)
vim.keymap.set('n', '<D-w>', close_buffer, opts)
vim.keymap.set('v', '<D-w>', close_buffer, opts)

-- map find hotkeys
vim.keymap.set('n', '<D-f>', '/', {})
vim.keymap.set('n', '<D-r>', ':,$s/<C-r><C-w>//gc<Left><Left><Left>', {})
vim.keymap.set('v', '<D-r>', '"8y :s/<C-r>8//gc<Left><Left><Left>', {})

-- swap mark keys
vim.keymap.set('n', '`', "'", opts)
vim.keymap.set('n', "'", '`', opts)

-- split navigation
vim.keymap.set('n', '<c-h>', ':wincmd h<cr>', silent_opts)
vim.keymap.set('n', '<c-j>', ':wincmd j<cr>', silent_opts)
vim.keymap.set('n', '<c-k>', ':wincmd k<cr>', silent_opts)
vim.keymap.set('n', '<c-l>', ':wincmd l<cr>', silent_opts)

-- Increment / decrement numbers
vim.o.nrformats = ''
vim.keymap.set('n', '+', '<C-a>', silent_opts)
vim.keymap.set('n', '-', '<C-x>', silent_opts)
vim.keymap.set('x', '+', 'g<C-a>', silent_opts)
vim.keymap.set('x', '-', 'g<C-x>', silent_opts)

-- alt-backspace behavior
vim.keymap.set('i', '<m-bs>', '<c-w>', silent_opts)

-- macOS cut/paste behavior
vim.keymap.set('v', '<D-x>', '"+d', silent_opts)
vim.keymap.set('n', '<D-x>', 'V"+d', silent_opts)

-- set this globally to access more easily
vpp = vim.pretty_print
