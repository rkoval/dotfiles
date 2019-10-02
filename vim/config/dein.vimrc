if &compatible
  set nocompatible               " Be iMproved
endif
" Required:
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

call dein#add('Shougo/vimproc.vim', {
  \  'build': 'make',
  \  'on_func': 'vimproc#',
  \})

" used for simplenote list to prevent nerdtree from populating
if empty($ENABLE_NERDTREE)
  let $ENABLE_NERDTREE=1
endif

augroup MyAutoCmd
  autocmd!
augroup END

"
" UI Components {{{
"
call dein#add('airblade/vim-gitgutter', {
  \  'hook_post_source': 'source ~/.vim/config/gitgutter.vimrc',
  \})
call dein#add('kshenoy/vim-signature', {
  \  'hook_post_source': 'source ~/.vim/config/vim-signature.vimrc',
  \})
call dein#add('rkoval/vim-nerdtree-tabs', {
  \  'depends': ['nerdtree']
  \})
call dein#add('scrooloose/nerdtree', {
  \  'hook_post_source': 'source ~/.vim/config/nerdtree.vimrc',
  \  'depends': 'nerdtree-git-plugin',
  \  'augroup': 'NERDTreeHijackNetrwNeo',
  \  'if': $ENABLE_NERDTREE,
  \})
call dein#add('w0rp/ale', {
  \  'hook_post_source': 'source ~/.vim/config/ale.vimrc',
  \  'build': 'pip install vim-vint yamllint'
  \})
call dein#add('Shougo/unite.vim', {
  \ 'depends': 'neomru.vim',
  \  'hook_post_source': 'source ~/.vim/config/unite.vimrc'
  \})
call dein#add('Shougo/denite.nvim', {
  \  'hook_post_source': 'source ~/.vim/config/denite.vimrc',
  \  'on_cmd': 'Denite',
  \  'if': has('nvim')
  \})
call dein#add('Shougo/neoyank.vim', {
  \  'on_if': 1,
  \  'on_source': 'unite.vim'
  \})
call dein#add('tmhedberg/SimpylFold', {
  \  'on_ft': ['python', 'python3'],
  \  'hook_post_source': 'source ~/.vim/config/SimpylFold.vimrc'
  \})
call dein#add('vim-airline/vim-airline', {
  \  'hook_post_source': 'source ~/.vim/config/airline.vimrc'
  \})
call dein#add('vim-airline/vim-airline-themes', {
  \  'depends': ['vim-airline']
  \})
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('roxma/nvim-yarp', {
  \  'if': !has('nvim')
  \})
call dein#add('roxma/vim-hug-neovim-rpc', {
  \  'if': !has('nvim')
  \})
call dein#add('mrtazz/simplenote.vim', {
  \  'hook_post_source': 'source ~/.vim/config/simplenote.vimrc'
  \})
call dein#add('xolox/vim-misc')
" use fork version because universal ctags detection is broken on master
" call dein#add('oepn/vim-easytags', {
"   \  'depends': ['vim-misc'],
"   \  'hook_post_source': 'source ~/.vim/config/vim-easytags.vimrc'
"   \})
call dein#add('majutsushi/tagbar', {
  \  'hook_add': 'nmap <F8> :TagbarToggle<CR>',
  \  'hook_post_source': 'source ~/.vim/config/tagbar.vimrc',
  \  'on_cmd': ['TagbarToggle']
  \})
" this plugin simply provides a utility for markdown tags; it's not a vim
" plugin, so don't add it to rtp or even source it
call dein#add('jszakmeister/markdown2ctags', {
  \  'build': "sed -i='' '1s~.*~#!/usr/bin/env python2~' markdown2ctags.py",
  \  'rtp': '',
  \})


" }}}
"
" Actual Editing Utilities {{{
"
call dein#add('Konfekt/FastFold', {
  \ 'on_event': 'InsertEnter',
  \ 'hook_post_source': 'FastFoldUpdate'
  \})
call dein#add('Raimondi/delimitMate', {
  \  'hook_post_source': 'source ~/.vim/config/delimitMate.vimrc'
  \})
