local commands = {
	-- Highlight yank
	{"TextYankPost", function() vim.hl.on_yank() end},
	-- Show diagnostic on hover
	{"CursorHold", function() vim.diagnostic.open_float({ scope = "line", focusable = false }) end},
	-- Clear command line
	{"CmdlineLeave", function()
		vim.fn.timer_start(800, function()
			vim.cmd("echon")
		end)
	end},
	-- Return cursor to last session
	{{"BufWinEnter", "FileType"}, function()
		vim.cmd([[call setpos(".", getpos("'\""))]])
		-- ALWAYS display tab as 2 spaces despite what filetype sets
		vim.opt.tabstop = 2
		-- vim.cmd('syntax match spaces /  / conceal cchar= ')
	end},
	-- Remove trailing whitespace
	-- {{ "BufWritePre" }, function()
	-- 	local save_cursor = vim.fn.getpos(".")
	-- 	vim.cmd([[%s/\s\+$//e]])
	-- 	vim.fn.setpos(".", save_cursor)
	-- end},
}

for _, command in pairs(commands) do
	vim.api.nvim_create_autocmd(command[1], { callback = command[2] })
end
