if &compatible
  set nocompatible               " Be iMproved
endif
" Required:
set runtimepath^=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.config/nvim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

call dein#add('Shougo/vimproc.vim', {
  \  'build': 'make',
  \  'on_func': 'vimproc#',
  \})

" used for simplenote list to prevent nerdtree from populating
if empty($ENABLE_NERDTREE)
  let $ENABLE_NERDTREE=1
endif

augroup MyAutoCmd
  autocmd!
augroup END

call dein#add('folke/tokyonight.nvim')

"
" nvim dependencies
"
call dein#add('nvim-lua/plenary.nvim')
call dein#add('MunifTanjim/nui.nvim')
call dein#add('kyazdani42/nvim-web-devicons')
call dein#add('tami5/sqlite.lua')

"
" nvim plugins
"

call dein#add('nvim-treesitter/nvim-treesitter', {
  \  'hook_post_update': 'TSUpdate',
  \})
call dein#add('nvim-treesitter/nvim-treesitter-textobjects')

call dein#add('nvim-telescope/telescope.nvim', {
  \  'depends': ['nvim-lua/plenary.nvim']
  \})
call dein#add('nvim-telescope/telescope-fzf-native.nvim', {
  \  'hook_post_update': 'make',
  \})
call dein#add('nvim-telescope/telescope-smart-history.nvim')

call dein#add('neovim/nvim-lspconfig')
call dein#add('williamboman/nvim-lsp-installer')
call dein#add('hrsh7th/nvim-cmp')
call dein#add('hrsh7th/cmp-nvim-lsp')
call dein#add('hrsh7th/cmp-buffer')
call dein#add('hrsh7th/cmp-path')
call dein#add('L3MON4D3/LuaSnip')
call dein#add('saadparwaiz1/cmp_luasnip')

call dein#add('nvim-neo-tree/neo-tree.nvim')

call dein#add('nvim-lualine/lualine.nvim')

call dein#add('lukas-reineke/indent-blankline.nvim')
call dein#add('xiyaowong/nvim-cursorword')
call dein#add('lewis6991/gitsigns.nvim')

"
" evaluating nvim plugins
"
call dein#add('romgrk/barbar.nvim')
call dein#add('petertriho/nvim-scrollbar')
call dein#add('windwp/nvim-autopairs')
call dein#add('windwp/nvim-ts-autotag')
call dein#add('folke/lua-dev.nvim')

"
" older, but still useful vim plugins
"
call dein#add('editorconfig/editorconfig-vim')

"
" probably keep
"
call dein#add('AndrewRadev/splitjoin.vim')
call dein#add('scrooloose/nerdcommenter')
call dein#add('sickill/vim-pasta')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('thinca/vim-qfreplace')
call dein#add('tommcdo/vim-exchange')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-unimpaired')
call dein#add('ruanyl/vim-gh-line')
call dein#add('tpope/vim-fugitive', {
  \  'augroup': 'fugitive',
  \  'hook_post_source': 'source ~/.config/nvim/config/vim-fugitive.vimrc'
  \})
call dein#add('tpope/vim-rhubarb', {
  \  'depends': ['vim-fugitive'],
  \  'hook_post_source': 'source ~/.config/nvim/config/vim-rhubarb.vimrc'
  \})
call dein#add('kshenoy/vim-signature', {
  \  'hook_post_source': 'source ~/.config/nvim/config/vim-signature.vimrc',
  \})
call dein#add('mrtazz/simplenote.vim', {
  \  'hook_post_source': 'source ~/.config/nvim/config/simplenote.vimrc'
  \})
call dein#add('junegunn/vim-easy-align', {
  \  'on_cmd': 'EasyAlign',
  \  'hook_add': 'source ~/.config/nvim/config/vim-easy-align.vimrc',
  \})
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('mattn/emmet-vim', {
  \ 'on_cmd': 'Codi',
  \ 'if': empty($VIM_MINIMAL),
  \ 'on_i': 1,
  \ 'on_ft': ['html', 'css', 'vue'],
  \ 'hook_source': 'source ~/.config/nvim/config/emmet-vim.vimrc',
  \})

"
" evaluate these:
"
call dein#add('xolox/vim-misc')
call dein#add('ntpeters/vim-better-whitespace', {
  \  'hook_post_source': 'source ~/.config/nvim/config/vim-better-whitespace.vimrc'
  \})
call dein#add('wellle/targets.vim')
call dein#add('honza/vim-snippets', {
  \  'build':  'rm -f snippets/_.snippets'
  \})

" Python plugins to keep probably
call dein#add('metakirby5/codi.vim', {
  \ 'on_cmd': 'Codi',
  \ 'build': 'pip2 install pyflakes',
  \ 'hook_post_source': 'source ~/.config/nvim/config/codi.vimrc',
  \})
call dein#add('fisadev/vim-isort', {
  \  'on_ft': ['python', 'python3'],
  \  'build': 'pip install isort',
  \  'hook_post_source': 'source ~/.config/nvim/config/vim-isort.vimrc'
  \})
" needed for proper python autocomplete
call dein#add('jmcantrell/vim-virtualenv', {
  \  'on_ft': ['python', 'python3'],
  \  'hook_post_source': 'source ~/.config/nvim/config/vim-virtualenv.vimrc'
  \})
" End Python stuff

if dein#check_install()
  call dein#install()
endif

" Required:
call dein#end()

" uncomment to debug plugins not getting detected
call dein#recache_runtimepath()

call dein#call_hook('post_source')

" Required:
filetype plugin indent on

