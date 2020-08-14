"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sections:
"    -> General
"    -> VIM user interface
"    -> Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" be iMproved, required by lots of plugins!
set nocompatible              

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" map <ESC> to jk
inoremap jk <ESC>

" make '.' useful in Visual Mode
vnoremap . :norm.<CR>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Turn on the WiLd menu
set wildmenu

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

func! ToggleCmdHeight()
    let oh = &cmdheight
    if &cmdheight == 5
        set cmdheight=2
    else
        set cmdheight=5
    endif
endfunction

map <F1> :call ToggleCmdHeight()<cr>

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch
hi Search guibg=Yellow guifg=Black ctermbg=Yellow ctermfg=Black

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set line number
set nu

set clipboard=unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fonts and Encoding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" cursorcolumn
set cursorcolumn
"hi CursorColumn cterm=NONE ctermbg=darkgrey ctermfg=white

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=m
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
set fileencodings=utf8,gbk
set fileencoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4        " a <Tab> width in front of a line
set tabstop=4           " a <Tab> width in other place

" Wrap a long line at a character in 'breakat'(just visually)
set linebreak

" Copy indent from current line when starting a new line(via 'o'/'O')
set autoindent 

"Smart indent
set smartindent

" Press F3 before paste something to Vim. Afterwards, press again to enable ai
set pastetoggle=<F3>


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Treat long lines as break lines (userful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
"map <c-space> ? " Since this conflicts with input method

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" hide (instead of unload) modified but not saved buffer
set hidden

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Move to the next/previous buffer
nmap <leader>n :bnext<CR>
nmap <leader>p :bprevious<CR>


" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>gr :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Function: SetTitle
" Automatically insert file header
func! SetTitle()
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
        call append(line("."), "")
        call append(line(".")+1, "\#########################################################################")
        call append(line(".")+2, "\# Author: Zhaoting Weng")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\# Description:")
        call append(line(".")+5, "\#########################################################################")
        call append(line(".")+6, "")
    elseif &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python3")
        call append(line("."), "\# -*- coding: utf-8 -*-")
        call append(line(".")+1, "\ ")
        call append(line(".")+2, "\#########################################################################")
        call append(line(".")+3, "\# Author: Zhaoting Weng")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "\# Description:")
        call append(line(".")+6, "\#########################################################################")
        call append(line(".")+7, "")
    elseif &filetype == 'javascript'
        call setline(1, "/* @flow */")
        call append(line("."), "/*************************************************************************")
        call append(line(".")+1, " Author: Zhaoting Weng")
        call append(line(".")+2, " Created Time: ".strftime("%c"))
        call append(line(".")+3, " Description:")
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "'use strict';")
        call append(line(".")+6, "") 
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), " Author: Zhaoting Weng")
        call append(line(".")+1, " Created Time: ".strftime("%c"))
        call append(line(".")+2, " Description:")
        call append(line(".")+3, " ************************************************************************/")
        call append(line(".")+4, "") 
        call append(line(".")+5, "")
    endif
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto install vim-plug if not exists
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" deoplete
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'
"Plug 'Shougo/deoplete.nvim'
"Plug 'zchee/deoplete-go', { 'do': 'make'}

Plug 'Valloric/YouCompleteMe'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
"Plug 'vim-scripts/taglist.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/winmanager--Fox'
Plug 'vim-scripts/TaskList.vim'
Plug 'sjl/gundo.vim'
"Plug 'nvie/vim-flake8'
Plug 'tpope/vim-surround'
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'fatih/vim-go'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'SirVer/ultisnips'
Plug 'mattn/emmet-vim'
Plug 'iamcco/markdown-preview.vim'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'w0rp/ale'
Plug 'skywind3000/vim-preview'
Plug 'aklt/plantuml-syntax'
Plug 'maksimr/vim-jsbeautify'
Plug 'scrooloose/nerdcommenter'
Plug 'pearofducks/ansible-vim'
Plug 'Chiel92/vim-autoformat'
Plug 'sheerun/vim-polyglot'
"Plug 'natebosch/vim-lsc'
"Plug 'godoctor/godoctor.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
call plug#end()

"-------------------- Color Scheme -------------------

"colorscheme jellybeans
colorscheme molokai

" keep terminal background (for transparent support)
hi Normal ctermbg=NONE
hi NonText ctermbg=NONE

