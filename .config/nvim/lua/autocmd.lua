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
	end},
	-- Zig fmt workaround
	{{"BufWinEnter", "FileType"}, function()
		-- ALWAYS display tab as 2 spaces despite what filetype sets
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
		-- display 4 space tabs as 2 spaces
		vim.cmd('syntax match spaces /  / conceal cchar= ')
		vim.opt_local.concealcursor = 'nvi'
		vim.opt_local.conceallevel = 1
	end, "zig"},
	-- Remove trailing whitespace
	-- {{ "BufWritePre" }, function()
	-- 	local save_cursor = vim.fn.getpos(".")
	-- 	vim.cmd([[%s/\s\+$//e]])
	-- 	vim.fn.setpos(".", save_cursor)
	-- end},
	-- Disable default ftplugins that do weird things
	{{ "BufReadPre", "BufNewFile"}, function()
		vim.b.did_ftplugin = 1
	end},
}

-- resourcing clears these
local group = vim.api.nvim_create_augroup('thesm', { clear = true })
for _, command in pairs(commands) do
	vim.api.nvim_create_autocmd(command[1], { callback = command[2], pattern = command[3], group = group })
end
