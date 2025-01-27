return {
  {
    'catppuccin/nvim',
    as = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = {
          light = 'latte',
          dark = 'mocha',
        },
        color_overrides = {
          all = {
            base = '#000000',
          },
          no_italic = false, -- Force no italic
          no_bold = false,
        },
        transparent_background = false,
        term_colors = false,
        dim_inactive = {
          enabled = true, -- dims the background color of inactive window
          shade = '#000000',
          percentage = 0.40, -- percentage of the shade to apply to the inactive window
        },
      }
    end,
  },

  {
    'scottmckendry/cyberdream.nvim',
    lazy = false, -- Load lazily
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        transparent = true, -- enable transparent background
        italic_comments = true, -- italicize comments
        hide_fillchars = true, -- hide filler characters
        borderless_telescope = false, -- keep telescope borders
        terminal_colors = false, -- disable terminal-specific colors
        theme = {
          highlights = {
            TelescopeBorder = { fg = '#FFFFFF' },
            FloatBorder = { fg = '#FFFFFF' },
          },
        },
        cache = true, -- add cache field (required by the plugin)
      }
    end,
  },

  {
    'nyngwang/nvimgelion',
    lazy = true, -- load lazily if not used immediately
    config = function()
      -- Add any customization here for nvimgelion
    end,
  },
}
