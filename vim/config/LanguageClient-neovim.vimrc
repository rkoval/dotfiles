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

