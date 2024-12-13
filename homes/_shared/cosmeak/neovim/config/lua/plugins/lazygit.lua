return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  keys = {
    {"<leader>gg", "<cmd>:LazyGit<CR>", desc = "Open LazyGit panel"}
  },
  dependencies = {
    -- Already installed with telescope
    -- "nvim-lua/plenary.nvim",
  },
}
