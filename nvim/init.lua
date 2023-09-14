-- vim.opt.runtimepath:prepend("~/.config/nvim")
-- vim.opt.runtimepath:append("~/.config/nvim/after")
-- vim.opt.runtimepath:append("/opt/homebrew/bin")

vim.g.mapleader = ","

vim.cmd('set termguicolors')

if vim.fn.has("gui_running") == 1 or vim.fn.has("gui_vimr") == 1 then
  vim.cmd('source ~/.gvimrc')
end

vim.cmd([[
  autocmd CompleteDone * pclose
]])

vim.opt.completeopt = {"menu", "menuone", "noselect"}

if vim.fn.has('persistent_undo') == 1 then
  vim.opt.undofile = true  -- So is persistent undo
  vim.opt.undolevels = 1000  -- Maximum number of changes that can be undone
  vim.opt.undoreload = 10000  -- Maximum number lines to save for undo on a buffer reload
  vim.opt.undodir = "~/.local/share/nvim/.undo"
end

-- Backup settings
vim.opt.backupdir = "~/.local/share/nvim/.backup/"
vim.opt.backup = true
vim.opt.directory = "~/.local/share/nvim/.swap/"

-- ----------------------------------------------------------------------------
-- Text Formatting
-- ----------------------------------------------------------------------------
vim.opt.smartindent = true  -- be smart about it
vim.opt.wrap = false  -- do not wrap lines
vim.opt.softtabstop = 2  -- yep, two
vim.opt.shiftwidth = 2  -- ..
vim.opt.tabstop = 2
vim.opt.expandtab = true  -- expand tabs to spaces
vim.opt.smarttab = false  -- fuck tabs
vim.opt.formatoptions:append("n")  -- support for numbered/bullet lists
vim.opt.virtualedit = "block"  -- allow virtual edit in visual block
vim.opt.linebreak = true  -- wrap lines at space, not middle of word
vim.opt.foldlevelstart = 99  -- don't collapse folds by default

-- ----------------------------------------------------------------------------
-- UI
-- ----------------------------------------------------------------------------
vim.opt.signcolumn = "yes:2"  -- always show the gutter so that editor doesn't jump around
vim.opt.splitbelow = true  -- where to open new horizontal panes
vim.opt.splitright = true  -- where to open new vertical panes
vim.opt.ruler = true  -- show the cursor position all the time
vim.opt.showcmd = false  -- don't display incomplete commands
vim.opt.lazyredraw = false  -- turn off lazy redraw
vim.opt.number = true  -- line numbers
vim.opt.wildmenu = true  -- turn on wild menu
vim.opt.wildmode = "list:longest,full"
vim.opt.cmdheight = 2  -- command line height
vim.opt.backspace = "2"  -- allow backspacing over everything in insert mode
vim.opt.whichwrap:append("<,>,h,l,[,]")  -- backspace and cursor keys wrap to
vim.opt.shortmess:append("filtIoOA")  -- shorten messages
vim.opt.report = 0  -- tell us about changes
vim.opt.startofline = false  -- don't jump to the start of line when scrolling
vim.opt.scrolloff = 12  -- line scrolling with start x lines from border
vim.opt.relativenumber = true  -- show relative numbering for line numbers
vim.opt.showtabline = 2  -- always show tabline

vim.cmd([[
  augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
  augroup END
]])

-- ----------------------------------------------------------------------------
-- Visual Cues
-- ----------------------------------------------------------------------------
vim.opt.showmatch = true  -- brackets/braces that is
vim.opt.matchtime = 5  -- duration to show matching brace (1/10 sec)
vim.opt.incsearch = true  -- do incremental searching
vim.opt.laststatus = 2  -- always show the status line
vim.opt.ignorecase = true  -- ignore case when searching
vim.opt.smartcase = true  -- if search term contains a CAPITAL LETTER, be case sensitive
vim.opt.hlsearch = false  -- don't highlight searches

-- delete buffers when they are hidden
-- see https://github.com/romgrk/barbar.nvim/issues/108#issuecomment-801616480
vim.opt.bufhidden = "delete"

-- Autosave files on focus lost (ignore unsaved buffers)
vim.cmd([[
  augroup SaveOnEdit
    autocmd!
    autocmd FocusLost * silent! wall
    autocmd TabLeave * silent! wall
  augroup END
]])

-- auto read from disk when file contents change
vim.opt.autoread = true


-- load plugins
for k, v in pairs(package.loaded) do
  if string.match(k, "^ryankoval") or k == 'plugins' then
    package.loaded[k] = nil
  end
end

-- these will get overridden by hop, so
vim.keymap.set('', '<Backspace>', '10k', opts)
vim.keymap.set('', '<Space>', '10j', opts)

require('plugins')
require('ryankoval')

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '~/dotfiles/nvim/lua/plugins/lua',
})
