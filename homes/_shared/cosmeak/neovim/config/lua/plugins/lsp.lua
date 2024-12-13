return {
  {
    "williamboman/mason.nvim",
    config = function ()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function ()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- web basics
          "html", "cssls", "intelephense", "tailwindcss",
          -- javascript ecosystem
          "tsserver", "svelte", "vuels", "astro",
          -- others
          "lua_ls", "pyright", "zls",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      local lspconfig = require("lspconfig")

      -- Setup LSP
      -- -- Web basics
      lspconfig.html.setup({})
      lspconfig.cssls.setup({})
      lspconfig.intelephense.setup({})
      lspconfig.tailwindcss.setup({})
      -- -- Javascript ecosystem
      lspconfig.tsserver.setup({})
      lspconfig.svelte.setup({})
      lspconfig.vuels.setup({})
      lspconfig.astro.setup({})
      -- -- Others
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.zls.setup({})

      -- Key bindings 
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    end
  }
}
