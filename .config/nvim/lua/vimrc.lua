local g = vim.g
g.mapleader = ' '
g.rust_recommended_style = 0
g.zig_fmt_autosave = 0

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
o.autoindent = true
o.smarttab = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
-- see autocmd.lua for more tab opts
-- towards displaying 4 space tabs as 2 spaces (see autocmd.lua for the rest)
o.concealcursor = 'nvi'
o.conceallevel = 1
-- display tabs different than spaces to maintain sanity
o.list = true
o.listchars = { tab = '|-' }
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

-- workaround rolldown bug
o.backup = false
o.writebackup = false

-- Do not conceal links in MD files
o.conceallevel = 0

o.mouse = ''

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
}
for _, plugin in pairs(disabled_plugins) do
	g['loaded_' .. plugin] = 1
end
