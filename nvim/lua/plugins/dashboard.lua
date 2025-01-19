return {
  'folke/snacks.nvim',
  opts = {
    dashboard = {
      pane_gap = 2,
      sections = {
        {
          section = 'terminal',
          cmd = 'cat ~/知識の書庫/todo.md',
          ttl = 0,
          indent = 4,
          padding = 5,
        },
        {
          section = 'terminal',
          cmd = 'krabby random -i',
          --cmd = 'krabby name eternatus -i',
          ttl = 0,
          pane = 2,
          indent = 4,
          height = 30,
          width = 60,
        },
      },
    },
  },
}
