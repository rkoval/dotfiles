let &l:winheight = &lines / 3

" https://stackoverflow.com/questions/42905008/quickfix-list-how-to-add-and-remove-entries
" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap

autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>
autocmd FileType qf map <buffer> D :RemoveQFItem<cr>
" autocmd FileType qf map <buffer> <s-j> j<cr><c-w><c-w>
" autocmd FileType qf map <buffer> <s-k> k<cr><c-w><c-w>
