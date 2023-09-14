require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'cmake',
    'comment',
    'css',
    'dockerfile',
    'go',
    'gomod',
    'graphql',
    'hcl',
    'hocon',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'lua',
    'make',
    'markdown',
    'pug',
    'python',
    'regex',
    'scala',
    'scss',
    'swift',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },

  indent = {
    enable = false,
  },

  highlight = {
    enable = true,
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },

  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@conditional.outer',
        ['ic'] = '@conditional.inner',
        ['as'] = '@statement.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["]xs"] = "@statement.outer",
      },
      swap_previous = {
        ["[xs"] = "@statement.outer",
      },
    },
  },

  context_commentstring = {
    enable = true,
  },

  autotag = {
    enable = true,
  },
})

-- see fixes in https://github.com/apazzolini/dotfiles/commit/53ace9677928da68e30f8c9cddf2776f51949d80
--require('nvim-treesitter.highlight').set_custom_captures({
--  ['className'] = 'TS_C_ClassName',
--  ['reactHook'] = 'TS_C_ReactHook',
--  ['jsxAttribute'] = 'TS_C_JsxAttribute',
--  ['function.call'] = 'TS_C_FunctionCall',
--})
