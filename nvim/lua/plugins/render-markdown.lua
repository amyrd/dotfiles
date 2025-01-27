--[[
--return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  config = function()
    require('markview').setup {
      checkboxes = {
        enable = true,
        checked = {
          text = '✔', -- Symbol for checked checkboxes
          hl = 'MarkviewCheckboxChecked', -- Highlight for the checkbox itself
          scope_hl = 'MarkviewCheckboxStrikethrough', -- Highlight for the entire line
        },
        unchecked = {
          text = '✘', -- Symbol for unchecked checkboxes
          hl = 'MarkviewCheckboxUnchecked',
          scope_hl = nil,
        },
        -- Additional states can be defined here
      },
      {
        preview = {
          icon_provider = 'devicons', -- "mini" or "devicons"
        },
      },
      -- Add any other necessary configurations here
    }

    -- Define the strikethrough highlight group
    vim.api.nvim_set_hl(0, 'MarkviewCheckboxStrikethrough', { strikethrough = true })
  end,
}
--]]

return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-web-devicons' },
  opts = {},
  config = function()
    require('render-markdown').setup {
      checkbox = {
        checked = { scope_highlight = '@markup.strikethrough' },
      },
      latex = {
        enabled = true,
        converter = 'latex2text',
        highlight = 'RenderMarkdownMath',
        top_pad = 1,
        bottom_pad = 0,
      },
      code = {
        width = 'block',
      },
      heading = {
        enabled = true,
      },
      quote = {
        repeat_linebreak = true,
      },
    }
    vim.api.nvim_set_keymap('n', '<leader>:', 'viw<esc>a*<esc>bi*<esc>l', { noremap = true, silent = true })
  end,
}
