set guioptions=egmrt

" Open Command+T in a new tab
let g:CommandTAcceptSelectionTabMap='<CR>'

let g:neovide_cursor_animation_length=0
let g:neovide_input_use_logo=v:true

noremap <D-s>  :w<CR>

noremap <D-c>  "+y
vnoremap <D-c>  "+y

noremap <D-v>  "+p
vnoremap <D-v>  "+p
inoremap <D-v>  <esc>"+pa

noremap <D-t>  :tabnew<cr>
inoremap <D-t>  <esc>:tabnew<cr>a


noremap <D-S-w> :qa<cr>
