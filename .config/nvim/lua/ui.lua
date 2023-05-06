require("tokyonight").setup({
	style = "night",
	transparent = true,
	dim_inactive = true,
	on_colors = function(colors)
		colors.bg = '#151519'
		colors.bg_dark = '#101012'
	end,
	on_highlights = function(highlights, colors)
		-- https://gist.github.com/Emille1723/1134f2ff116f2279a69aa51456065b0d
		-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
		highlights.cStructure = highlights.Identifier
	end,
})
vim.cmd([[colorscheme tokyonight]])

require("barbar").setup({
	animation = false,
	icons = {
		filetype = { enabled = false }
	},
})

