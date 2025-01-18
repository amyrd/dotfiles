return {
  {
    '3rd/image.nvim',
    build = false,
    dependencies = { 'luarocks.nvim' },
    ft = { 'markdown' },
    config = function()
      require('image').setup {
        backend = 'kitty',
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
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false,
        editor_only_render_when_focused = true,
        tmux_show_only_in_active_window = true,
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif', '*pdf' },
      }
    end,
  },
}
