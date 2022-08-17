local g = vim.g
g.mapleader = ' '
g.colorscheme = 'spacegray'

local o = vim.opt
o.mouse = 'a'
o.termguicolors = true
-- share clipboard with OS
o.clipboard = 'unnamedplus'
-- allow backspacing autoindent, eol, before start of insert
o.backspace = 'indent,eol,start'
-- show diagnostics and autosave quickly
o.updatetime = 500

-- display tab as 2 spaces
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
-- g.latex_to_unicode_tab = 0

-- line numbers
o.number = true
o.signcolumn = 'yes'

o.incsearch = true -- highlight matches
o.scrolloff = 8    -- keep bottom 8 lines when paging up/down
o.swapfile = false -- swapfiles are pointless
o.undofile = true  -- save undo history to file
o.showmode = false -- i know what mode i'm in
o.completeopt = 'menu,menuone,noselect' -- when to offer completion menu
o.colorcolumn = '80' -- right border
o.statusline = '%<%f %h%m%r%=%{"[".(&fenc==""?&enc:&fenc).((exists("+bomb") && &bomb)?",B":"")."] "}%k %-14.(%l,%c%V%) %P'

-- search
o.ignorecase = true
o.smartcase = true

o.splitright = true

local disabled_plugins = {
	'2html_plugin',
	'getscript',
	'getscriptPlugin',
	'gzip',
	'logipat',
	'netrw',
	'netrwPlugin',
	'netrwSettings',
	'netrwFileHandlers',
	'matchit',
	'tar',
	'tarPlugin',
	'rrhelper',
	'spellfile_plugin',
	'vimball',
	'vimballPlugin',
	'zip',
	'zipPlugin',
	'python3_provider',
	'python_provider',
	'node_provider',
	'ruby_provider',
	'perl_provider',
	'tutor',
	'rplugin',
	'syntax',
	'synmenu',
	'optwin',
	'compiler',
	'bugreport',
	'ftplugin',
}

for _, plugin in pairs(disabled_plugins) do
	g['loaded_' .. plugin] = 1
end
