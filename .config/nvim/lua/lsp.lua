-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
vim.diagnostic.config({ virtual_text = false })
-- vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		-- neovim config
		"lua_ls",
		-- c
		"clangd",
		-- web
		"ts_ls",
		"biome",
		"tailwindcss",
		"cssls",
		-- config
		"yamlls",
		-- rest
		"rust_analyzer",
		"zls",
	},
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗"
		}
	}
})

local cmp = require("cmp")
cmp.setup({
	snippet = {},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	}),
	sources = cmp.config.sources(
		{ { name = 'nvim_lsp' } },
		{ { name = 'buffer' } },
		{ { name = 'path' } }
	)
})

-- Treesitter is a nice in-between regex highlighting and LSP.
require("nvim-treesitter.configs").setup({
	modules = {},
	auto_install = true,
	ensure_installed = {},
	ignore_install = {},
	sync_install = false,
	highlight = {
		enable = true,
	},
	indent = { enable = true }
})

-- mason by default enables all installed LSPs
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false
			},
		}
	}
}
vim.lsp.config.zls = { settings = { enable_autofix = false } }
vim.lsp.config.ts_ls = {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
}
vim.filetype.add({ extension = { wgsl = "wgsl" } })

require("conform").setup({
	formatters_by_ft = {
		javascript = { "biome", "biome-organize-imports" },
		javascriptreact = { "biome", "biome-organize-imports" },
		typescript = { "biome", "biome-organize-imports" },
		typescriptreact = { "biome", "biome-organize-imports" },
	},
})

-- folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 1
vim.opt.foldminlines = 3
vim.opt.foldnestmax = 8
vim.opt.foldtext = ''
vim.opt.fillchars = 'fold: '
