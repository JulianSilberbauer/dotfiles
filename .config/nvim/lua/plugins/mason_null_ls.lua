return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
		"nvim-lua/plenary.nvim",
    	},
	config = function()
		require("mason").setup()
		require("mason-null-ls").setup({
    			ensure_installed = {
				"eslint_d",
				"prettier",
				"stylua",
			},
			automatic_installation = false,
			handlers = {},
		})

		require("null-ls").setup({
			sources = {}
		})
	end,

}
