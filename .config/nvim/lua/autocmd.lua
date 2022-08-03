local commands = {
	restore_cursor = {
		{ 'BufRead', '*', [[call setpos(".", getpos("'\""))]] };
	},
	lua_highlight = {
		{ "TextYankPost", "*", [[silent! lua vim.highlight.on_yank() {higroup="IncSearch", timeout=500}]] };
	},
	clear_command = {
		{ 'CmdlineLeave', '*', [[call timer_start(800, funcref('s:ClearCommand'))]] }
	}
}

vim.api.nvim_command([[
function! s:ClearCommand(timer)
	echon ''
endfunction
]])

for group_name, definition in pairs(commands) do
	vim.api.nvim_command('augroup '..group_name)
	vim.api.nvim_command('autocmd!')
	for _, def in ipairs(definition) do
		local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
		vim.api.nvim_command(command)
	end
	vim.api.nvim_command('augroup END')
end
