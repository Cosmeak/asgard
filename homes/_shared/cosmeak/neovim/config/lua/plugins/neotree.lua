return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem  = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          ".DS_Store",
          "thumbs.db",
          ".git",
        }
      }
    }
  },
  keys = {
    { "<leader>n", "<cmd>Neotree toggle left<cr>", desc = "Toogle Neotree on the left side<D-s>" }
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end
}
