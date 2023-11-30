local whichkey = require('which-key')
local keymaps = {}

whichkey.setup({
	operators = {
		gc = 'Comment',
	},
})

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

keymaps.common = {
	n = {
		['<Space>'] = { '<Nop>', 'Why does this move one char right anyways?' },
		['q:'] = { '<Nop>', 'Only by mistake.' },
		[';'] = { ':', 'I never use ; to goto next instance in line.' },
		['s'] = { '<Nop>', 'I use cl for better or worse' },
		['<A-f>'] = { ':%s/', 'Start replace' },
		['<C-h>'] = { '<C-w>h', 'Goto left window' },
		['<C-j>'] = { '<C-w>j', 'Goto lower window' },
		['<C-k>'] = { '<C-w>k', 'Goto higher window' },
		['<C-l>'] = { '<C-w>l', 'Goto right window' },
		['<Tab>'] = { '<cmd>bn<CR>', 'Next buffer' },
		['<S-Tab>'] = { '<cmd>bp<CR>', 'Previous buffer' },
		['<leader>'] = {
			e = { '<cmd>e $MYVIMRC<CR>', 'Edit nvim config' },
			f = { '<cmd>Files<CR>', 'Find files' },
			g = { '<cmd>Rg<CR>', 'Find files' },
			x = { '<cmd>bd<CR>', 'Close buffer' },
			v = { '<cmd>vsplit<CR>', 'Vertical split' },
			q = { '<cmd>copen<CR>', 'Open quickfix' },
			--f = { '<cmd>Telescope find_files<CR>', 'Find files' },
			--a = { '<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>', 'Find all' },
			--g = { '<cmd>Telescope live_grep<CR>', 'Live grep' },
			--b = { '<cmd>Telescope buffers<CR>', 'Find buffers' },
			--h = { '<cmd>Telescope help_tags<CR>', 'Help page' },
			--o = { '<cmd>Telescope oldfiles<CR>', 'Find oldfiles' },
			--k = { '<cmd>Telescope keymaps<CR>', 'Show key maps' },
			--t = { '<cmd>Telescope terms<CR>', 'Pick hidden term' },
			--g = {
			--	name = 'git',
			--	g = { '<cmd> Telescope git_status <CR>', 'Git status' },
			--	c = { '<cmd> Telescope git_commits <CR>', 'Git commits' },
			--},
			wk = { '<cmd>WhichKey<CR>', 'Show keymaps' },
			r = {
				name = 'refactor',
				r = { vim.lsp.buf.references, 'Find references' },
				f = { vim.lsp.buf.code_action, 'Code action' },
				t = { vim.lsp.buf.formatting, 'Format' },
				n = { vim.lsp.buf.rename, 'Rename symbol' },
			},
			D = { vim.lsp.buf.declaration, 'Goto declaration' },
			d = { vim.lsp.buf.definition, 'Goto definition' },
			i = { vim.lsp.buf.implementation, 'Goto implementation' },
			t = { vim.lsp.buf.type_definition, 'Goto type definition' },
			h = { vim.lsp.buf.hover, 'Hover' },
			s = { '<cmd>ClangdSwitchSourceHeader<CR>', 'Switch between source/header file' },
		},
		['[d'] = { vim.diagnostic.goto_prev, 'Goto previous diagnostic' },
		[']d'] = { vim.diagnostic.goto_next, 'Goto next diagnostic' },
		[']n'] = { '<cmd>cprev<CR>', 'Goto previous quickfix item' },
		['[n'] = { '<cmd>cnext<CR>', 'Goto next quickfix item' },
		-- folding
		['<A-j>'] = { 'zj', 'Goto next fold' },
		['<A-k>'] = { 'zk', 'Goto previous fold' },
		['<ESC>'] = { '<cmd>noh | echon<CR>', 'No highlight', silent=true },
		['<CR>'] = { open_closed_fold, 'Open and go line down', silent=true },
		['z{'] = { 'zm', 'Increase folding' },
		['z}'] = { 'zr', 'Reduce folding' },
		['g{'] = { 'zM', 'Fold all' },
		['g}'] = { 'zR', 'UnFold all' },
	},
	i = {
		['<C-Space>'] = { '<C-X><C-O>', 'Omnifunc' },
		['<C-K>'] = { vim.lsp.buf.signature_help, 'Signature help' },
	},
}

for mode, mappings in pairs(keymaps.common) do
	whichkey.register(mappings, { mode = mode, silent = false })
end
