return {
	"williamboman/mason.nvim",

	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()

        	local mason = require("mason")
        	local mason_lspconfig = require("mason-lspconfig")

	        -- enable mason and configure icons
        	mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				}
			}
		})

        	mason_lspconfig.setup({
            	-- list of servers for mason to install
            	ensure_installed = {
                	"ts_ls",
                	"volar",
			"html",
			"cssls",
			"tailwindcss",
			"emmet_ls",
			"lua_ls",
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = false, -- not the same as ensure_installed
        })
    end,
}
