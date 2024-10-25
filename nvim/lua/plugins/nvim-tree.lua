-- Disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- Set up nvim-tree with a visible vertical separator
      require('nvim-tree').setup {
        view = {
          side = 'left',
          width = 30, -- Set the width to something more appropriate for a sidebar
          float = {
            enable = false, -- Disable floating window to behave like a regular sidebar
          },
        },
        renderer = {
          highlight_opened_files = 'none',
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
          indent_markers = {
            enable = true, -- Enable indent markers to add a vertical line
            icons = {
              corner = '└',
              edge = '│',
              item = '│',
              bottom = '─',
              none = ' ',
            },
          },
        },
      }
      -- Set a color for the indent markers

      -- Keymap to toggle nvim-tree
      vim.keymap.set('n', '|', ':NvimTreeToggle<CR>', { desc = 'opens tree', noremap = true, silent = true })
    end,
  },
}
