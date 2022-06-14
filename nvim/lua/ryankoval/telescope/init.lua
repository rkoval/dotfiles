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

local last_prompts = {}

local function run_action_with_cached_text(action, cache_key)
  return function(prompt_bufnr)
    local raw_prompt = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, -1, false)[1]
    local string = raw_prompt:sub(3) -- prompt includes "> ", so truncate that
    last_prompts[cache_key] = string
    action(prompt_bufnr)
  end
end

-- adapted from https://github.com/nvim-telescope/telescope.nvim/issues/1939#issuecomment-1128619298
local function enter_select_mode_on_complete(picker)
  local mode = vim.fn.mode()
  local keys = mode ~= 'n' and '<ESC>' or ''
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys .. [[^llv$<C-g>]], true, false, true), 'n', true)
  -- should you have more callbacks, just pop the first one
  table.remove(picker._completion_callbacks, 1)

  local prompt_bufnr = picker.prompt_bufnr
  vim.keymap.set('s', '<C-n>', function()
    actions.move_selection_next(prompt_bufnr)
  end, { buffer = prompt_bufnr })
  vim.keymap.set('s', '<C-p>', function()
    actions.move_selection_previous(prompt_bufnr)
  end, { buffer = prompt_bufnr })
  vim.keymap.set('s', '<Esc>', function()
    actions.close(prompt_bufnr)
  end, { buffer = prompt_bufnr })
end

local binary_files = {
  '*.eot',
  '*.gif',
  '*.jpg',
  '*.png',
  '*.svg',
  '*.ttf',
  '*.webp',
  '*.woff',
  '*.a',
  '*.ai',
  '*.aif',
  '*.apng',
  '*.bin',
  '*.class',
  '*.db',
  '*.dds',
  '*.dll',
  '*.dylib',
  '*.eot',
  '*.exe',
  '*.gif',
  '*.gz',
  '*.gzip',
  '*.icns',
  '*.ico',
  '*.idb',
  '*.jar',
  '*.jpeg',
  '*.jpg',
  '*.jsbundle',
  '*.lib',
  '*.lock',
  '*.m4a',
  '*.m4v',
  '*.map',
  '*.mkv',
  '*.mp3',
  '*.mp4',
  '*.ncb',
  '*.o',
  '*.obj',
  '*.pbxproj',
  '*.pdb',
  '*.pdf',
  '*.pem',
  '*.png',
  '*.apng',
  '*.psd',
  '*.pyc',
  '*.pyo',
  '*.sdf',
  '*.so',
  '*.sublime-project',
  '*.sublime-workspace',
  '*.suo',
  '*.swf',
  '*.tbz2',
  '*.tga',
  '*.ttf',
  '*.wav',
  '*.webp',
  '*.woff',
  '*.woff2',
  '*.zip',
  '*/.snapshots/*',
  '*/__snapshots__/*',
}

local find_files_command = {
  'fd',
  '--type',
  'file',
  '--strip-cwd-prefix',
  '--exclude',
  '.git',
  '--exclude',
  'node_modules',
  '--exclude',
  'yarn.lock',
  '--exclude',
  'package-lock.json',
}

local git_files_command = {
  'git',
  'ls-files',
  '--recurse-submodules',
  '--exclude-standard',
  '--cached',
  '--',
  '.',
  ':!:client/www/asset',
}

for _, glob in pairs(binary_files) do
  table.insert(find_files_command, '--exclude')
  table.insert(find_files_command, glob)
  table.insert(git_files_command, ':!:' .. glob)
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

    mappings = {
      i = {
        ['<m-bs>'] = function()
          vim.api.nvim_input('<c-w>')
        end,
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
      layout_config = { width = 130 },
    },
    find_files = {
      prompt_title = '~ files ~',
      find_command = find_files_command,
      follow = true,
      hidden = true,
      layout_config = { width = 130 },
    },
    git_files = {
      prompt_title = '~ git files ~',
      git_command = git_files_command,
      follow = true,
      hidden = true,
      layout_config = { width = 130 },
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
      mappings = {
        i = {
          ['<cr>'] = run_action_with_cached_text(actions.select_tab, 'live_grep'),
          ['<esc>'] = run_action_with_cached_text(actions.close, 'live_grep'),
        },
      },
    },
    oldfiles = {
      prompt_title = '~ oldfiles ~',
      find_command = find_files_command,
      layout_config = { width = 130 },
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
    frecency = {},
  },
}

require('telescope').setup(telescope_opts)
require('telescope').load_extension('frecency')
require('telescope').load_extension('smart_history')
require('telescope').load_extension('notify')

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

function M.git_files(opts)
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

function M.live_grep(opts)
  require('telescope.builtin').live_grep(vim.tbl_extend('force', {
    default_text = last_prompts.live_grep,
    on_complete = {
      enter_select_mode_on_complete,
    },
  }, opts))
end

function M.notifications(opts)
  require('telescope').extensions.notify.notify(opts)
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
