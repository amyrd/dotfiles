return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('obsidian').setup {
        disable_frontmatter = true,

        note_id_func = function(title)
          if title ~= nil then
            return title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
          else
            return tostring(os.time())
          end
        end,

        note_path_func = function(spec)
          local path = spec.dir / tostring(spec.id)
          return path:with_suffix '.md'
        end,

        workspaces = {
          {
            name = 'personal',
            path = vim.fn.expand '~/知識の書庫/',
          },
        },

        templates = {
          folder = vim.fn.expand '~/知識の書庫/雑多/template',
          date_format = '%Y-%m-%d-%a',
          time_format = '%H:%M',
        },
        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        ---@param url string
        follow_url_func = function(url)
          -- Open the URL in the default web browser.
          vim.fn.jobstart { 'open', url } -- Mac OS
          -- vim.fn.jobstart({"xdg-open", url})  -- linux
        end,
      }

      vim.keymap.set('n', '-#', ':ObsidianTags<CR>', { desc = 'tags' })
      vim.keymap.set('n', '-l', ':ObsidianBacklinks<CR>', { desc = 'backlinks' })
      vim.keymap.set('n', '-i', ':ObsidianTemplate<CR>', { desc = 'insert template' })
      vim.keymap.set('n', '-t', ':ObsidianNewFromTemplate<CR>', { desc = 'create note from template' })
      vim.keymap.set('n', '-n', ':ObsidianNew<CR>', { desc = 'create new note ' })
      vim.keymap.set('n', '-s', ':ObsidianQuickSwitch<CR>', { desc = 'open obsidian file search' })
      vim.keymap.set('n', '-f', ':ObsidianSearch<CR>', { desc = 'open obsian word search' })
      vim.keymap.set('n', '-d', ':ObsidianToday<CR>', { desc = "open today's notes" })
    end,
  },
}
