return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.filetype.add({
            extension = {
                az = "az",
            },
        })

        vim.lsp.config("azure", {
            filetypes = { "az" },
            cmd = { "/home/magodo/github/az-rs/target/debug/azure", "lsp" },
        })
        vim.lsp.enable("azure")
    end,
}
