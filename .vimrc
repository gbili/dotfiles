" BEGIN of Vundle --------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tomasiser/vim-code-dark'

" --- Javascript Related Plugins ---
" Read : https://drivy.engineering/setting-up-vim-for-react/
" Syntax Highlighting
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx' "jsx syntax highlighting

" Syntax checker (ale is only the glue between vim and the actual syntax
" checker: eslint
Plugin 'w0rp/ale'

" Syntax beautyfier : requires that your project has: 
"     yarn add --dev prettier eslint-config-prettier eslint-plugin-prettier
Plugin 'skywind3000/asyncrun.vim'

" Emmet for easier JSX
" allows you to expand CSS selectors into HTML (or JSX) on the fly
" ex: %h2#tagline.hero-text
Plugin 'mattn/emmet-vim' " plugin for shorthand completion

"Plugin 'Valloric/YouCompleteMe'
"Plugin 'sukima/xmledit'
"Plugin 'scrooloose/syntastic'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'honza/vim-snippets'
"Plugin 'epilande/vim-es2015-snippets'
" React code snippets
"Plugin 'epilande/vim-react-snippets'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" ------------------------------------------------------ END of Vundle 

" BEGIN Essentials---------------------------------------------------
" Leader useful for command-t
let mapleader=","

" Coloring
syntax on

" highlight all occurences of word with *
set hlsearch

" Save
nmap <c-s> :w<cr>
imap <c-s> <Esc>:w<cr>a
imap <c-s> <Esc><c-s>

" jump to the quickref topic (cannot use <C-]>
nnoremap <C-¨> <C-]>

" Make tab as spaces"
set tabstop=4
set shiftwidth=4
set expandtab
set number
set hidden
set relativenumber

"" Command to insert the directory name of the current buffer
"" From anywhere, %% will expand to dir of current buffer
"" Explanation of script:
"" <C-R> works in command and insert mode, and is used to insert a register
"" <C-R> inserts the = register which is a virtal register that instead lets
"" you put in an expression
"" expand('%:h') . '/' is the expression inserted which says, expand the path
"" of the current file limited to the containing directory and then append a /
"" <cr> carrige return ends the expression
cnoremap %% <C-R>=expand('%:h').'/'<cr>
cnoremap ¢¢ <C-R>='! cp ' . expand('%') . ' '<cr>

"" Weird characters highligher
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

"" Color scheme
colorscheme codedark
""  MacVim colorscheme
let macvim_skip_colorscheme = 4
" --------------------------------------------------- END Essentials
"
" BEGIN FileType specific rules -------------------------------------------
filetype on " turn filetype detection on: each time a file is edited Vim will try to recognize the type of the file and set the filetype option. This will trigger the FileType event
filetype plugin on " loads the file's <plugin> for that filetype in 'runtimepat'
filetype indent on " loads the file's <indent> fot that filetype in 'runtimepat'
" the name of the file should correspond to the 'filetype' for which is is going to be activated, e.g. either <type>/foobar.vim (a subdirectory per filetype) or <type>_foobar.vim or simply <type>.vim where <type> corresponds to the actual filetype

"" Indentation this will tell vim to indent the passed files
:set smartindent
"
" Autocommands : Autocommands are a way to tell Vim to run certain
" commands whenever certain events happen. Let's dive right into an example.
" Read more at: http://learnvimscriptthehardway.stevelosh.com/chapters/12.html
"
" Run on event FileType is == ...
"" Html
autocmd FileType html set sw=4
autocmd FileType html set ts=4
autocmd FileType html set sts=4

"" Xml
autocmd FileType xml set sw=4
autocmd FileType xml set ts=4
autocmd FileType xml set sts=4

"" Python
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
"
"" PHP word
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
":set iskeyword+=$
" Tabs
autocmd FileType javascript set sw=2
autocmd FileType javascript set ts=2
autocmd FileType javascript set sts=2
"

"let g:debuggerPort = 9000
"

" React JS
"let g:jsx_ext_required = 0 "allow JSX in normal JS files
"this wrapper will run jsx, check for errors, then pass through JSHint for
"syntax checking of the transformed code.
"let g:syntastic_javascript_checkers = ['jsxhint']
"let g:syntastic_javascript_jsxhing_exec = 'jsx-jshint-wrapper'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_javascript_eslint_exe = 'npm run lint --'
" End ReactJs
"
"
" Emmet trigger with html:5<c-y>,



" BEGIN YouCompleteMe general config ----------------------
" Changes the autocomplete menu background and text colors
highlight Pmenu ctermfg=29 ctermbg=236
"------------------ END YouCompleteMe general config 

