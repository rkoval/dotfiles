set lines=999 columns=100
set guioptions=egmrt

set colorcolumn=160
set t_Co=256
set columns=177
colors atom-dark

function! GuiTabLabel()
   return substitute( expand( '%:p' ), '.\+\/\(.\+\)\/.\+', '\1', '' )
endfunction
set guitablabel=%N.\ %{expand(\"\%.\")}\ %M " show tab number, filename, and modified indicator

" Open Command+T in a new tab
let g:CommandTAcceptSelectionTabMap='<CR>'

" C-TAB and C-SHIFT-TAB cycle tabs forward and backward
nmap <c-tab> :tabnext<cr>
imap <c-tab> <c-o>:tabnext<cr>
vmap <c-tab> <c-o>:tabnext<cr>
nmap <c-s-tab> :tabprevious<cr>
imap <c-s-tab> <c-o>:tabprevious<cr>
vmap <c-s-tab> <c-o>:tabprevious<cr>

" C-# switches to tab
nmap <d-1> 1gt
nmap <d-2> 2gt
nmap <d-3> 3gt
nmap <d-4> 4gt
nmap <d-5> 5gt
nmap <d-6> 6gt
nmap <d-7> 7gt
nmap <d-8> 8gt
nmap <d-9> 9gt
