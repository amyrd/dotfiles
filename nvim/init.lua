-- Set leader key early
vim.g.mapleader = ' '

-- Load core settings
require('core.options')
require('core.keymaps')

-- Bootstrap lazy.nvim (FIXED VERSION)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- important for stability
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim
require("lazy").setup("plugins", {
  install = {
    missing = true, -- automatically install missing plugins
    colorscheme = { "catppuccin" }
  },
})
