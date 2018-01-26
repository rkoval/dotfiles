let g:airline_theme = 'powerlineish'
if has('gui_running')
  let g:airline_powerline_fonts = 1
endif

if has('gui_vimr')
  set termguicolors
  let g:airline_powerline_fonts = 1
endif

let g:airline#extensions#tagbar#enabled = 0
