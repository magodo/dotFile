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
"set nu

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

" Visual mode text selection color
hi Visual term=reverse cterm=reverse guibg=Grey

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
"set smartindent

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

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

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
map <leader>n :cn<cr>
map <leader>p :cp<cr>


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

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


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
        call append(line("."), "\ ")
        call append(line(".")+1, "\#########################################################################")
        call append(line(".")+2, "\# Author: Zhaoting Weng")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\# Description: ")
        call append(line(".")+5, "\#########################################################################")
        call append(line(".")+6, "")
    elseif &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python3")
        call append(line("."), "\# -*- coding: utf-8 -*-")
        call append(line(".")+1, "\ ")
        call append(line(".")+2, "\#########################################################################")
        call append(line(".")+3, "\# Author: Zhaoting Weng")
        call append(line(".")+4, "\# Created Time: ".strftime("%c"))
        call append(line(".")+5, "\# Description: ")
        call append(line(".")+6, "\#########################################################################")
        call append(line(".")+7, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), " Author: Zhaoting Weng")
        call append(line(".")+1, " Created Time: ".strftime("%c"))
        call append(line(".")+2, " Description: ")
        call append(line(".")+3, " ************************************************************************/")
        call append(line(".")+4, "") 
        call append(line(".")+5, "")
    endif
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------- Vundle ----------------------------------
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'rdnetto/YCM-Generator'
"Plugin 'bling/vim-airline'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/winmanager--Fox'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'sjl/gundo.vim'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-surround'
Plugin 'flazz/vim-colorschemes'
"Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'vim-airline/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"-------------------- Color Scheme -------------------

colorscheme molokai

" keep terminal background (for transparent support)
hi Normal ctermbg=NONE
hi NonText ctermbg=NONE

" ---
" function to change background transparent
" ---

" make sure vim redraw interface after silent commands finishes
command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'

let g:trans_rate=0
func! HideTerminalToggle()
    let old_flag = &shellcmdflag " remember it
    set shellcmdflag=-ci
    if g:trans_rate == 0
        :Silent hide 30
        let g:trans_rate = 30
    else
        :Silent hide 0
        let g:trans_rate = 0
    endif
    let &shellcmdflag = old_flag " restore it (`let` will use variable,
                                 "             while `set` only use literals)
endfunction

nnoremap <leader>hd :call HideTerminalToggle()<cr>

" source vimrc
map <F6> :so $MYVIMRC<cr>

"---------------------- YouCompleteMe -----------------------------
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_server_python_interpreter = "/usr/bin/python2"
"let g:global_ycm_extra_conf = "/home/magodo/.ycm_extra_conf.py"

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

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

"---------------------- Taglists -----------------------------
nnoremap <silent> <F9> :TlistToggle<cr>
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1

"---------------------- WinManager -----------------------------
let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWidth = 40
nmap wm :WMToggle<cr>

"---------------------- Powerline -------------------------------
let g:powerline_pycmd='py3'

"---------------------- Airline -------------------------------
set laststatus=2
let g:airline_powerline_fonts = 1
"set t_Co=256" Make terminal has 256 colors
"" default theme not work with tmux
"let g:airline_theme='wombat'

"---------------------- Ctags ---------------------------------
" update taglist
"map <F4> :!ctags -R --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
"imap <F4> <ESC>:!ctags -R --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR> :TlistUpdate<CR>
set tags=tags
set tags+=~/ctags/system.tags
set tags+=~/ctags/linux-headers.tags
"set tags+=/home/magodo/Continental/GWM/EarlyApp/01_code/01_origin/tags

"------------------------- File Header ------------------------
" New created .c, .h, .sh, .java, .py files, automatically insert file header
autocmd BufNewFile *.[ch],*.sh,*.java,*.py,*.cpp,*cc exec ":call SetTitle()"
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
autocmd BufRead *.py nmap <F5> :!python -i %<CR>
autocmd BufRead *.py set tabstop=4
autocmd BufRead *.py set nowrap
autocmd BufRead *.py set go+=b

"------------------- Bash Support------------------------------
autocmd BufRead *.sh nmap <F7> :!bash %<CR>

"-------------------  vim-flake8 ------------------------------
autocmd FileType python map <buffer> <F8> :call Flake8()<CR>

"------------------------- code folding -----------------------
set foldmethod=indent
set foldlevel=99

"------------------------- Task List ------------------------
" show every 'FIXME'
map <leader>tl <Plug>TaskList

"------------------------- GundoToggle ----------------------
" review history
map <leader>gd :GundoToggle<CR>
