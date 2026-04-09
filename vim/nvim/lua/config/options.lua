-- Map Leader
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"


local opt = vim.opt

-- Clipbaord
opt.clipboard = "unnamedplus"

-- 
-- UI Settings
-- 

--Always show current position
opt.ruler = true
-- Set line number
opt.number = true
-- Makes search act like search in modern browsers
opt.incsearch = true
-- When searching try to be smart about cases 
opt.smartcase = true
-- Highlight search results
opt.hlsearch = true
-- Show matching brackets when text indicator is over them
opt.showmatch = true
-- Give more space for displaying messages.
opt.cmdheight = 2
-- Show the status line (lightline)
opt.laststatus = 2
-- Show the tab line (bufferline)
opt.showtabline = 2

-- 
-- Editing / Indentation
-- 

-- Use spaces instead of tabs
opt.expandtab = true

-- Be smart when using tabs
opt.smarttab = true

-- 1 tab == 4 spaces
opt.shiftwidth = 4 -- a <Tab> width in front of a line
opt.tabstop = 4    -- a <Tab> width in other place

-- Wrap a long line at a character in 'breakat'(just visually)
opt.linebreak = true

-- Smart indent
opt.smartindent = true

-- Copy the current indentation when creating a new line
opt.autoindent = true

