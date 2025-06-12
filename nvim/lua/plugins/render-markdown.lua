return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-web-devicons' },
  opts = {},
  config = function()
    require('render-markdown').setup {
      checkbox = {
        checked = { scope_highlight = '@markup.strikethrough' },
      },
     code = { -- how code is rendered
        width = 'block',
      },
      heading = {
        enabled = true,
      },
      quote = {
        repeat_linebreak = true,
      },
    }
    -- adds '*' around word
    vim.api.nvim_set_keymap('n', '<leader>:', 'viw<esc>a*<esc>bi*<esc>l', { noremap = true, silent = true })
  end,
}
