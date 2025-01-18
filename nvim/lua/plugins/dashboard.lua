return {
  'folke/snacks.nvim',
  opts = {
    dashboard = {
      sections = {

        {
          section = 'terminal',
          cmd = 'cat ~/知識の書庫/todo.md',
          ttl = 0,
          height = 18,
          indent = 15,
          pane = 1,
          padding = 1,
        },
        {
          section = 'terminal',
          cmd = 'krabby random -i',
          --cmd = 'krabby name eternatus -i',
          height = 35, -- height big bc we got some big bois
          ttl = 0,
          pane = 2,
          indent = 15,
        },
      },
    },
  },
}
