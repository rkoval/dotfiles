let g:ale_sign_error = '🚩'
let g:ale_sign_warning = '🔸'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '%linter%: %s [%severity%]'
let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pylint', 'flake8'],
\}

let g:ale_fixers = {
\   'javascript': ['prettier', 'eslint'],
\   'sass': ['prettier'],
\   'css': ['prettier'],
\   'less': ['prettier'],
\   'json': ['prettier'],
\}
let g:ale_fix_on_save = 1

let g:airline#extensions#ale#enabled = 1

" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