" this plugin has its own filetype detection, so load normally
call dein#add('alvan/vim-closetag', {
  \  'hook_post_source': 'source ~/.vim/config/vim-closetag.vimrc',
  \})
call dein#add('easymotion/vim-easymotion', {
  \  'hook_post_source': 'source ~/.vim/config/vim-easymotion.vimrc',
  \})
call dein#add('junegunn/vim-easy-align', {
  \  'on_cmd': 'EasyAlign',
  \  'hook_add': 'source ~/.vim/config/vim-easy-align.vimrc',
  \})
call dein#add('scrooloose/nerdcommenter', {
  \  'hook_post_source': 'source ~/.vim/config/nerdcommenter.vimrc'
  \})
call dein#add('sickill/vim-pasta', {
  \  'hook_post_source': 'source ~/.vim/config/vim-pasta.vimrc'
  \})
call dein#add('terryma/vim-multiple-cursors', {
  \  'hook_post_source': 'source ~/.vim/config/vim-multiple-cursors.vimrc'
  \})
call dein#add('thinca/vim-qfreplace')
call dein#add('tommcdo/vim-exchange')
call dein#add('tpope/vim-surround', {
  \  'hook_post_source': 'source ~/.vim/config/vim-surround.vimrc'
  \})
call dein#add('tpope/vim-repeat')
call dein#add('tpope/vim-unimpaired')
call dein#add('dbsr/vimpy', {
  \  'on_ft': ['python', 'python3'],
  \  'build': 'pip install pyflakes',
  \  'hook_post_source': 'source ~/.vim/config/vimpy.vimrc',
  \  'if': 0
  \})
call dein#add('fisadev/vim-isort', {
  \  'on_ft': ['python', 'python3'],
  \  'build': 'pip install isort',
  \  'hook_post_source': 'source ~/.vim/config/vim-isort.vimrc'
  \})
call dein#add('tpope/vim-fugitive', {
  \  'augroup': 'fugitive',
  \  'hook_post_source': 'source ~/.vim/config/vim-fugitive.vimrc'
  \})
call dein#add('tpope/vim-rhubarb', {
  \  'depends': ['vim-fugitive'],
  \  'hook_post_source': 'source ~/.vim/config/vim-rhubarb.vimrc'
  \})
call dein#add('editorconfig/editorconfig-vim')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('wellle/targets.vim')
call dein#add('metakirby5/codi.vim', {
  \ 'on_cmd': 'Codi',
  \ 'build': 'pip2 install pyflakes',
  \ 'hook_post_source': 'source ~/.vim/config/codi.vimrc',
  \})
call dein#add('mattn/emmet-vim', {
  \ 'on_cmd': 'Codi',
  \ 'if': empty($VIM_MINIMAL),
  \ 'on_i': 1,
  \ 'on_ft': ['html', 'css', 'vue'],
  \ 'hook_source': 'source ~/.vim/config/emmet-vim.vimrc',
  \})
call dein#add('AndrewRadev/splitjoin.vim')
call dein#add('Galooshi/vim-import-js', {
  \  'build': 'brew install watchman && npm install -g import-js',
  \  'hook_add': 'source ~/.vim/config/vim-import-js.vimrc',
  \  'on_ft': ['javascript', 'jsx', 'javascript.jsx', 'vue'],
  \})

" }}}
"
" Display {{{
"
call dein#add('gosukiwi/vim-atom-dark')
call dein#add('ryanoasis/vim-devicons', {
  \ 'depends': ['nerdtree-git-plugin'],
  \  'hook_post_source': 'source ~/.vim/config/vim-devicons.vimrc'
  \})
call dein#add('itchyny/vim-cursorword')
call dein#add('nathanaelkane/vim-indent-guides', {
  \  'on_cmd': [ 'IndentGuidesEnable', 'IndentGuidesDisable', 'IndentGuidesToggle' ],
  \  'hook_post_source': 'call indent_guides#init_script_vars() | call indent_guides#highlight_colors()',
  \  'hook_add': 'source ~/.vim/config/vim-indent-guides.vimrc'
  \})
call dein#add('ntpeters/vim-better-whitespace', {
  \  'hook_post_source': 'source ~/.vim/config/vim-better-whitespace.vimrc'
  \})
