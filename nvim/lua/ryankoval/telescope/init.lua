if not pcall(require, 'telescope') then
  return
end

package.loaded['ryankoval.telescope'] = nil

local action_state = require('telescope.actions.state')
local action_set = require('telescope.actions.set')
local actions = require('telescope.actions')

local select_multiple = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local multi_selections = current_picker:get_multi_selection()

  if #multi_selections > 0 then
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist({})
  else
    action_set.select(prompt_bufnr, 'default')
  end
end

local telescope_opts = {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--follow',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    cache_pickers = true,
    history = {
      path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
      limit = 100,
    },

    prompt_prefix = '> ',
    sorting_strategy = 'ascending',
    layout_strategy = 'vertical',
    layout_config = {
      prompt_position = 'top',
      mirror = true,
      horizontal = {
        preview_width = 0.5,
      },
    },

    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    file_ignore_patterns = {
      '%.jpg',
      '%.png',
      '%.woff',
      '%.ttf',
      '%.eot',
      '%.svg',
      'dein/',
      '.undo/',
      'yarn.lock',
      'package%-lock.json',
      '^%.git%/*',
      '%/node_modules/*',
      'systems/osx/iTerm2/com.googlecode.iterm2.plist',
    },

    mappings = {
      i = {
        ['<c-j>'] = actions.move_selection_next,
        ['<c-k>'] = actions.move_selection_previous,
        ['<esc>'] = actions.close,
        ['<D-r>'] = function(prompt_bufnr)
          local raw_prompt = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, -1, false)[1]
          local string = raw_prompt:sub(3) -- prompt includes "> ", so truncate that
          actions.send_to_qflist(prompt_bufnr)
          actions.open_qflist(prompt_bufnr)
          vim.api.nvim_input(':cdo ,$s/' .. string .. '//g<Left><Left>')
        end,
        ['<cr>'] = actions.select_tab,
        ['<Down>'] = actions.cycle_history_next,
        ['<Up>'] = actions.cycle_history_prev,
      },
    },
  },
  pickers = {
    buffers = {
      prompt_title = '~ buffers ~',
      sort_lastused = true,
      mappings = {
        i = {
          ['<c-u>'] = require('telescope.actions').delete_buffer,
        },
      },
      previewer = false,
      theme = 'dropdown',
      layout_config = { width = 110 },
    },
    find_files = {
      prompt_title = '~ files ~',
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      follow = true,
      hidden = true,
      previewer = false,
      theme = 'dropdown',
      layout_config = { width = 110 },
    },
    grep_string = {
      prompt_title = '~ grep string ~',
      short_path = true,
      word_match = '-w',
      only_sort_text = true,
      attach_mappings = function(prompt_bufnr, map)
        map('i', '<cr>', select_multiple)
        return true
      end,
    },
    live_grep = {
      prompt_title = '~ live grep ~',
      attach_mappings = function(prompt_bufnr, map)
        map('i', '<cr>', select_multiple)
        return true
      end,
    },
    oldfiles = {
      prompt_title = '~ oldfiles ~',
      find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      previewer = false,
      theme = 'dropdown',
      layout_config = { width = 110 },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    fzf_writer = {
      minimum_grep_characters = 2,
      minimum_files_characters = 2,
      use_highlighter = true,
    },
  },
}

require('telescope').setup(telescope_opts)
require('telescope').load_extension('smart_history')

if vim.fn.has('win32') == 0 then
  require('telescope').load_extension('fzf')
end

local M = {}

function M.current_dir_files(opts)
  require('telescope.builtin').find_files(vim.tbl_extend('force', {
    prompt_title = string.format('~ files in [%s] ~', vim.fn.expand('%:h')),
    cwd = vim.fn.expand('%:p:h'),
    hidden = true,
  }, opts))
end

function M.dotfiles(opts)
  require('telescope.builtin').find_files(vim.tbl_extend('force', {
    prompt_title = string.format('~ dotfiles ~'),
    cwd = '~/dotfiles',
    hidden = true,
  }, opts))
end

return setmetatable({}, {
  __index = function(_, k)
    if M[k] then
      return M[k]
    else
      return require('telescope.builtin')[k]
    end
  end,
})
