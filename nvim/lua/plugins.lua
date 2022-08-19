return require('packer').startup(function()
  use('wbthomason/packer.nvim')

  use('folke/tokyonight.nvim')

  --
  -- nvim dependencies
  --
  use('nvim-lua/plenary.nvim')
  use('kyazdani42/nvim-web-devicons')
  use('tami5/sqlite.lua')

  --
  -- nvim plugins
  --

  use({
    'nvim-treesitter/nvim-treesitter',
    run = 'TSUpdate',
    commit = '57f4dbd47b2af3898a6153cd915b106eb72fc980',
  })
  use('nvim-treesitter/nvim-treesitter-textobjects')

  use({
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })
  use({
    'nvim-telescope/telescope-frecency.nvim',
    requires = { { 'tami5/sqlite.lua' } },
  })
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    requires = { { 'nvim-telescope/telescope.nvim' } },
    run = 'make',
  })
  use({
    'nvim-telescope/telescope-smart-history.nvim',
    run = 'mkdir -p ~/.local/share/nvim/databases',
    requires = { { 'nvim-telescope/telescope.nvim', 'tami5/sqlite.lua' } },
  })

  use('neovim/nvim-lspconfig')
  use('williamboman/nvim-lsp-installer')
  use('hrsh7th/nvim-cmp')
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-cmdline')
  use('hrsh7th/cmp-path')
  use('L3MON4D3/LuaSnip')
  use('saadparwaiz1/cmp_luasnip')

  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  })

  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  })

  use('lukas-reineke/indent-blankline.nvim')
  use('xiyaowong/nvim-cursorword')
  use('lewis6991/gitsigns.nvim')

  --
  -- evaluating nvim plugins
  --
  use({
    'seblj/nvim-tabline',
    requires = { 'kyazdani42/nvim-web-devicons' },
  })

  use('petertriho/nvim-scrollbar')
  use('windwp/nvim-autopairs')
  use('windwp/nvim-ts-autotag')
  use('folke/lua-dev.nvim')
  use('mfussenegger/nvim-treehopper')
  use('phaazon/hop.nvim')
  use('ethanholz/nvim-lastplace')
  use('rcarriga/nvim-notify')

  --
  -- older, but still useful vim plugins
  --
  use('AndrewRadev/splitjoin.vim')
  use('tpope/vim-unimpaired')
  use({
    'kylechui/nvim-surround',
    tag = '*', -- Use for stability; omit for the latest features
  })
  use('tpope/vim-repeat')
  use('tommcdo/vim-exchange')
  use('wellle/targets.vim')
  use('editorconfig/editorconfig-vim')
  use({
    'terrortylor/nvim-comment',
    config = function()
      require('ryankoval.nvim-comment')
    end,
  })
  use({
    'kshenoy/vim-signature',
    config = function()
      require('ryankoval.vim-signature')
    end,
  })
  use('ruanyl/vim-gh-line')
  use({
    'tpope/vim-fugitive',
    config = function()
      require('ryankoval.vim-fugitive')
    end,
  })
  use({
    'tpope/vim-rhubarb',
    requires = { { 'vim-fugitive' } },
  })

  --
  -- probably keep
  --
  use('mg979/vim-visual-multi')
  use({
    'mattn/emmet-vim',
    ft = { 'html', 'css', 'less', 'scss', 'vue', 'markdown' },
    config = function()
      require('ryankoval.emmet-vim')
    end,
  })
end)
