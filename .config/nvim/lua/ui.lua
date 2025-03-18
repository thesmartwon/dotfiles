-- Preview colors like `#fff`
require('colorizer').setup()

-- Rely on Treesitter + LSP instead
vim.cmd('syntax off')

require("tokyonight").setup({
	style = "night",
	transparent = true,
	dim_inactive = true,
	on_highlights = function(highlights, colors)
		highlights.ColorColumn = { bg = colors.bg_dark }
	end
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
		layout_config = {
			anchor = "N",
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			layout_config = {
				width = function(_, max_columns, _)
					return math.min(max_columns, 120)
				end,
				height = function(_, max_rows, _)
					return max_rows;
				end,
			},
			previewer = false,
		},
		live_grep = {
			theme = "dropdown",
			layout_config = {
				width = function(_, max_columns, _)
					return math.min(max_columns, 120)
				end,
			},
		},
	},
})
