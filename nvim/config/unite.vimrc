let g:unite_source_rec_async_command = ['ag', '--follow', '--nogroup', '--nocolor', '--hidden', '-g', '']
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--line-numbers --nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opt = ''
let g:unite_source_history_yank_enable = 1
call unite#custom#source('grep', 'max_candidates', 0)
nnoremap <leader>u :<C-u>Unite<cr>
nnoremap <leader>t :<C-u>Unite -start-insert -default-action=tabswitch file_rec/async<cr>
nnoremap <leader>i :<C-u>Unite -start-insert -default-action=splitswitch file_rec/async<cr>
nnoremap <leader>v :<C-u>Unite -start-insert -default-action=vsplitswitch file_rec/async<cr>
nnoremap <leader>e :<C-u>Unite -start-insert -default-action=switch file_rec/async<cr>
nnoremap <leader>y :<C-u>Unite history/yank<cr>
nnoremap <leader>b :<C-u>Unite buffer<cr>
nnoremap <leader>h :<C-u>Unite -start-insert file_mru<cr>
nnoremap <leader>s :<C-u>Unite neosnippet<cr>
nnoremap <leader>m :<C-u>Unite mapping<cr>
nnoremap <leader>/ :<C-u>Unite -no-empty -previewheight=20 grep:.<cr>
nnoremap <leader>ur :<C-u>UniteResume<cr>
nnoremap <leader><leader>/ :<C-u>Unite -no-empty -previewheight=20 grep:.:--
nnoremap <leader>* :<C-u>Unite -no-empty -previewheight=20 grep:.<CR><C-R><C-W><cr>
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <C-j>   <Plug>(unite_select_next_line)
  nmap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  nmap <buffer> <S-R>   <Plug>(unite_redraw)
endfunction
