return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      pane_gap = 2,
      sections = {
        {
          section = 'terminal',
          cmd = 'cat ~/知識の書庫/todo.md; sleep .1',
          ttl = 0,
          indent = 4,
          padding = 5,
        },
        {
          section = 'terminal',
          cmd = 'krabby random -i; sleep .1',
          ttl = 0,
          pane = 2,
          indent = 4,
          -- height for donut
          --height = 60,
          height = 30,
          width = 60,
        },
      },
    },
    image = {
      doc = {
        enabled = true,
        inline = false,
        float = true,
        max_width = 80,
        max_height = 80,
      },
    },
  },
  keys = {
    {"<leader>tu", function() require("snacks").picker.colorschemes({layout = "ivy"}) end, desc = "Pick Color Schemes"},
  },
}