call dein#add('Valloric/MatchTagAlways', {
  \  'on_ft': ['html', 'xml', 'vue']
  \})
call dein#add('suan/vim-instant-markdown', {
  \  'on_ft': 'markdown',
  \  'hook_post_source': 'source ~/.vim/config/vim-instant-markdown.vimrc',
  \  'build': 'npm -g install instant-markdown-d'
  \})

" }}}
"
" Autocomplete {{{
"
call dein#add('Shougo/deoplete.nvim', {
  \  'build': 'pip3 install neovim && pip3 install --upgrade neovim',
  \  'hook_add': 'let g:deoplete#enable_at_startup = 1',
  \  'hook_source': 'source ~/.vim/config/deoplete.vimrc',
  \})
call dein#add('zchee/deoplete-go', {
  \  'depends': ['deoplete.nvim'],
  \  'build': 'make && go get -u github.com/nsf/gocode',
  \  'on_ft': 'go',
  \  'on_i': 1,
  \})
call dein#add('zchee/deoplete-jedi', {
  \  'depends': ['deoplete.nvim'],
  \  'on_ft': ['python', 'python3'],
  \  'build':  'git submodule update --init && pip install jedi',
  \  'on_i': 1,
  \  'hook_source': 'autocmd MyAutoCmd FileType python setlocal omnifunc=',
  \})
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neosnippet.vim', {
  \  'depends': ['deocomplete.vim', 'neosnippet-snippets', 'vim-snippets'],
  \  'hook_post_source': 'source ~/.vim/config/neosnippet.vimrc'
  \})
call dein#add('Shougo/neco-vim', {
  \  'on_ft': 'vim'
  \})
call dein#add('Shougo/neomru.vim', {
  \  'on_if': 1,
  \  'on_source': 'unite.vim',
  \})
call dein#add('Shougo/neco-syntax', {
  \  'on_source': ['deoplete.vim']
  \})
call dein#add('honza/vim-snippets', {
  \  'depends': 'neosnippet.vim',
  \  'build':  'rm -f snippets/_.snippets'
  \})
call dein#add('Shougo/neoinclude.vim')
call dein#add('othree/jspc.vim', {
  \  'on_ft': ['javascript', 'jsx', 'javascript.jsx', 'vue']
  \})
" needed for proper python autocomplete
call dein#add('jmcantrell/vim-virtualenv', {
  \  'on_ft': ['python', 'python3'],
  \  'hook_post_source': 'source ~/.vim/config/vim-virtualenv.vimrc'
  \})
call dein#add('autozimu/LanguageClient-neovim', {
  \ 'rev': 'next',
  \ 'build': 'bash install.sh && npm install -g javascript-typescript-langserver dockerfile-language-server-nodejs bash-language-server vscode-css-languageservice-bin',
  \ 'hook_post_source': 'source ~/.vim/config/LanguageClient-neovim.vimrc',
  \ })

" }}}
"
" Syntax {{{
"
call dein#add('vim-scripts/xml.vim', {
  \  'on_ft': ['xml']
  \})
call dein#add('kchmck/vim-coffee-script', {
  \  'on_ft': ['coffee']
  \})
call dein#add('elubow/cql-vim', {
  \  'on_ft': ['cql']
  \})
call dein#add('mustache/vim-mustache-handlebars', {
  \  'on_ft': ['handlebars']
  \})
call dein#add('fatih/vim-go', {
  \  'on_ft': ['go'],
  \  'build': 'brew install gotags',
  \  'hook_post_source': 'source ~/.vim/config/vim-go.vimrc'
  \})
call dein#add('kylef/apiblueprint.vim', {
  \  'on_ft': ['apiblueprint']
  \})
call dein#add('solarnz/thrift.vim', {
  \  'on_ft': ['thrift']
  \})
call dein#add('chr4/nginx.vim', {
  \  'on_ft': ['nginx']
  \})
call dein#add('dearrrfish/vim-applescript', {
  \  'on_ft': ['applescript']
  \})
" disabled to not conflict with nginx files
call dein#add('GEverding/vim-hocon', {
  \  'on_ft': ['hocon'],
  \  'if': 0
  \})
