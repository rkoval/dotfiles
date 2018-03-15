let g:use_emmet_complete_tag = 0
let g:user_emmet_install_global = 0
let g:user_emmet_install_command = 0
let g:user_emmet_mode = 'iv' " enable emmet functions for `i`nsert and `v`isual
autocmd MyAutoCmd FileType html,css,vue
    \ EmmetInstall
    \ | imap <buffer> <C-Return> <Plug>(emmet-expand-abbr)
