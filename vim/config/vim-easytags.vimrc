let g:easytags_async = 1
let b:easytags_auto_highlight = 1
let g:easytags_events = ['BufRead', 'BufWritePost']
let g:easytags_python_enabled = 1

call system('mkdir -p ' . $PWD . '/.vimtags')
let g:easytags_by_filetype = $PWD . '/.vimtags'