" BEGIN YouCompleteMe config for Python support ----------------------
"let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
"let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
"let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
"let g:ycm_complete_in_comments = 1 " Completion in comments
"let g:ycm_complete_in_strings = 1 " Completion in string
"------------------ END YouCompleteMe config config for Python support 
"
" BEGIN UtilSnips ---------------------------------------------------
"" let g:UltiSnipsExpandTrigger       = "<c-j>"
"" let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
"" let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
"" let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
" ------------------------------------------------------ END UtilSnips 
"
" BEGIN surround.vim ---------------------------------------------------{
"- Press cs"' inside "Hello world!" to change it to: 'Hello world!'
"
"- Now press cs'<q> inside 'Hello World!' to change it to <q>Hello world!</q>
"
"- To go full circle, press cst" to get "Hello world!"
"
" press ds" on "Hello world!" to get Hello world!
"
"Now with the cursor on Hello, press ysiw] (iw is a text object) to get [Hello] world!
"
"use ysiw}  gives {for no space around} or ysiw{  gives  { space space around }:
"
"use cs{] to replace { Hello } world! and get [  Hello  ] world!
"
"Now wrap the entire line in parentheses with yssb or yss).
"to get ({ Hello } world!)
"
"Revert to the original text: ds{ds)
"Hello world!
"
"Emphasize hello: ysiw<em>  to get <em>Hello</em> world!
"
"Finally, let's try out visual mode. Press a capital V (for linewise visual mode) followed by S<p class="important">.
"
"<p class="important">
"  <em>Hello</em> world!
" </p>
"
" This plugin is very powerful for HTML and XML editing, a niche which currently seems underfilled in Vim land. (As opposed to HTML/XML inserting, for which many plugins are available). Adding, changing, and removing pairs of tags simultaneously is a breeze.

" the . command will work with ds, cs, and yss if you install repeat vim
"}------------------------------------------------------ END sourround.vim

"" BEGIN repeat.vim ---------------------------------------------------{
" Plugin needed in order to make the . command work with surround.vim
"}------------------------------------------------------ END repeat.vim

"" BEGIN asyncrun.vim ------------------------------------------------{
" Add an auto command to beautify code for you on write
autocmd BufWritePost *.js AsyncRun -post=checktime ../.node_modules_global/bin/eslint --fix %
"}------------------------------------------------------ END asyncrun.vim

"" BEGIN w0rp/ale ---------------------------------------------------{
let g:ale_sign_error = '●' "less aggressive than the default >>
let g:ale_sign_warning = "."
let g:ale_lint_on_enter = 0 "Less distracting when opening a new file
"}------------------------------------------------------ END w0rp/ale

"" BEGIN emmet-vim ---------------------------------------------------{
let g:user_emmet_leader_key = '<Tab>'
" Transforms Emmet html expansion into JSX syntax
let g:user_emmet_settings = {
\   'javascript.jsx' : {
\      'extends' : 'jsx',
\   },
\}
"}------------------------------------------------------ END emmet-vim

"" BEGIN CtrlP -----------------------------------------------------{
" Basic Usage:
" Run :CtrlP or :CtrlP [starting-directory] to invoke CtrlP in find file mode.
" Run :CtrlPBuffer or :CtrlPMRU to start CtrlP in find buffer or find MRU file mode.
" Run :CtrlPMixed to search in Files, Buffers and MRU files at the same time.
" Check :help ctrlp-commands and :help ctrlp-extensions for other commands.
"
" Once CtrlP is open:
" Press <F5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.
" Press <c-f> and <c-b> to cycle between modes.
" Press <c-d> to switch to filename search instead of full path.
" Press <c-r> to switch to regexp mode.
" Use <c-j>, <c-k> or the arrow keys to navigate the result list.
" Use <c-t> or <c-v>, <c-x> to open the selected entry in a new tab or in a new split.
" Use <c-n>, <c-p> to select the next/previous string in the prompt's history.
" Use <c-y> to create a new file and its parent directories.
" Use <c-z> to mark/unmark multiple files and <c-o> to open them.
" Submit two or more dots .. to go up the directory tree by one or multiple levels.
" End the input with a colon : followed by a command to execute it after opening the file:
" Use :25 to jump to line 25.
" Use :/any\:\ string to jump to the first instance of any: string.
" Use :+setfiletype\ myfiletype|25 to set the filetype to myfiletype then jump to line 25.
" Use :diffthis when opening files marked by <c-z> to run :diffthis on the first 4 files.
"
map <leader>t :CtrlP .<cr>
let g:ctrlp_show_hidden = 1
"}--------------------------------------------------- END CtrlP
