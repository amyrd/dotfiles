return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'markdown_inline',
        'fsharp',
        'latex',
        'go',
        'html',
        'javascript',
        'css',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
