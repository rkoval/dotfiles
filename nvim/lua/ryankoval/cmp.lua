if not pcall(require, 'cmp') then
  return
end

local cmp = require('cmp')
local luasnip = require('luasnip')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt' then
    return false
  end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-k>'] = cmp.mapping.confirm({ select = true }),
    ['<C-n>'] = cmp.mapping.select_next_item({ 'i', 'c' }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ 'i', 'c' }),
    ['<Down>'] = cmp.mapping.select_next_item({ 'i', 'c' }),
    ['<Up>'] = cmp.mapping.select_prev_item({ 'i', 'c' }),
    ['<M-n>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, {
      'i',
      's',
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item({ cmp.SelectBehavior.Insert })
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, {
      'i',
      's',
    }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      elseif cmp.visible() then
        cmp.select_prev_item({ cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end, {
      'i',
      's',
    }),
  },
  sources = {
    { name = 'nvim_lsp', keyword_length = 2, max_item_count = 50 },
    { name = 'buffer', keyword_length = 2, max_item_count = 50 },
    { name = 'path' },
    { name = 'luasnip', max_item_count = 10 },
  },
  -- experimental = {
  -- native_menu = false,
  -- ghost_text = false,
  -- },
})

cmp.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' },
  },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
})

vim.cmd([[
  augroup NvimCmp
    au!
    au FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
  augroup END
]])
