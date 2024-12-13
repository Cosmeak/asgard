return {
  "lewis6991/gitsigns.nvim",
  cmd = "Gitsigns",
  lazy = true,
  config = function ()
    require("gitsigns").setup()
  end
}
