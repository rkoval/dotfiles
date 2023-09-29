set guioptions=egmrt

" Open Command+T in a new tab
let g:CommandTAcceptSelectionTabMap='<CR>'

noremap <D-s>  :w<CR>

noremap <D-c>  "+y
vnoremap <D-c>  "+y

noremap <D-v>  "+p
vnoremap <D-v>  "+p
inoremap <D-v>  <esc>"+pa

noremap <D-t>  :tabnew<cr>
inoremap <D-t>  <esc>:tabnew<cr>a


noremap <D-S-w> :qa<cr>

noremap <D-a> ggVG
inoremap <D-a> <esc>ggVG

if exists("g:neovide")
  let g:neovide_remember_window_size = v:true
  let g:neovide_refresh_rate = 90
  let g:neovide_cursor_animation_length = 0
  let g:neovide_cursor_trail_size = 0
endif