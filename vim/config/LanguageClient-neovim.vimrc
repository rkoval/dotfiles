let g:LanguageClient_serverCommands = {}
if executable('javascript-typescript-stdio')
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
else
  echo "`javascript-typescript-stdio` not installed!\n"
endif

if executable('docker-langserver')
  let g:LanguageClient_serverCommands.Dockerfile = ['docker-langserver', '--stdio']
else
  echo "`docker-langserver` not installed!\n"
endif

if executable('css-languageserver')
  let g:LanguageClient_serverCommands.css = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.scss = ['css-languageserver', '--stdio']
  let g:LanguageClient_serverCommands.less = ['css-languageserver', '--stdio']
else
  echo "`css-languageserver` not installed!\n"
endif

if executable('bash-language-server')
  let g:LanguageClient_serverCommands.sh = ['bash-language-server', 'start']
else
  echo "`bash-language-server` not installed!\n"
endif
