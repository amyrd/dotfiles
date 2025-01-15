return {
  {
    -- The main plugin that enables support for Language Server Protocol (LSP)
    'neovim/nvim-lspconfig',
    -- Load the plugin when you open a file or create a new one
    event = { 'BufReadPre', 'BufNewFile' },
    -- Other plugins that this configuration depends on
    dependencies = {
      -- Mason: A plugin to manage external tools like LSP servers
      { 'williamboman/mason.nvim', config = true },
      -- Makes Mason work with nvim-lspconfig for installing LSP servers
      'williamboman/mason-lspconfig.nvim',
      -- Installs additional tools automatically with Mason
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- A plugin that provides a small status window for LSP progress
      { 'j-hui/fidget.nvim', opts = {} },
      -- A helper plugin to make working with Lua in Neovim easier
      { 'folke/lazydev.nvim', ft = 'lua', opts = {} },
    },
    -- The main configuration function for setting up LSP
    config = function()
      -- Function that runs whenever an LSP server attaches to a file buffer
      local on_attach = function(client, bufnr)
        -- Helper function to create key mappings
        local function map(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- Keybindings for LSP features
        -- These let you navigate and use LSP features like finding definitions or renaming variables
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Adds custom borders to floating windows (optional aesthetic improvement)
        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

        -- Highlight words under the cursor (useful for tracking references in code)
        if client.server_capabilities.documentHighlightProvider then
          local highlight_group = vim.api.nvim_create_augroup('LSPDocumentHighlight', { clear = true })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = highlight_group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = highlight_group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end

        -- Toggle inlay hints (annotations in code like parameter names)
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint(bufnr, nil)
          end, '[T]oggle Inlay [H]ints')
        end
      end

      -- Capabilities describe what Neovim's LSP client can do
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- List of LSP servers to configure
      -- Each entry can have settings to customize its behavior
      local servers = {
        clangd = { filetypes = { 'c', 'cpp', 'objc', 'objcpp' } },
        gopls = {}, -- Go programming language
        pyright = {}, -- Python
        rust_analyzer = {
          -- Custom function to determine the project root for Rust
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern('Cargo.toml', '.git')(fname) or vim.fn.fnamemodify(fname, ':p:h')
          end,
        },
        cssls = {}, -- CSS
        html = {}, -- HTML
        sqls = {
          -- Disable automatic formatting for SQL
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            on_attach(client, bufnr)
          end,
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
      }

      -- Ensure these servers are installed by Mason
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { 'stylua' }) -- Add other tools like formatters

      -- Set up Mason and Mason-related plugins
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed, -- Install listed servers
        automatic_installation = true, -- Automatically install missing servers
      }
      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed, -- Install tools like formatters and linters
      }

      -- Configure LSP servers using Mason
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server_opts = servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend('force', capabilities, server_opts.capabilities or {})
            server_opts.on_attach = server_opts.on_attach or on_attach
            require('lspconfig')[server_name].setup(server_opts)
          end,
        },
      }

      -- Clear highlights when an LSP server detaches
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('LSPDetach', { clear = true }),
        callback = function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'LSPDocumentHighlight', buffer = event.buf }
        end,
      })
    end,
  },
}
