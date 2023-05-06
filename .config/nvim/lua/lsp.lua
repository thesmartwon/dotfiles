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
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})

local lsp = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()
lsp.lua_ls.setup({
	capabilites = caps,
	settings = {
		Lua = {
			diagnostics = {
				globals = {'vim'}
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
lsp.tsserver.setup({ capabilities = caps })
lsp.julials.setup({ capabilities = caps })
lsp.pyright.setup({ capabilities = caps })
lsp.clangd.setup({ capabilities = caps })
lsp.zls.setup({ capabilities = caps, settings = { enable_autofix = false } })

-- treesitter
-- local treesitter = require("nvim-treesitter.configs")
-- treesitter.setup({
-- 	auto_install = true,
-- 	ensure_install = { "lua", "rust", "typescript", "julia", "python", "cpp", "c", "zig" },
-- 	sync_install = false,
-- 	highlight = {
-- 		enable = false,
-- 	},
-- 	indent = { enable = false }
-- })
vim.wo.foldmethod = "indent"
-- after https://github.com/neovim/neovim/pull/20750 is merged can uncomment
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 1
vim.opt.foldminlines = 3
vim.opt.foldnestmax = 8
vim.opt.foldtext = 'v:lua.Custom_fold_text()'
vim.opt.fillchars = 'fold: '
function Custom_fold_text()
  local foldSize = 1 + vim.v.foldend - vim.v.foldstart
	local indent = vim.fn.indent(vim.v.foldstart)
	local line = vim.fn.getline(vim.v.foldstart):gsub("^%s+", "")
  return string.rep(" ", indent) .. line .. " ↓" .. foldSize
end