" Visual mode text selection color
hi Visual term=reverse cterm=reverse  guibg=Grey

" ---
" function to change background transparent
" ---

"" make sure vim redraw interface after silent commands finishes
"command! -nargs=1 Silent
"\   execute 'silent !' . <q-args>
"\ | execute 'redraw!'
"
"let g:trans_rate=0
"func! HideTerminalToggle()
"    let old_flag = &shellcmdflag " remember it
"    set shellcmdflag=-ci
"    if g:trans_rate == 0
"        :Silent hide 30
"        let g:trans_rate = 30
"    else
"        :Silent hide 0
"        let g:trans_rate = 0
"    endif
"    let &shellcmdflag = old_flag " restore it (`let` will use variable,
"                                 "             while `set` only use literals)
"endfunction
"
"nnoremap <leader>hd :call HideTerminalToggle()<cr>

" source vimrc
map <F6> :so $MYVIMRC<cr>

"---------------------- YouCompleteMe -----------------------------
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_server_python_interpreter = "/usr/bin/python"
let g:ycm_python_binary_path = '/usr/bin/python'

"let g:global_ycm_extra_conf = ""
"let g:ycm_confirm_extra_conf=0

autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Below config might cause ycm server DOWN
"let g:ycm_collect_identifiers_from_tags_files=1

" this is the only way I find to disable semantic completion engine for C family(otherwise, '.', '->', ':' will trigger semantic completion for C family, which will somehow blocks)
"let g:ycm_filetype_specific_completion_to_disable = {
"    \ 'gitcommit': 1,
"    \ 'c': 1,
"    \ 'cpp': 1,
"    \}
"
noremap <leader>i :YcmCompleter GetType<CR>
nnoremap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>

let g:ycm_auto_hover = ""

" Avoid YCM process other file types
let g:ycm_filetype_whitelist = { 
            \"go": 1,
            \"terraform": 1,
            \"rust": 1,
            \ "c": 1,
            \ "python": 1,
            \ "sh": 1,
            \ "javascript": 1,
            \ "javascript.jsx": 1,
            \ "java": 1,
            \ "uml": 1,
            \ "yaml": 1,
            \ "markdown": 1,
            \ "yaml.ansible": 1}

" Below will not overload the default one(i.e. "." and "->"), but append.
let g:ycm_semantic_triggers =  {
            \ 'c,cpp' : ['re!\w{3}']}

let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]

"---------------------- Taglists -----------------------------
"nmap tl :TlistToggle<cr>
"let Tlist_Exit_OnlyWindow=1
"let Tlist_Show_One_File=1

"---------------------- Tagbar  -----------------------------
nmap tl :TagbarToggle<CR>

"---------------------- WinManager -----------------------------
"func! OpenBrowser()
"    :WMToggle
"    :TagbarToggle
"endfunc
"let g:winManagerWindowLayout='FileExplorer'
"let g:winManagerWidth = 40
"nmap wm :WMToggle<cr>

"---------------------- Powerline -------------------------------
let g:powerline_pycmd='py3'

"---------------------- Airline -------------------------------
set laststatus=2
"set t_Co=256" Make terminal has 256 colors
"" default theme not work with tmux
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_z = "%3p%%%#__accent_bold#%{g:airline_symbols.linenr}%4l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#:%3v% :%o"
"---------------------- Ctags ---------------------------------
" update taglist
"map <F4> :!ctags -R --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
"imap <F4> <ESC>:!ctags -R --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
"set tags=tags
"set tags+=~/ctags/system.tags
"set tags+=~/ctags/sysstat.tags
""set tags+=~/ctags/linux-headers.tags
"set tags+=~/ctags/ucloud/wiwo.tags
"set tags+=~/ctags/ucloud/message.tags
"set tags+=~/ctags/ucloud/aioplug.tags
"set tags+=~/ctags/ucloud/udb.tags
"set tags+=~/ctags/ucloud/udb2.tags

"------------------------- File Header ------------------------
" New created .c, .h, .sh, .java, .py files, automatically insert file header
autocmd BufNewFile *.[ch],*.sh,*.java,*.py,*.cpp,*cc,*.js exec ":call SetTitle()"
" After insertion, jump to the next line
autocmd BufNewFile * normal G

"------------------------- Markdown ---------------------------
nnoremap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <CR>
let g:vim_markdown_folding_disabled=1

