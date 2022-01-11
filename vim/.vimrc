"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" use system clipboard
set clipboard=unnamedplus

" Press F3 before paste something to Vim. Afterwards, press again to enable ai
set pastetoggle=<F3>

" Set internal encoding of vim, since coc.nvim using some unicode characters in the file autoload/float.vim
set encoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

" Semantic language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Language specific support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'jasontbradshaw/pigeon.vim'

" UI
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ghifarit53/tokyonight-vim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Hashicorp
Plug 'hashivim/vim-hashicorp-tools'
Plug 'jvirtanen/vim-hcl'

" Others
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
" :1,3GetCurrentBranchLink
Plug 'knsh14/vim-github-link'
Plug 'tpope/vim-surround'
Plug 'ruanyl/vim-gh-line'

call plug#end()

"""
"coc

" Use <CR> to confirm the completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use tab to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"""
" rust

let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rust_clip_command = 'xclip -selection clipboard'

"""
" fzf.vim

" https://github.com/junegunn/fzf.vim#example-rg-command-with-preview-window
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nmap <c-p> :Files<CR>
nmap <c-g> :Rg<CR>

"""
" lightline + bufferline
let g:lightline = {
      \ 'colorscheme':  'tokyonight',
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

"""
" coc-explorer
nnoremap <space>e :CocCommand explorer<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Always show current position
set ruler

" Set line number
set nu

" Makes search act like search in modern browsers
set incsearch

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Show matching brackets when text indicator is over them
set showmatch

" Give more space for displaying messages.
set cmdheight=2

" Show the status line (lightline)
set laststatus=2

" Show the tab line (bufferline)
set showtabline=2

" Colorscheme
colorscheme tokyonight

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map <ESC> to jk
inoremap jk <ESC>

" Sets how many lines of history VIM has to remember
set history=700

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

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

" Smart indent
set smartindent

" Copy the current indentation when creating a new line
set autoindent

" Smart case when searching
set smartcase

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" hide (instead of unload) modified but not saved buffer
set hidden

" Move to the next/previous buffer
nmap <leader>n :bnext<CR>
nmap <leader>p :bprevious<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Visually select the characters that are wanted in the search, then type //
" to search for the next occurrence of the selected text. Then press n to
" search for the next occurrence.
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
