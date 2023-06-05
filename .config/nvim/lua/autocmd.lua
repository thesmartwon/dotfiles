local commands = {
	-- Highlight yank
	{"TextYankPost", function() vim.highlight.on_yank() end},
	-- Show diagnostic on hover
	{"CursorHold", function() vim.diagnostic.open_float({ scope = "line", focusable = false }) end},
	-- Clear command line
	{"CmdlineLeave", function()
		vim.fn.timer_start(800, function()
			vim.cmd("echon")
		end)
	end},
	{{'BufWinEnter', 'FileType'}, function()
		vim.cmd([[call setpos(".", getpos("'\""))]])
	end},
	{{ "BufWritePre" }, function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end}
}

for _, command in pairs(commands) do
	vim.api.nvim_create_autocmd(command[1], { callback = command[2] })
end

