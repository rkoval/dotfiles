let NERDSpaceDelims=1 " add space after comment character

" bind Cmd+/ to commenting motion to mimic intellij hotkey
nmap <D-/> <Leader>c<space>j
vmap <D-/> <Leader>c<space><Esc>
imap <D-/> <Esc><D-/>a
