vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
local lspi = require "nvim-lsp-installer"
lspi.setup({
		-- install based on later lsp configs
		automatic_installation = true,
		ui = {
				icons = {
						server_installed = "✓",
						server_pending = "➜",
						server_uninstalled = "✗"
				}
		}
})

vim.g.coq_settings = {
	auto_start = "shut-up",
	["clients.snippets.warn"] = {},
	display = {
		["icons.mode"] = "none",
		["ghost_text.enabled"] = false,
		["pum.source_context"] = {"", ""}
	}

}
local coq = require "coq"

local lsp = require "lspconfig"
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities())
lsp.tsserver.setup(coq.lsp_ensure_capabilities())
lsp.julials.setup(coq.lsp_ensure_capabilities())
lsp.gopls.setup(coq.lsp_ensure_capabilities())
