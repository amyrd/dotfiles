return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html', -- Updates Treesitter parsers for HTML, if nvim-treesitter is installed
  dependencies = {
    'nvim-telescope/telescope.nvim',
    -- 'ibhagwan/fzf-lua',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Leet', -- Loads the plugin when the :Leetcode command is executed
  opts = {
    lang = '', -- Specify the default language for Leetcode
  },
}
