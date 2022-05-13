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
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>zz', opts)
vim.api.nvim_set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<cr>zz', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
vim.api.nvim_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>F', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
vim.api.nvim_set_keymap('n', '[l', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']l', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local diagnosticOpts = '{ severity_limit = "Error", popup_opts = { severity_limit = "Error" }}'
vim.api.nvim_set_keymap('n', '<leader>m', '<cmd>lua vim.diagnostic.goto_prev(' .. diagnosticOpts .. ')<cr>zz', opts)
vim.api.nvim_set_keymap('n', '<leader>.', '<cmd>lua vim.diagnostic.goto_next(' .. diagnosticOpts .. ')<cr>zz', opts)

local function set_lsp_keymaps(client, bufnr)
  -- vim.api.nvim_set_keymap('n', ',H', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  vim.api.nvim_set_keymap('n', '<leader>lt', '<cmd>cexpr system("tsc --pretty false") <bar> copen<cr>', opts)
  vim.api.nvim_set_keymap('n', '<leader>la', '<cmd>cexpr system("npm run lint -- --format unix") <bar> copen<cr>', opts)
  vim.api.nvim_set_keymap('n', '<leader>lf', '<cmd>%!eslint_d --stdin --fix-to-stdout --stdin-filename %<cr>', opts)
end

local function handler_publishDiagnostics(level)
  return vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = {
      severity_limit = level,
    },
    update_in_insert = false,
    signs = {
      severity_limit = level,
    },
  })
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

--------------------------------------------------------------------------------

require('nvim-lsp-installer').setup({
  ensure_installed = { 'sumneko_lua', 'eslint', 'tsserver', 'bashls', 'pyright', 'vimls' }, -- ensure these servers are always installed
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
    ['textDocument/publishDiagnostics'] = handler_publishDiagnostics('Error'),
    ['textDocument/definition'] = first_match,
    ['textDocument/typeDefinition'] = first_match,
  },
})

-- EFM -------------------------------------------------------------------------

local prettier = {
  formatCommand = 'prettier_d_slim --stdin --stdin-filepath ${INPUT}',
  formatStdin = true,
}

local eslint = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintStdin = true,
  -- lintFormats = { '%f:%l:%c: %m' },
  lintFormats = {
    '%f(%l,%c): %tarning %m',
    '%f(%l,%c): %rror %m',
  },
  lintIgnoreExitCode = true,
}

local shellcheck = {
  lintCommand = 'shellcheck -f gcc -x',
  lintSource = 'shellcheck',
  lintFormats = { '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m' },
}

lspconfig.efm.setup({
  filetypes = {
    'javascript',
    'typescript',
    'typescriptreact',
    'less',
    'css',
    'json',
    'sh',
    'markdown',
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
      javascript = { prettier, eslint },
      typescript = { prettier, eslint },
      javascriptreact = { prettier, eslint },
      typescriptreact = { prettier, eslint },
      less = { prettier },
      css = { prettier },
      json = { prettier },
      markdown = { prettier },
      sh = { shellcheck },
    },
  },

  handlers = {
    ['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = false,
      update_in_insert = false,
    }),
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
        globals = { 'vim', 'use' },
        disable = { 'lowercase-global' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          ['~/dotfiles/nvim/dein/.cache/init.vim/.dein/lua/?.lua'] = true,
          ['~/dotfiles/nvim/dein/.cache/init.vim/.dein/lua/?/init.lua'] = true,
        },
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