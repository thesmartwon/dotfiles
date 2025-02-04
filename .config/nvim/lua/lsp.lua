-- https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
vim.diagnostic.config({ virtual_text = false })
-- vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
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

local cmp = require("cmp")
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
cmp.setup({
	snippet = {},
	mapping = cmp.mapping.preset.insert({
		['<Tab>'] = function(fallback)
			if not cmp.select_next_item() then
				if vim.bo.buftype ~= 'prompt' and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,

		['<S-Tab>'] = function(fallback)
			if not cmp.select_prev_item() then
				if vim.bo.buftype ~= 'prompt' and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
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

local lsp = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()
lsp.lua_ls.setup({
	capabilites = caps,
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
})
lsp.rust_analyzer.setup({ capabilities = caps })
lsp.julials.setup({ capabilities = caps })
lsp.pyright.setup({ capabilities = caps })
lsp.clangd.setup({ capabilities = caps })
lsp.zls.setup({ capabilities = caps, settings = { enable_autofix = false } })
lsp.gopls.setup({ capabilities = caps })
lsp.tailwindcss.setup({ capabilities = caps })
lsp.ts_ls.setup({
	capabilities = caps,
	root_dir = lsp.util.root_pattern("package.json"),
	single_file_support = false,
})
lsp.biome.setup({ capabilities = caps })

vim.filetype.add({ extension = { wgsl = "wgsl" } })
lsp.wgsl_analyzer.setup({ capabilities = caps })

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 1
vim.opt.foldminlines = 3
vim.opt.foldnestmax = 8
vim.opt.foldtext = ''
vim.opt.fillchars = 'fold: '
