-- Change background of color strings
require('colorizer').setup()

-- Rely on Treesitter + LSP instead
vim.cmd('syntax off')

require("tokyonight").setup({
	style = "night",
	transparent = true,
	dim_inactive = true,
	on_colors = function(colors)
		colors.bg = '#151519'
		colors.bg_dark = '#101012'
	end,
})
vim.cmd.colorscheme('tokyonight')

local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
require('telescope').setup({
	defaults = {
		winblend = 10,
		mappings = {
			i = {
				["<esc>"] = actions.close,
			}
		},
		file_sorter = sorters.get_fzy_sorter,
		generic_sorter = sorters.get_fzy_sorter,
		preview = false,
		layout_config = {
			anchor = "N",
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
		},
		live_grep = {
			theme = "dropdown",
		},
	},
})
