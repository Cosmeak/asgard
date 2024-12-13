return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				auto_installed = true,
				ensure_installed = {
					-- web basics
					"html",
					"css",
					"scss",
					"php",
					-- Javascript ecosystem
					"javascript",
					"vue",
					"svelte",
					-- others
					"lua",
					"zig",
					"python",
					"rust",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
}
