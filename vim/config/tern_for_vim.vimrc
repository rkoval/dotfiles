let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 1
let g:tern_map_keys = 0
nmap gr :TernRefs<CR>
nmap gd :TernDef<cr>
nmap <S-F6> :wa<cr>:TernRename<cr>
nmap <S-C-P> :TernType<cr>
