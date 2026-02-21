return {
  -- highlighting and text objects
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst" })
    end,
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "black",
        "debugpy",
        "flake8",
        "isort",
        "mypy",
        "pylint",
        -- "ruff",
      })
    end,
  },

  -- LSP
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoImportCompletions = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "standard",
              },
              diagnosticSeverityOverrides = {},
            },
          },
        },
        -- ruff_lsp = {
        --   filetypes = { "python" },
        --   on_attach = function(client, _)
        --     -- Disable hover in favor of Pyright
        --     client.server_capabilities.hoverProvider = false
        --   end,
        -- },
      },
    },
  },

  -- formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        python = { "isort", "black" },
      })
      opts.formatters = opts.formatters or {}
      opts.formatters = vim.tbl_deep_extend("force", opts.formatters, {
        black = {
          prepend_args = { "--fast", "--line-length=80" },
        },
      })
    end,
  },
}
