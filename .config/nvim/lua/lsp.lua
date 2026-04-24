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
		"cssls",
		"html",
		"svelte",
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
-- We need this package to install grammars to runtimepath
local ts = require("nvim-treesitter")
ts.setup()
local langs = {
	'astro',
	'bash',
	'c',
	'cmake',
	'cpp',
	'css',
	'csv',
	'git_config',
	'git_rebase',
	'gitcommit',
	'gitignore',
	'html',
	'ini',
	'javascript',
	'json',
	'julia',
	'liquid',
	'lua',
	'make',
	'markdown',
	'markdown_inline',
	'prisma',
	'pug',
	'python',
	'rust',
	'scss',
	'sql',
	'ssh_config',
	'strace',
	'svelte',
	'tcl',
	'terraform',
	'toml',
	'tsv',
	'tsx',
	'typescript',
	'vim',
	'vimdoc',
	'vue',
	'xml',
	'yaml',
	'zig',
}
vim.defer_fn(function() ts.install(langs) end, 1000)
ts.update()
vim.api.nvim_create_autocmd('FileType', {
	callback = function(ctx)
		local hasStarted = pcall(vim.treesitter.start)
		local noIndent = {}
		if hasStarted and not vim.list_contains(noIndent, ctx.match) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.wo.foldmethod = 'expr'
			vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		end
	end,
})

-- folding
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
vim.lsp.config.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        features = { 'wasm' },
      },
    },
  },
}
vim.filetype.add({ extension = { wgsl = "wgsl" } })
vim.filetype.add({ extension = { mdx = "mdx" } })
vim.filetype.add({ extension = { webc = "html" } })

local prettier = { "prettier", stop_after_first = true }
require("conform").setup({
	formatters_by_ft = {
		javascript = prettier,
		css = prettier,
		javascriptreact = prettier,
		typescript = prettier,
		typescriptreact = prettier,
		svelte = prettier,
		c = { "clang-format" },
		rust = { "rustfmt" },
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
		prebuilt_binaries = { force_version = "v*" },
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
local otter = require("otter");
otter.setup({})

-- if want conform + otter see
-- https://github.com/jmbuhr/nvim-config/blob/382b050e13eada7180ad048842386be37e820660/lua/plugins/editing.lua#L29-L81
vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Run otter for typescript completion in HTML <script>",
	group = vim.api.nvim_create_augroup('otter_on_enter', { clear = true }),
	callback = function (opts)
		if vim.bo[opts.buf].filetype == 'html' then
			otter.activate()
		end
	end,
})
