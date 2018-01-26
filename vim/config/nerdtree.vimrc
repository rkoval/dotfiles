let g:nerdtree_tabs_synchronize_view = 1 " sync view with all NERDTree tabs
let g:nerdtree_tabs_focus_on_files = 1 " focus file window when switching tabs, not NERDTree
let g:nerdtree_tabs_smart_startup_focus = 2 " focus file upon start
" let g:nerdtree_tabs_synchronize_focus = 0

let g:NERDTreeWinSize=35
let NERDTreeShowHidden=0
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2 " change vim working directory according to whatever the tree node is in NERDtree
nnoremap <D-e> :NERDTreeFocusToggle<Return>
nnoremap <Leader><D-e> :NERDTreeTabsToggle<Return>
nnoremap <Leader>f :NERDTreeFind<cr>

let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "M",
  \ "Staged"    : "S",
  \ "Untracked" : "N",
  \ "Renamed"   : "R",
  \ "Unmerged"  : "C",
  \ "Deleted"   : "D",
  \ "Dirty"     : "M",
  \ "Clean"     : "A",
  \ "Unknown"   : "?"
  \ }
