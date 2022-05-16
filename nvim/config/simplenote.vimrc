let g:SimplenoteUsername = "ryan@ryankoval.com"
let g:SimplenotePassword = ""

let g:SimplenoteFiletype = "markdown"
let g:SimplenoteSingleWindow = 1
let g:SimplenoteVertical = 1
" add padding to format because new panes will cut it off otherwise
let g:SimplenoteNoteFormat = "%-30N%>[%T]    "
let g:SimplenoteListSize = 55

nnoremap <Leader>snl :!ENABLE_NERDTREE=0 mvim -c "SimplenoteList"<cr><cr>
nnoremap <Leader>snn :SimplenoteNew<cr>
nnoremap <Leader>snt :SimplenoteTag<cr>
nnoremap <Leader>snx :SimplenoteTrash<cr>
