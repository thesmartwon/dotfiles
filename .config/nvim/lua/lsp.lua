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
		"mdx_analyzer",
		"cssls",
		"html",
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

-- folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 1
vim.opt.foldminlines = 3
vim.opt.foldnestmax = 8
vim.opt.foldtext = ''
vim.opt.fillchars = 'fold: '

-- mason by default enables all installed LSPs
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			},
			-- workspace = {
			-- 	library = vim.api.nvim_get_runtime_file("", true),
			-- },
			telemetry = {
				enable = false
			},
		}
	}
}
vim.lsp.config.zls = { settings = { enable_autofix = false } }
vim.lsp.config.biome = {
	filetypes = { "html", "css", "typescript", "javascript", "tsx", "jsx" }
}

-- local vue_ls_path = vim.fn.expand("$MASON/packages/vue-language-server")
-- local vue_plugin_path = vue_ls_path .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
vim.lsp.config.ts_ls = {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end,
	-- init_options = {
	-- 	plugins = {
	-- 		{
	-- 			name = "@vue/typescript-plugin",
	-- 			location = vue_plugin_path,
	-- 			languages = { "vue" },
	-- 		},
	-- 	},
	-- },
	-- filetypes = { "typescript", "javascript", "vue" },
}
vim.lsp.config.cssls = {
	-- https://raw.githubusercontent.com/microsoft/vscode/main/extensions/css-language-features/package.json
	settings = {
		css = {
			lint = {
				unknownAtRules = "ignore"
			}
		}
	}
}
vim.filetype.add({ extension = { wgsl = "wgsl" } })
vim.filetype.add({ extension = { mdx = "mdx" } })
vim.filetype.add({ extension = { webc = "html" } })

require("conform").setup({
	formatters_by_ft = {
		javascript = { "biome", "biome-organize-imports" },
		css = { "biome" },
		javascriptreact = { "biome", "biome-organize-imports" },
		typescript = { "biome", "biome-organize-imports" },
		typescriptreact = { "biome", "biome-organize-imports" },
		c = { "clang-format" },
	},
})

-- completion
require("blink.cmp").setup({
	keymap = {
		preset = "none",

		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<Tab>'] = { 'select_next', 'fallback', },
		['<S-Tab>'] = { 'select_prev', 'fallback' },
		['<Up>'] = { 'select_prev', 'fallback' },
		['<Down>'] = { 'select_next', 'fallback' },
	},
	completion = {
		list = {
			selection = { preselect = false, auto_insert = true }
		},
	},
	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = {
			force_version = "1.6.0",
		},
	},
	sources = {
		providers = {
			lsp = {
				name = 'LSP',
				module = 'blink.cmp.sources.lsp',
			},
		},
	}
})
