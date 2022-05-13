" autosave files on focus lost (ignore unsaved buffers)
augroup SaveOnEdit
  autocmd!
  autocmd FocusLost * silent! wall
  autocmd TabLeave * silent! wall
augroup END

" auto read from disk when file contents change
set autoread

" commands
:command! Pxml set ft=xml | %!xmllint --format --recover - 2>/dev/null
:command! Pjson set ft=json | %!jq '.'
:command! Djson set ft=json | %!jq '.' -c
:command! Src source ~/.config/nvim/init.vim | source ~/.gvimrc

:command! NewDiff diffthis|vnew|diffthis

:command! Tab4 set sw=4 sts=4 et
:command! Tab2 set sw=2 sts=2 et

set synmaxcol=300

" function that inspects remaining windows and closes vim if panes open
" are ONLY NERDTree, quickfix, help, etc.
function! CheckLeftBuffers()
  let i = 1
  while i <= winnr('$')
    if getbufvar(winbufnr(i), '&buftype') == 'quickfix' ||
        \ exists('t:NERDTreeBufName') &&
        \   bufname(winbufnr(i)) == t:NERDTreeBufName ||
        \ bufname(winbufnr(i)) == '__Tag_List__' ||
        \ bufname(winbufnr(i)) == 'Result'
      let i += 1
    else
      break
    endif
  endwhile
  if i == winnr('$') + 1
    if tabpagenr('$') == 1
      qall
    else
      tabc
    endif
  endif
  unlet i
endfunction
" autocmd BufEnter * call CheckLeftBuffers()

augroup ansiblevault
  autocmd!
  autocmd BufReadPre,FileReadPre vault.yml,*_vault.yml setlocal ft=ansible
  autocmd BufReadPre,FileReadPre vault.yml,*_vault.yml setlocal viminfo=
  autocmd BufReadPre,FileReadPre vault.yml,*_vault.yml setlocal noswapfile noundofile nobackup
  autocmd BufReadPost,FileReadPost vault.yml,*_vault.yml echom 'Decrypting ...'
  autocmd BufReadPost,FileReadPost vault.yml,*_vault.yml silent %!ansible-vault decrypt --vault-password-file ~/.ssh/vault_pass.txt
  autocmd BufWritePre,FileWritePre vault.yml,*_vault.yml echom 'Encrypting ...'
  autocmd BufWritePre,FileWritePre vault.yml,*_vault.yml silent %!ansible-vault encrypt --vault-password-file ~/.ssh/vault_pass.txt
  autocmd BufWritePost,FileWritePost vault.yml,*_vault.yml silent undo
  autocmd BufWritePost,FileWritePost vault.yml,*_vault.yml silent setlocal nomodified
augroup END

" allow for .vimrc files to be read from other project directories
set exrc
set secure