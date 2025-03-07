return {
  {
    -- Main plugin for LSP configuration
    'neovim/nvim-lspconfig',
    dependencies = {

      -- Mason plugins for managing external tools
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      -- Helps with Lua development by providing autocompletion and Neovim-specific API info
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- This function runs whenever an LSP server attaches to a buffer (a file in Neovim)
      local on_attach = function(client, bufnr)
        -- Helper function to create key mappings
        local function map(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- Define key mappings for LSP features
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

        -- Highlight words under the cursor
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

        -- Toggle inlay hints
        if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
          map('<leader>th', function()
            vim.lsp.inlay_hint(bufnr, nil)
          end, '[T]oggle Inlay [H]ints')
        end
      end

      -- Define client capabilities for LSP servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Define the LSP servers to configure
      local servers = {
        clangd = { filetypes = { 'c', 'cpp', 'objc', 'objcpp' } },
        gopls = {}, -- Go
        pyright = {

          single_file_support = true,
        }, -- Python
        rust_analyzer = { -- Rust
          root_dir = function(fname)
            return require('lspconfig.util').root_pattern('Cargo.toml', '.git')(fname) or vim.fn.fnamemodify(fname, ':p:h')
          end,
        },
        cssls = {
          eslint = {},
          ts_ls = {},
        }, -- CSS
        html = {}, -- HTML
        sqls = { -- SQL
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false -- Disable formatting for SQL
            on_attach(client, bufnr)
          end,
        },
        lua_ls = { -- Lua (for Neovim configurations)
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
      }

      local lspconfig = require 'lspconfig'
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      lspconfig.emmet_ls.setup {
        -- on_attach = on_attach,
        capabilities = capabilities,
        filetypes = { 'css', 'eruby', 'html', 'javascript', 'javascriptreact', 'less', 'sass', 'scss', 'svelte', 'pug', 'typescriptreact', 'vue' },
        init_options = {
          html = {
            options = {
              -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
              ['bem.enabled'] = true,
            },
          },
        },
      }
      -- Ensure the specified LSP servers are installed
      local ensure_installed = vim.tbl_keys(servers)
      local mason_lspconfig = require 'mason-lspconfig'
      mason_lspconfig.setup {
        ensure_installed = { 'pyright' },
      }
      require('lspconfig').pyright.setup {
        capabilities = capabilities,
      }
      -- Mason setup
      require('mason').setup()

      -- Mason-LSPConfig setup
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed, -- Servers to install
        automatic_installation = true, -- Automatically install missing servers
      }

      -- Mason-Tool-Installer setup for additional tools
      require('mason-tool-installer').setup {
        ensure_installed = { 'stylua' }, -- Add tools like formatters and linters here
      }

      -- Configure the LSP servers
      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server_opts = servers[server_name] or {}
            server_opts.capabilities = vim.tbl_deep_extend('force', capabilities, server_opts.capabilities or {})
            server_opts.on_attach = server_opts.on_attach or on_attach
            require('lspconfig')[server_name].setup(server_opts)
          end,
        },
      }

      -- Cleanup: Clear highlights when LSP detaches
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
