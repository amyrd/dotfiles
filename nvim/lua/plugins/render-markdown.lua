return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- or use 'mini.icons' or 'nvim-web-devicons'
  config = function()
    require('render-markdown').setup {
      latex = {
        enabled = true,
        converter = 'latex2text',
        highlight = 'RenderMarkdownMath',
        top_pad = 1,
        bottom_pad = 0,
      },
    }
  end,
}
