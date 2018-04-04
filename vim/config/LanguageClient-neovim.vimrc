let g:LanguageClient_serverCommands = {
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ 'Dockerfile': ['docker-langserver', '--stdio'],
  \ }

let g:LanguageClient_diagnosticsDisplay = {
    1: {
        "name": "Error",
        "texthl": "ALEError",
        "signText": "🚩",
        "signTexthl": "ALEErrorSign",
    },
    2: {
        "name": "Warning",
        "texthl": "ALEWarning",
        "signText": "🔸",
        "signTexthl": "ALEWarningSign",
    },
    3: {
        "name": "Information",
        "texthl": "ALEInfo",
        "signText": "ℹ",
        "signTexthl": "ALEInfoSign",
    },
    4: {
        "name": "Hint",
        "texthl": "ALEInfo",
        "signText": "➤",
        "signTexthl": "ALEInfoSign",
    },
}

