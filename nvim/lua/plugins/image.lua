return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1001,
    opts = {
      rocks = { 'magick' },
    },
  },
  {
    '3rd/image.nvim',
    build = false,
    dependencies = { 'luarocks.nvim' },
    ft = { 'markdown' },
    config = function()
      require('image').setup {
        backend = 'kitty',
        with_virtual_padding = true,
        kitty_method = 'normal',
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'markdown', 'vimwiki' },
          },
        },
        default_geometry = { -- Default padding and size for all images
          x = 2, -- Horizontal padding
          y = 2, -- Vertical padding
          width = 80, -- Image width
          height = 40, -- Image height
        },
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = true,
        editor_only_render_when_focused = true,
        tmux_show_only_in_active_window = true,
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif', '*pdf' },
      }
    end,
  },
}
