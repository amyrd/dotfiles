return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = "markdown", -- only load for markdown files

  ---@type obsidian.config.ClientOpts
  opts = {
    disable_frontmatter = true,
    ui = {
      enable = false,
      checkboxes = {
        [" "] = { char = "", hl_group = "ObsidianTodo", order = 1 },
        ["x"] = { char = "", hl_group = "ObsidianDone", order = 2 },
      },
    },
    note_path_func = function(spec)
      local title = spec.title or "Untitled"
      local path = spec.dir / title
      return path:with_suffix ".md"
    end,
    workspaces = {
      {
        name = "personal",
        path = vim.fn.expand "~/知識の書庫/",
      },
    },
    templates = {
      folder = vim.fn.expand "~/知識の書庫/雑多/template/",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
      default = "default.md",
    },
    follow_url_func = function(url)
      vim.fn.jobstart { "open", url } -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- Linux
    end,
  },

  keys = {
    { "<C-v>", ":ObsidianFollowLink vsplit<CR>", desc = "open link as vertical split" },
    { "-#", ":ObsidianTags<CR>", desc = "tags" },
    { "-l", ":ObsidianBacklinks<CR>", desc = "backlinks" },
    { "-i", ":ObsidianTemplate<CR>", desc = "insert template" },
    { "-t", ":ObsidianNewFromTemplate<CR>", desc = "create note from template" },
    { "-n", ":ObsidianNew<CR>", desc = "create new note" },
    { "-s", ":ObsidianQuickSwitch<CR>", desc = "open obsidian file search" },
    { "-f", ":ObsidianSearch<CR>", desc = "open obsidian word search" },
    { "-d", ":ObsidianToday<CR>", desc = "open today's notes" },
  },
}

