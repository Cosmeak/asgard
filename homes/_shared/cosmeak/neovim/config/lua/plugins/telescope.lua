return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>bf", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      -- Remap find file to macos cmd + p
      { "<D-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    },
    config = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "vendor",
        }
      }
    }
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function ()
      -- This is your opts table
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          }
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end
  }
}
