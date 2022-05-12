vim.g.nvim_tree_width = 40
vim.g.nvim_tree_highlight_opened_files = 1

require('nvim-tree').setup({
  update_cwd = true,
  view = {
    width = 37,
    mappings = {
	  list = {
	    { key = "<CR>", action = "tabnew" }
	  }
    }
  },
  open_on_setup = true,
  open_on_setup_file = true,
  open_on_tab = true,
  ignore_ft_on_setup = {'gitcommit'},
  filters = {
    dotfiles = true,
    custom = { '.git', 'node_modules', 'bower_components', '.DS_Store', 'dist' },
  },
  update_focused_file = {
    enable = true,
    ignore_list = {},
  },
  actions = {
    open_file = {
      resize_window = true,
      quit_on_open = false,
      window_picker = {
        enable = false,
      },
    },
  },
})

-- vim.api.nvim_set_keymap('n', '<leader>no', '<cmd>let g:nvim_tree_quit_on_open=!g:nvim_tree_quit_on_open<cr>', {})
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>NvimTreeFindFile<cr>', {})
vim.api.nvim_set_keymap('n', '<leader><S-f>', '<cmd>NvimTreeToggle<cr>', {})
vim.api.nvim_set_keymap('n', '<leader><S-f>', '<cmd>NvimTreeToggle<cr>', {})
-- vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>cd %:p:h<cr>', {})

-- close tree if only buffer open in current tab
-- see https://github.com/kyazdani42/nvim-tree.lua/issues/1005#issuecomment-1115831363
vim.api.nvim_create_autocmd('BufEnter', {
    command = "if tabpagewinnr(tabpagenr(),'$') == 1 && match(bufname(),'NvimTree_') == 0 | quit | endif",
    nested = true,
})
