set runtimepath^=~/.config/nvim runtimepath+=~/.config/nvim/after
let &packpath = &runtimepath

scriptencoding utf-8
let g:mapleader = ","

set termguicolors

if has("gui_running") || exists("g:neovide")
  source ~/.gvimrc
endif


autocmd CompleteDone * pclose

source ~/.config/nvim/config/dein.vimrc

set completeopt=menu,menuone,noselect

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.config/nvim/.undo
endif
set backupdir=~/.config/nvim/.backup/
set backup
set directory=~/.config/nvim/.swap/
set updatetime=1000 " mostly for gitgutter updates, but reduce time that vim writes to swap file

" ----------------------------------------------------------------------------
"  Text Formatting
" ----------------------------------------------------------------------------
set smartindent            " be smart about it
inoremap # X<BS>#
set nowrap                 " do not wrap lines
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set tabstop=4
set expandtab              " expand tabs to spaces
set nosmarttab             " fuck tabs
set formatoptions+=n       " support for numbered/bullet lists
set virtualedit=block      " allow virtual edit in visual block ..
set linebreak              " wrap lines at space, not middle of word
set foldlevelstart=99      " don't collapse folds by default

" ----------------------------------------------------------------------------
"  Remapping
" ----------------------------------------------------------------------------

" open help in new tab
:cabbrev help tab help

" reflow paragraph with Q in normal and visual mode
nnoremap Q gqap
xnoremap Q gq

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk
map <Backspace> 10k
map <Space> 10j
nnoremap <Down> gj
nnoremap <Up> gk
xnoremap <Down> gj
xnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

nnoremap <TAB> >>
xnoremap <TAB> >gv
xnoremap <S-TAB> <gv
inoremap <S-TAB> <C-d>

" open new tab with current buffer in it
map gz :tab sp<CR>

" map jk to leave insert mode
imap jk <Esc>
imap Jk <Esc>
nmap K <Esc>

" cmd+w should delete the buffer
imap <D-w> <esc>:bdelete<cr>
nmap <D-w> :bdelete<cr>
vmap <D-w> :bdelete<cr>

" map find hotkeys
nnoremap <D-f> /
nnoremap <D-r> :,$s//gc\|1,''-&&<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
xnoremap <D-r> :s//gc<Left><Left><Left>
nnoremap <Leader><D-r> :,$s/<C-r><C-w>//gc\|1,''-&&<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
xnoremap <Leader><D-r> :s/<C-r><C-w>//gc<Left><Left><Left>

" swap mark keys
nnoremap ` '
nnoremap ' `

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
syntax on

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

source ~/.config/nvim/config/misc.vimrc

lua << EOF
  for k, v in pairs(package.loaded) do
    if string.match(k, "^ryankoval") then
      package.loaded[k] = nil
    end
  end
EOF

lua require('ryankoval')
