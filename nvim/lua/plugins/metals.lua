return
  {
  "scalameta/nvim-metals",
  ft = { "scala", "sbt"},
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local metals = require("metals")
    local metals_config = metals.bare_config()

    -- use the same capabilities you set for other LSPs
    metals_config.capabilities = require("blink.cmp").get_lsp_capabilities()

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "java" },
      callback = function()
        metals.initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}

