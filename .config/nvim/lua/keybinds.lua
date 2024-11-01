  -- Open and go one line down
local function open_closed_fold()
	if vim.fn.foldclosed('.') ~= -1 then
		-- Dunno why `zo` sometimes doesn't work...
		for _=1,20 do
			vim.cmd('norm! zo')
		end
	end
	vim.cmd('norm! \r')
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
			vim.cmd("cclose")
			vim.cmd("lclose")
			break
    end
  end
end

local telescope = require('telescope.builtin')

local keymaps = {
	n = {
		['<Space>'] = '<Nop>', -- Why does this move one char right anyways?
		[';'] = ':', -- I never use ; to goto next instance in line, but I save and quit files a lot.
		['<C-f>'] = ':%s/', -- Like other editors
		['<C-h>'] = '<C-w>h',
		['<C-j>'] = '<C-w>j',
		['<C-k>'] = '<C-w>k',
		['<C-l>'] = '<C-w>l',
		['<Tab>'] = '<cmd>bn<CR>', -- Next buffer
		['<S-Tab>'] = '<cmd>bp<CR>', -- Previous buffer
		['<leader>e'] = '<cmd>e $MYVIMRC<CR>', -- Edit nvim config
		['<leader>f'] = telescope.find_files,
		['<leader>g'] = telescope.live_grep,
		['<leader>t'] = telescope.buffers,
		['<leader>x'] = '<cmd>bd<CR>', -- Close buffer
		['<leader>v'] = '<cmd>vsplit<CR>',
		['<leader>q'] = '<cmd>copen<CR>', -- Open quickfix
		['<leader>rr'] = vim.lsp.buf.references,
		['<leader>rf'] = vim.lsp.buf.code_action,
		['<leader>m'] = vim.lsp.buf.format,
		['<leader>rn'] = vim.lsp.buf.rename, -- Rename symbol
		['<leader>D'] = vim.lsp.buf.declaration,
		['<leader>d'] = vim.lsp.buf.definition,
		['<leader>i'] = vim.lsp.buf.implementation,
		['<leader>h'] = vim.lsp.buf.hover,
		['<leader>s'] = '<cmd>ClangdSwitchSourceHeader<CR>',
		['[d'] = vim.diagnostic.goto_prev,
		[']d'] = vim.diagnostic.goto_next,
		[']n'] = '<cmd>cprev<CR>',
		['[n'] = '<cmd>cnext<CR>',
		['<ESC>'] = '<cmd>noh | echon<CR>', -- No highlight 
		-- folding
		['<A-j>'] = 'zj', -- Goto next fold
		['<A-k>'] = 'zk', -- Goto previous fold
		['<CR>'] = open_closed_fold,
		['z{'] = 'zm', -- Increase folding
		['z}'] = 'zr',  -- Reduce folding
		['g{'] = 'zM', -- Fold all
		['g}'] = 'zR', -- Undold all
	},
	i = {
		['<C-Space>'] = '<C-X><C-O>', -- Omnifunc
		['<C-K>'] = vim.lsp.buf.signature_help,
	},
}

for mode, mappings in pairs(keymaps) do
	for lhs, rhs in pairs(mappings) do
		vim.keymap.set(mode, lhs, rhs)
	end
end
