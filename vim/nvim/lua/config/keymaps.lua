local keymap = vim.keymap.set

-- Use jk to escape insert mode
keymap("i", "jk", "<ESC>")

-- Window Navigation
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")

-- Buffer Navigation
keymap("n", "<leader>n", ":bnext<CR>")
keymap("n", "<leader>p", ":bprevious<CR>")
keymap("n", "<leader>d", ":bd<CR>")
keymap("n", "<leader><leader>", "<c-^>")

-- Working Directory
keymap("n", "<leader>cd", ":cd %:p:h<cr>:pwd<cr>")

-- LSP
-- These GLOBAL keymaps are created unconditionally when Nvim starts:
-- "gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
-- "gri" is mapped to vim.lsp.buf.implementation()
-- "grn" is mapped to vim.lsp.buf.rename()
-- "grr" is mapped to vim.lsp.buf.references()
-- "grt" is mapped to vim.lsp.buf.type_definition()
-- "grx" is mapped to vim.lsp.codelens.run()
-- "gO" is mapped to vim.lsp.buf.document_symbol()
-- CTRL-S (Insert mode) is mapped to vim.lsp.buf.signature_help()
-- v_an and v_in fall back to LSP vim.lsp.buf.selection_range() if treesitter is not active.
-- gx handles textDocument/documentLink. Example: with gopls, invoking gx on "os" in this Go code will open documentation externally:
keymap('n', '[g', vim.diagnostic.goto_prev, {desc = "Previous diagnostic"})
keymap('n', ']g', vim.diagnostic.goto_next, {desc = "Next diagnostic"})
