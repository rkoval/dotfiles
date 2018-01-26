augroup python_surround
  autocmd!
  autocmd FileType python,python3 let b:surround_116 = "try:\n\r\nexcept Exception:\npass"
  autocmd FileType python,python3 let b:surround_105 = "if :\n\r"
augroup END

augroup javascript_surround
  autocmd!
  autocmd FileType javascript,jsx let b:surround_116 = "try {\n\r\n} catch(e) {\n}"
  autocmd FileType javascript,jsx let b:surround_105 = "if () {\n\r\n}"
augroup END
