-- vim initloptions
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.clipboard = 'unnamedplus'

-- Autocmd to clear terminal for files in a specific directory

vim.api.nvim_create_autocmd('BufReadPre', {
  pattern = '*',
  callback = function()
    local file_path = vim.fn.expand '%:p'
    -- Check if the file is in the specific directory
    if file_path:match(vim.fn.expand '~/知識の書庫/' .. '.*') then
      -- Use a delayed command to clear the terminal
      vim.defer_fn(function()
        vim.cmd 'silent !clear'
      end, 100) -- Delay in milliseconds
    end
  end,
})

require 'options'
require 'keymaps'
require 'lazy-bootstrap'
require 'lazy-plugins'
vim.cmd.colorscheme 'catppuccin'
-- vim: ts=2 sts=2 sw=2 et
