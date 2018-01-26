call denite#custom#var('file_rec', 'command',
  \ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', ''])

call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
  \ ['--line-numbers', '--nocolor', '--nogroup', '--hidden'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

nnoremap <leader>t :<C-u>Denite -default-action=tabswitch file_rec<cr>
nnoremap <leader>i :<C-u>Denite -default-action=splitswitch file_rec<cr>
nnoremap <leader>v :<C-u>Denite -default-action=vsplitswitch file_rec<cr>
nnoremap <leader>e :<C-u>Denite -default-action=switch file_rec<cr>
nnoremap <leader>y :<C-u>Denite history/yank<cr>
nnoremap <leader>b :<C-u>Denite buffer<cr>
nnoremap <leader>h :<C-u>Denite file_mru<cr>
" nnoremap <leader>s :<C-u>Denite -buffer-name=misc neosnippet<cr>
" nnoremap <leader>m :<C-u>Denite -buffer-name=misc mapping<cr>
nnoremap <leader>/ :<C-u>Denite -no-empty -mode=normal -previewheight=20 grep:.<cr>
nnoremap <leader>ur :<C-u>Denite -resume<cr>
nnoremap <leader><leader>/ :<C-u>Denite -no-empty -mode=normal -previewheight=20 grep
nnoremap <leader>* :<C-u>DeniteCursorWord -no-empty -mode=normal -previewheight=20 grep<CR><C-R><C-W><cr>

" global options
call denite#custom#option('_', {
  \ 'prompt': '',
  \ 'auto-accel': 1,
  \})

" mappings
call denite#custom#map(
  \ 'insert',
  \ 'jk',
  \ '<denite:enter_mode:normal>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<Esc>',
  \ '<denite:enter_mode:normal>',
  \ 'noremap'
  \)

" movement
call denite#custom#map(
  \ 'insert',
  \ '<C-j>',
  \ '<denite:move_to_next_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<C-k>',
  \ '<denite:move_to_previous_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<Down>',
  \ '<denite:move_to_next_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<Up>',
  \ '<denite:move_to_previous_line>',
  \ 'noremap'
  \)
