return {
  { -- Load the WhichKey plugin
    'folke/which-key.nvim',
    event = 'VimEnter', -- Load the plugin after Vim starts
    config = function()
      local wk = require 'which-key'

      -- Setup configuration for WhichKey
      wk.setup {
        preset = 'modern', -- Use the helix preset style for keybinding
        delay = 200, -- Set a delay if needed
        -- Define custom triggers (only show for <leader> in normal and visual modes)
        triggers = {
          { '<auto>', mode = 'nxso' }, -- Trigger WhichKey for <leader>
        },
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },

        -- Defer the popup for operators like 'd' and 'y'
        defer = function(ctx)
          -- Defer for delete and yank operators
          if vim.list_contains({ 'd', 'y' }, ctx.operator) then
            return true
          end
          -- Defer for visual block and line modes
          return vim.list_contains({ '<C-V>', 'V' }, ctx.mode)
        end,
      }

      -- Define key mappings
      wk.add {
        -- Group for File-related mappings
        { '<leader>f', group = '[F]ile' }, -- Group description
        { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find File' }, -- Find file with Telescope
        { '<leader>fn', '<cmd>enew<cr>', desc = 'New File' }, -- Open a new file

        -- Group for Window-related mappings
        { '<leader>w', group = '[W]indows' }, -- Group description
        { '<leader>ww', '<cmd>vsplit<cr>', desc = 'Split Window' }, -- Vertical split
        { '<leader>wq', '<cmd>wq<cr>', desc = 'Save and Quit' }, -- Save and quit

        -- Quit command
        { '<leader>q', '<cmd>q<cr>', desc = 'Quit' }, -- Quit Vim

        -- Example of a hidden keymap
        { '<leader>h1', hidden = true }, -- Hidden keymap (won't be shown in WhichKey)

        -- Example of a proxy mapping for <leader>w to window management
        { '<leader>w', proxy = '<c-w>', group = '[W]indows' }, -- Proxy to window management

        -- Example of using expand for dynamic mappings (optional)
        {
          '<leader>b',
          group = 'Buffers',
          expand = function()
            return require('which-key.extras').expand.buf()
          end,
        },

        -- Nested mappings are allowed with modes
        {
          mode = { 'n', 'v' }, -- Normal and visual mode
          { '<leader>q', '<cmd>q<cr>', desc = 'Quit' }, -- Quit in both normal and visual modes
          { '<leader>w', '<cmd>w<cr>', desc = 'Write' }, -- Write (save)
        },
      }
    end,
  },
}
