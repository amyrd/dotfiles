return {
  'kawre/leetcode.nvim',
  build = ':TSUpdate html', -- Updates Treesitter parsers for HTML, if nvim-treesitter is installed
  dependencies = {
    'nvim-telescope/telescope.nvim',
    -- 'ibhagwan/fzf-lua',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    lang = '', -- Specify the default language for Leetcode
    image_support = true,
  },
}
