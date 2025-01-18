return {
  'folke/snacks.nvim',
  opts = {
    dashboard = {
      sections = {
        {
          section = 'terminal',
          cmd = 'krabby random -i',
          random = 11,
          height = 20,
          padding = 0,
          indent = 15,
        },
        {
          section = 'terminal',
          cmd = 'cat ~/知識の書庫/todo.md',
          height = 15,
          indent = 15,
        },
      },
    },
  },
}
