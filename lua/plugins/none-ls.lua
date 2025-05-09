-- Format on save and linters
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvimtools/none-ls-extras.nvim',
    'jay-babu/mason-null-ls.nvim',
  },
  config = function()
    -- Initialize mason-null-ls first
    require('mason-null-ls').setup {
      ensure_installed = {
        'checkmake',
        'prettier',
        'stylua',
        'eslint_d',
        'shfmt',
        'ruff-lsp',
      },
      automatic_installation = true,
      handlers = {
        -- Add specific handler for ruff
        ruff = function()
          require('mason-null-ls').default_setup('ruff')
        end,
      },
    }

    -- Then initialize null-ls
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    local sources = {
      diagnostics.checkmake,
      formatting.prettier.with { filetypes = { 'html', 'json', 'yaml', 'markdown' } },
      formatting.stylua,
      formatting.shfmt.with { args = { '-i', '4' } },
      formatting.terraform_fmt,
      -- Simplified ruff configuration
      diagnostics.ruff,
      formatting.ruff_format,
    }

    null_ls.setup {
      debug = true,
      sources = sources,
      on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { async = false }
            end,
          })
        end
      end,
    }
  end,
}
