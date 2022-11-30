vim.diagnostic.config({ virtual_text = false })
vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
require("mason").setup()
require("mason-lspconfig").setup({
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
	["keymap.jump_to_mark"] = '',
	auto_start = "shut-up",
	["clients.snippets.warn"] = {},
	display = {
		["icons.mode"] = "none",
		["ghost_text.enabled"] = false,
		["pum.source_context"] = {"", ""}
	}
}
local coq = require("coq")

local lsp = require("lspconfig")
lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities({
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'}
			},
			workspace = {
				library = {
					[vim.fn.expand '$VIMRUNTIME/lua'] = true,
				},
			}
		}
	}
}))
lsp.rust_analyzer.setup(coq.lsp_ensure_capabilities())
lsp.tsserver.setup(coq.lsp_ensure_capabilities())
lsp.julials.setup(coq.lsp_ensure_capabilities())
lsp.gopls.setup(coq.lsp_ensure_capabilities())
lsp.pyright.setup(coq.lsp_ensure_capabilities())
lsp.clangd.setup(coq.lsp_ensure_capabilities())
lsp.zls.setup(coq.lsp_ensure_capabilities())