" Highlighting YAML frontmatter as used by Jekyll
let g:vim_markdown_frontmatter=1

"------------------------- Python Support ----------------------
autocmd BufRead *.py set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd BufRead *.py set tabstop=4
autocmd BufRead *.py set nowrap
autocmd BufRead *.py set go+=b

"------------------- Bash Support------------------------------
autocmd BufRead *.sh nmap <F7> :!bash %<CR>
"
"------------------- Python Support------------------------------
autocmd FileType python nmap <F7> :!python %<CR>

"-------------------  vim-flake8 ------------------------------
"autocmd FileType python map <buffer> <F8> :call Flake8()<CR>

"------------------------- code folding -----------------------
"set foldmethod=indent
"set foldlevel=99

"------------------------- Task List ------------------------
" show every 'FIXME'
map <leader>tl <Plug>TaskList

"------------------------- GundoToggle ----------------------
" review history
"map <leader>gd :GundoToggle<CR>

"------------------------ GIT -------------
" automatically wrap at 72 text width when git commit
func! AutoWrap()
    set formatoptions+=t
    set tw=72
endfunc

autocmd  FileType gitcommit exec ":call AutoWrap()"

"------------------------ emmet -------------
" enable just for html/css
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key=','
autocmd FileType html,css,vue EmmetInstall

"------------------------ markdown-preview ----------
autocmd FileType markdown nmap <silent> <F8> <Plug>MarkdownPreview        " 普通模式
autocmd FileType markdown imap <silent> <F8> <Plug>MarkdownPreview        " 插入模式
autocmd FileType markdown nmap <silent> <F9> <Plug>StopMarkdownPreview    " 普通模式
autocmd FileType markdown imap <silent> <F9> <Plug>StopMarkdownPreview    " 插入模式

"------------------------ vimdiff ----------------
if &diff
    highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
endif

"------------------------ golang ----------------

"------------------------ ultisnips ----------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/UltiSnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']

"------------------------ ctrl space ----------------

"------------------------- vim-syntastic ------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1 "  the error window will be neither opened nor closed automatically
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

""------------------------- yapf --------------
"autocmd FileType python nnoremap <leader>f :0,$!yapf<Cr><C-o>
"autocmd BufWritePre *.py 0,$!yapf

"------------------------- ale --------------
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_sign_error = "✖"
let g:ale_sign_warning = "!"

let g:ale_linters = {
\  'javascript': ['eslint'],
\  'sh': ['shellcheck', 'shell'],
\}

" Map keys to navigate between lines with errors and warnings.
nnoremap <C-n> :ALENextWrap<cr>
nnoremap <C-p> :ALEPreviousWrap<cr>


"------------------- Js Support------------------------------
autocmd FileType javascript nmap <F7> :!node %<CR>

"------------------- Js beautify ------------------------------
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

"------------------- NerdCommenter ---------------------------
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'start'
" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 
"            \ 'c': { 'left': '/**','right': '*/' },
"            \ 'cpp': { 'left': '/**','right': '*/' }
"            \ }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

"------------------- Autoformat ------------------------------
noremap <leader>f :Autoformat<CR>
"autocmd BufWrite * :Autoformat

" When no formatprogram exists (or no formatprogram is installed) for a
" certain filetype, vim-autoformat falls back by default to indenting, (using
" vim's auto indent functionality), retabbing and removing trailing
" whitespace.
" BUT... We don't need it, hence disable it..
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

"------------------- deoplete ------------------------------
let g:deoplete#enable_at_startup = 1

"------------------- vim-go ------------------------------
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'

"noremap <leader>i :GoInfo<CR>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <F7> :<C-u>call <SID>build_go_files()<CR>

" Whenever you save file goimports updates your Go import lines, adding missing ones and
" removing unreferenced ones. Also arrange import path group by package. 
" Furthermore, it does what gofmt does.
let g:go_fmt_command = "goimports"

let g:go_rename_command = 'gopls'

"let g:go_metalinter_autosave = 1

"------------------- vim-lsc ------------------------------
let g:lsc_server_commands = {'dart': 'dart_language_server'}
let g:lsc_auto_map = v:true

"------------------- polyglot -----------------------------
"let g:polyglot_dsabled = ['liquid']

"------------------- rust -----------------------------
let g:rustfmt_autosave=1

"------------------- spell check -----------------------------
"set spell spelllang=en_us
