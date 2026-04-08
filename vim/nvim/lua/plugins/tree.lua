return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      view = {
        width = 50,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
    }

    vim.keymap.set("n", "<space>e", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle File Explorer" })
  end,
}
