" set runtimepath^=~/.config/nvim runtimepath+=~/.config/nvim/after runtimepath+=/opt/homebrew/bin

scriptencoding utf-8
let g:mapleader = ","

set termguicolors

if has("gui_running") || has("gui_vimr")
  source ~/.gvimrc
endif


autocmd CompleteDone * pclose

set completeopt=menu,menuone,noselect

if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.local/share/nvim/.undo
endif
set backupdir=~/.local/share/nvim/.backup/
set backup
set directory=~/.local/share/nvim/.swap/

" ----------------------------------------------------------------------------
"  Text Formatting
" ----------------------------------------------------------------------------
set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set tabstop=2
set expandtab              " expand tabs to spaces
set nosmarttab             " fuck tabs
set formatoptions+=n       " support for numbered/bullet lists
set virtualedit=block      " allow virtual edit in visual block ..
set linebreak              " wrap lines at space, not middle of word
set foldlevelstart=99      " don't collapse folds by default

" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set signcolumn=yes:2       " always show the gutter so that editor doesn't jump around
set splitbelow             " where to open new horizontal panes
set splitright             " where to open new vertical panes
set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set nolazyredraw           " turn off lazy redraw
set number                 " line numbers
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set scrolloff=12           " line scrolling with start x lines from border
set relativenumber         " show relative numbering for line numbers
set showtabline=2          " always show tabline

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set incsearch              " do incremental searching
set laststatus=2           " always show the status line
set ignorecase             " ignore case when searching
set smartcase              " if search term contains a CAPITAL LETTER, be case sensitive
set nohlsearch             " don't highlight searches
set mouse=a " enable mouse selection in terminal vim
" delete buffers when they are hidden
" see https://github.com/romgrk/barbar.nvim/issues/108#issuecomment-801616480
set bufhidden=delete

" autosave files on focus lost (ignore unsaved buffers)
augroup SaveOnEdit
  autocmd!
  autocmd FocusLost * silent! wall
  autocmd TabLeave * silent! wall
augroup END

" auto read from disk when file contents change
set autoread

" commands
:command! Pxml set ft=xml | %!xmllint --format --recover - 2>/dev/null
:command! Pjson set ft=json | %!jq '.'
:command! Djson set ft=json | %!jq '.' -c
:command! Src source ~/.config/nvim/init.vim

:command! NewDiff diffthis|vnew|diffthis


lua << EOF
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
  require('friendly-snippets')
EOF

