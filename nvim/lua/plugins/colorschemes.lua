return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup {
        -- Recommended - see "Configuring" below for more config options
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = false,
        terminal_colors = false,
      }
      vim.cmd 'colorscheme cyberdream' -- set the colorscheme
    end,
  },
  {
    'rebelot/kanagawa.nvim',
  },
}
-- vim: ts=2 sts=2 sw=2 et
