"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" use system clipboard
set clipboard=unnamedplus

" Press F3 before paste something to Vim. Afterwards, press again to enable ai
" (This is not available in nvim any more)
" set pastetoggle=<F3>

" Set internal encoding of vim, since coc.nvim using some unicode characters in the file autoload/float.vim
set encoding=utf-8

" Enable mouse mode
set mouse=a

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

" Zig
Plug 'ziglang/zig.vim'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Rust
Plug 'rust-lang/rust.vim'

" Debugging
Plug 'nvim-lua/plenary.nvim'
Plug 'mfussenegger/nvim-dap'

" Other Language specific support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'jasontbradshaw/pigeon.vim'
Plug 'pest-parser/pest.vim'

" From nvim-cmp recommended setting
Plug 'neovim/nvim-lspconfig', {'branch': 'master'}
Plug 'hrsh7th/cmp-nvim-lsp', {'branch': 'main'}
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" Because nvim-cmp needs snip
" For ultisnips users.
Plug 'hrsh7th/cmp-vsnip', {'branch': 'main'}
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'

" UI
Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'akinsho/bufferline.nvim'
Plug 'kyazdani42/nvim-tree.lua'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" HCL
Plug 'fatih/vim-hclfmt'

" Others
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ruanyl/vim-gh-line'

call plug#end()

"""
" nvim-cmp & lspconfig
set completeopt=menu,menuone,noselect

lua <<EOF

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
--cmp.setup.cmdline('/', {
--  sources = {
--    { name = 'buffer' }
--  }
--})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' },
--   },
--   {
--     { name = 'cmdline' },
--   }
--   )
-- })

-- Setup lspconfig.

-- Diags
vim.diagnostic.config({
  virtual_text = true,  -- Show diagnostics inline
  signs = true,         -- Show signs in the sign column
  update_in_insert = false,
  severity_sort = true,
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig =  require('lspconfig')

lspconfig.rust_analyzer.setup {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true;
      },
    },
  },
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.bashls.setup {}

lspconfig.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}

lspconfig.terraformls.setup {}

lspconfig.zls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

EOF

"""
" terraformls 
autocmd BufWritePre *.tfvars lua vim.lsp.buf.format()
autocmd BufWritePre *.tf lua vim.lsp.buf.format()


"""
" vsnip
" Jump forward or backward
imap <expr> <c-f>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<c-f>'
smap <expr> <c-f>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<c-f>'
imap <expr> <c-b>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<c-b>'
smap <expr> <c-b>   vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<c-b>'

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
nmap <c-b> :Buffers<CR>

" " Colorscheme
syntax on
set termguicolors
colorscheme onedark

"""
" lightline
        
let g:lightline = {
      \ 'colorscheme':  'onedark',
      \ 'enable': {
      \   'tabline': 0
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2c %o'
      \ }
      \ }


"""
" bufferline
lua << EOF
vim.opt.termguicolors = true
require("bufferline").setup{}
EOF

"""
" nvim-tree
nnoremap <space>e :NvimTreeToggle<CR>
lua << EOF
require'nvim-tree'.setup {
  view = {
    width = 50,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
  },
}
EOF

" Disable formatting for tf and nomad by the hclfmt plugin, only format for hcl
" files.
let g:tf_fmt_autosave = 0
let g:nomad_fmt_autosave = 0

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on

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

" Stops gitcommit from auto wrapping
au Filetype gitcommit setlocal formatoptions-=t

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
nmap <leader>d :bd<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>

" Visually select the characters that are wanted in the search, then type //
" to search for the next occurrence of the selected text. Then press n to
" search for the next occurrence.
" https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

