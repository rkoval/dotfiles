if not pcall(require, 'cmp') then
  return
end

local log = require('vim.lsp.log')
local util = require('vim.lsp.util')

--------------------------------------------------------------------------------

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define('DiagnosticSignError', { text = '🚩', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '🔸', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', '<Leader>gr', vim.lsp.buf.rename, opts)
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>F', vim.lsp.buf.formatting, opts)

-- cycle through diagnostics by priority of severity.
-- if no diagnostic exists for a given severity, incrementally try the next levels
local severity_priorities = { 'Error', 'Warn', 'Info', 'Hint' }
function generate_goto_diagnostic(fn, use_priorities)
  return function()
    for _, severity in pairs(severity_priorities) do
      if not use_priorities then
        severity = nil
      end
      local diagnostics = vim.diagnostic.get(0, {
        severity = severity,
      })
      if #diagnostics > 0 then
        vim.diagnostic[fn]({
          severity = severity,
        })
        return
      end
    end
  end
end

vim.keymap.set('n', '[l', generate_goto_diagnostic('goto_prev', true), opts)
vim.keymap.set('n', ']l', generate_goto_diagnostic('goto_next', true), opts)
vim.keymap.set('n', '[L', generate_goto_diagnostic('goto_prev', false), opts)
vim.keymap.set('n', ']L', generate_goto_diagnostic('goto_next', false), opts)

local function set_lsp_keymaps(client, bufnr)
  -- vim.keymap.set('n', ',H', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  vim.keymap.set('n', '<leader>lt', '<cmd>cexpr system("tsc --pretty false") <bar> copen<cr>', opts)
  vim.keymap.set('n', '<leader>la', '<cmd>cexpr system("npm run lint -- --format unix") <bar> copen<cr>', opts)
end

local function handler_publishDiagnostics()
  return vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {})
end

local function first_match(_, result, context)
  local method = context.method
  if result == nil or vim.tbl_isempty(result) then
    local _ = log.info() and log.info(method, 'No location found')
    return nil
  end

  if vim.tbl_islist(result) then
    util.jump_to_location(result[1], vim.lsp.get_client_by_id(context.client_id).offset_encoding)
  else
    util.jump_to_location(result, vim.lsp.get_client_by_id(context.client_id).offset_encoding)
  end

  vim.cmd('normal zz')
end

vim.diagnostic.config({ underline = true, virtual_text = false, update_in_insert = false })
--------------------------------------------------------------------------------

require('nvim-lsp-installer').setup({
  ensure_installed = {
    'sumneko_lua',
    'eslint',
    'tsserver',
    'bashls',
    'pyright',
    'vimls',
    'gopls',
    'golangci_lint_ls',
    'yamlls',
    'dockerls',
    'sourcekit',
    'marksman',
    'cssls',
    'tailwindcss',
  },
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
})
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require('lspconfig')

-- TSSERVER --------------------------------------------------------------------

lspconfig.tsserver.setup({
  capabilities = capabilities,

  init_options = {
    preferences = {
      importModuleSpecifierPreference = 'non-relative',
    },
  },

  on_attach = function(client, bufnr)
    -- use prettier via efm on save instead of tsserver's builtin formatting
    client.resolved_capabilities.document_formatting = false
    set_lsp_keymaps(client, bufnr)
  end,

  flags = {
    debounce_text_changes = 200,
  },

  handlers = {
    ['textDocument/publishDiagnostics'] = handler_publishDiagnostics(),
    ['textDocument/definition'] = first_match,
    ['textDocument/typeDefinition'] = first_match,
  },
})

-- EFM -------------------------------------------------------------------------

local prettier = {
  formatCommand = 'prettier_d_slim --stdin --stdin-filepath ${INPUT}',
  formatStdin = true,
}

local shellcheck = {
  lintCommand = 'shellcheck -f gcc -x',
  lintSource = 'shellcheck',
  lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' },
}

local black = {
  formatCommand = 'black --quiet -',
  formatStdin = true,
}

lspconfig.efm.setup({
  filetypes = {
    'javascript',
    'typescript',
    'typescriptreact',
    'html',
    'svg',
    'xml',
    'less',
    'css',
    'scss',
    'json',
    'sh',
    'markdown',
    'yaml',
    'python',
  },

  init_options = {
    documentFormatting = true,
  },

  on_attach = function(client, bufnr)
    vim.cmd([[
      augroup Format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(null, 2000)
      augroup END
    ]])
  end,

  settings = {
    languages = {
      javascript = { prettier },
      typescript = { prettier },
      javascriptreact = { prettier },
      typescriptreact = { prettier },
      less = { prettier },
      scss = { prettier },
      css = { prettier },
      json = { prettier },
      html = { prettier },
      yaml = { prettier },
      markdown = { prettier },
      svg = { prettier },
      xml = { prettier },
      sh = { shellcheck },
      python = { black },
    },
  },

  handlers = {
    ['textDocument/publishDiagnostics'] = handler_publishDiagnostics(),
  },
})

-- SUMNEKO ---------------------------------------------------------------------
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim', 'use', 'parse', 'table', 'pairs' },
        severity = {
          ['missing-parameter'] = 'Error',
          ['unbalanced-assignments'] = 'Error',
          ['redundant-parameter'] = 'Error',
          ['undefined-global'] = 'Error',
          ['undefined-field'] = 'Error',
        },
        disable = { 'lowercase-global' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- python ---------------------------------------------------------------------
lspconfig.pyright.setup({})

-- bash ---------------------------------------------------------------------
lspconfig.bashls.setup({})

-- javascript ---------------------------------------------------------------------
lspconfig.eslint.setup({})

vim.diagnostic.config({
  virtual_text = false,
  float = {
    format = function(diagnostic)
      if diagnostic.source == 'eslint' then
        return string.format(
          'eslint [%s]: %s',
          -- shows the name of the rule
          diagnostic.user_data.lsp.code,
          diagnostic.message
        )
      end
      return string.format('%s: %s', diagnostic.source, diagnostic.message)
    end,
    severity_sort = true,
  },
})

-- yaml ---------------------------------------------------------------------
require('lspconfig').yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.yml',
      },
    },
  },
})

-- go ---------------------------------------------------------------------
lspconfig.golangci_lint_ls.setup({})
lspconfig.gopls.setup({})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go' },
  callback = function()
    vim.lsp.buf.formatting_sync(nil, 3000)
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go' },
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
    params.context = { only = { 'source.organizeImports' } }

    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, vim.lsp.util._get_offset_encoding())
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end,
})

-- docker ---------------------------------------------------------------------
lspconfig.dockerls.setup({})

-- less ---------------------------------------------------------------------
lspconfig.cssls.setup({})

-- swift ---------------------------------------------------------------------
lspconfig.sourcekit.setup({})

-- markdown ---------------------------------------------------------------------
lspconfig.marksman.setup({})

-- tailwind ---------------------------------------------------------------------
lspconfig.tailwindcss.setup({})

require('lsp_signature').setup({
  debug = false, -- set to true to enable debug logging
  log_path = vim.fn.stdpath('cache') .. '/lsp_signature.log', -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false, -- show debug line number

  bind = true, -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by default

  max_height = 12, -- max height of signature floating_window
  max_width = 120, -- max_width of signature floating_window
  wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines

  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = false, -- virtual hint enable
  hint_prefix = '🐼 ', -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = 'String',
  hi_parameter = 'LspSignatureActiveParameter', -- how your parameter will be highlight
  handler_opts = {
    border = 'rounded', -- double, rounded, single, shadow, none
  },

  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil, -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36, -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
})
