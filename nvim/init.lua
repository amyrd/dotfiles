-- load core modules
require('core.options')
require('core.keymaps')
require('core.autocmds')

-- bootstrap plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob=none',
		'https://github.com/folke/lazy.nvim.git',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require('lazy').setup('plugins')

