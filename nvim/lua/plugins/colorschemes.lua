return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
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
      vim.cmd 'colorscheme cyberdream' -- set the colorscheme
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
