return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-web-devicons' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  config = function()
    require('render-markdown').setup {
      checkbox = {
        checked = { scope_highlight = '@markup.strikethrough' },
      },
      latex = {
        enabled = true,
        converter = 'latex2text',
        highlight = 'RenderMarkdownMath',
        top_pad = 1,
        bottom_pad = 0,
      },
      code = {
        width = 'block',
      },
      heading = {
        enabled = false,
      },
      quote = {
        repeat_linebreak = true,
      },
    }
    vim.api.nvim_set_keymap('n', '<leader>:', 'viw<esc>a*<esc>bi*<esc>l', { noremap = true, silent = true })
  end,
}
