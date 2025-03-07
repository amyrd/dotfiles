require('lazy').setup({
  'tpope/vim-sleuth',
  -- Use `opts = {}` to force a plugin to be loaded.
  { 'numToStr/Comment.nvim', opts = {} },

  require 'plugins/gitsigns',

  require 'plugins/which-key',

  require 'plugins/telescope',

  require 'plugins/lspconfig',

  require 'plugins/conform',

  require 'plugins/cmp',

  require 'plugins/colorschemes',

  require 'plugins/todo-comments',

  require 'plugins/mini',

  require 'plugins/treesitter',
  --require 'plugins/nvim-tree',
  --require 'plugins/ui',
  require 'plugins/dashboard',

  require 'plugins/autopairs',

  require 'plugins/obsidian',

  require 'plugins/image',

  require 'plugins/imageclip',
  require 'plugins/typer',

  require 'plugins/nvim-java',

  require 'plugins/speedtype',

  require 'plugins/noice',

  require 'plugins/render-markdown',

  require 'plugins/lc',

  require 'plugins/snow',
  require 'plugins/oil',
  -- require 'plugins/avante',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