call dein#add('elzr/vim-json', {
  \  'on_ft': ['json']
  \})
call dein#add('digitaltoad/vim-pug', {
  \  'on_ft': ['pug']
  \})
call dein#add('othree/html5.vim', {
  \  'on_ft': ['html', 'vue'],
  \  'hook_add': 'source ~/.vim/config/html5.vimrc',
  \})
call dein#add('hail2u/vim-css3-syntax', {
  \  'on_ft': ['css']
  \})
call dein#add('othree/csscomplete.vim', {
  \  'on_ft': ['css', 'stylus']
  \})
call dein#add('vim-scripts/CSS-one-line--multi-line-folding', {
  \  'on_ft': ['css']
  \})
call dein#add('ap/vim-css-color', {
  \  'on_ft': ['css', 'scss', 'sass', 'stylus']
  \})
call dein#add('cakebaker/scss-syntax.vim', {
  \  'on_ft': ['scss', 'sass']
  \})
call dein#add('groenewege/vim-less', {
  \  'on_ft': ['less']
  \})
call dein#add('derekwyatt/vim-scala', {
  \  'on_ft': ['scala']
  \})
call dein#add('plasticboy/vim-markdown', {
  \  'on_ft': ['markdown'],
  \  'hook_post_source': 'source ~/.vim/config/vim-markdown.vimrc'
  \})
call dein#add('rhysd/vim-gfm-syntax', {
  \  'depends': ['vim-markdown'],
  \  'on_ft': ['markdown'],
  \  'hook_source': 'source ~/.vim/config/vim-markdown.vimrc'
  \})
call dein#add('pearofducks/ansible-vim', {
  \  'hook_post_source': 'source ~/.vim/config/ansible-vim.vimrc',
  \  'on_ft': ['ansible', 'yaml', 'ansible_template', 'ansible_hosts']
  \})
call dein#add('pangloss/vim-javascript', {
  \  'on_ft': ['javascript', 'jsx', 'javascript.jsx', 'vue']
  \})
call dein#add('MaxMEllon/vim-jsx-pretty', {
  \  'on_ft': ['javascript', 'jsx', 'javascript.jsx']
  \})
call dein#add('heavenshell/vim-jsdoc', {
  \  'on_ft': ['javascript', 'jsx', 'javascript.jsx', 'vue']
  \})
call dein#add('moll/vim-node', {
  \  'on_ft': ['javascript', 'jsx', 'javascript.jsx', 'vue']
  \})
call dein#add('leafgarland/typescript-vim', {
  \  'on_ft': ['typescript']
  \})
" call dein#add('othree/javascript-libraries-syntax.vim', {
  " \  'on_ft': ['javascript', 'javascript.jsx']
  " \})
" call dein#add('othree/yajs.vim', {
  " \  'on_ft': ['javascript', 'javascript.jsx']
  " \})
" call dein#add('gavocanov/vim-js-indent', {
  " \  'on_ft': ['javascript', 'javascript.jsx']
  " \})
" call dein#add('mxw/vim-jsx', {
  " \  'depends': 'yajs.vim',
  " \  'on_ft': ['javascript', 'javascript.jsx'],
  " \  'hook_post_source': 'source ~/.vim/config/vim-jsx.vimrc',
  " \})
call dein#add('hdima/python-syntax', {
  \  'on_ft': ['python', 'python3'],
  \  'hook_post_source': 'source ~/.vim/config/python-syntax.vimrc'
  \})
call dein#add('rdolgushin/gitignore.vim', {'on_ft': 'gitignore'})
call dein#add('ekalinin/Dockerfile.vim', {
  \  'on_ft': ['dockerfile', 'docker-compose']
  \})
call dein#add('posva/vim-vue', {
  \  'on_ft': ['vue']
  \})
call dein#add('wavded/vim-stylus', {
  \  'on_ft': ['stylus']
  \})
call dein#add('raimon49/requirements.txt.vim', {
  \  'on_ft': ['requirements']
  \})

if dein#check_install()
  call dein#install()
endif

" Required:
call dein#end()

" uncomment to debug plugins not getting detected
" call dein#recache_runtimepath()

call dein#call_hook('post_source')

" Required:
filetype plugin indent on
