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
Plugin 'vim-airline/vim-airline'
Plugin 'tomasiser/vim-code-dark'

"Plugin 'wincent/command-t'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'sukima/xmledit'
"Plugin 'scrooloose/syntastic'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'honza/vim-snippets'
"Plugin 'pangloss/vim-javascript'
"Plugin 'mxw/vim-jsx' " plugin for reactjs syntax
"Plugin 'mattn/emmet-vim' " plugin for shorthand completion
" ES2015 code snippets (Optional)
"Plugin 'epilande/vim-es2015-snippets'
" React code snippets
"Plugin 'epilande/vim-react-snippets'
" Ultisnips
" Plugin 'SirVer/ultisnips'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ------------------------------------------------------ END of Vundle 


" BEGIN YouCompleteMe general config ----------------------
" Changes the autocomplete menu background and text colors
highlight Pmenu ctermfg=29 ctermbg=236

"------------------ END YouCompleteMe general config 

" BEGIN YouCompleteMe config for Python support ----------------------
"
"let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
"let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
"let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
"let g:ycm_complete_in_comments = 1 " Completion in comments
"let g:ycm_complete_in_strings = 1 " Completion in string

"------------------ END YouCompleteMe config config for Python support 
"
"


" BEGIN UtilSnips ---------------------------------------------------
"
"" let g:UltiSnipsExpandTrigger       = "<c-j>"
"" let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
"" let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
"" let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file

" ------------------------------------------------------ END UtilSnips 


"" BEGIN CommandT -----------------------------------------------------

" Start command T in a particular directory
"
"map <leader>t :CommandTFlush<cr>\|:CommandT .<cr>
"map <leader>gf :CommandTFlush<cr>
"map <leader>gc :CommandTFlush<cr>\|:CommandT config<cr>
"map <leader>gv :CommandTFlush<cr>\|:CommandT vendor<cr>
"map <leader>gm :CommandTFlush<cr>\|:CommandT /Users/g<cr>
"map <leader>gg :CommandTFlush<cr>\|:CommandT /Users/g<cr>
"map <leader>gw :CommandTFlush<cr>\|:CommandT /Users/g/Documents/workspace<cr>
" --------------------------------------------------- END CommandT


" BEGIN Syntax for VBA  ----------------------------------------------
"autocmd BufNewFile,BufRead *.xlm set ft=vbnet

" BEGIN Essentials ---------------------------------------------------

" Leader useful for command-t
let mapleader=","

" Coloring
syntax on


" highlight all occurences of word with *
:set hlsearch

" Save
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a
imap <c-s> <Esc><c-s>

" jump to the quickref topic (cannot use <C-]>
nnoremap <C-¨> <C-]>

" Make tab as spaces"
:set tabstop=4
:set shiftwidth=4
:set expandtab
:set number
:set hidden

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
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
:set list

" --------------------------------------------------- END Essentials


"" Color scheme
colorscheme codedark 
""  MacVim colorscheme
let macvim_skip_colorscheme = 4

"" Autocompletion
"filetype plugin on
"
"" Indentation this will tell vim to indent the passed files
:set smartindent
"
"" Html
autocmd FileType html set sw=4
autocmd FileType html set ts=4
autocmd FileType html set sts=4

"" Xml
autocmd FileType xml set sw=4
autocmd FileType xml set ts=4
autocmd FileType xml set sts=4

"" Python
"autocmd FileType python set sw=4
"autocmd FileType python set ts=4
"autocmd FileType python set sts=4
"
"" PHP word
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
":set iskeyword+=$
"" Tabs
"autocmd FileType javascript set sw=2
"autocmd FileType javascript set ts=2
"autocmd FileType javascript set sts=2
"
"
"filetype plugin indent on
filetype indent on

"map <Leader>g :bn<CR>
"map <Leader>s :bp<CR>
"map <Leader>w :bd<CR>
"
"
"let g:debuggerPort = 9000
