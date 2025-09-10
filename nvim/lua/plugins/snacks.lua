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
          cmd = 'echo "you are what you put your focus to"',
          ttl = 0,
          pane = 1,
          indent = 4,
          -- height for donut
          --height = 60,
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
    },
  },
}
