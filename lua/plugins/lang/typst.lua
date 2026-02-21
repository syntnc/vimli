return {
  -- Previewer
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {},
  },

  -- Highlighting and text objects
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "typst" },
    },
  },

  -- Installer
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "tinymist", "typstyle" })
    end,
  },

  -- LSP
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      servers = {
        tinymist = {
          settings = {
            formatterMode = "typstyle",
            exportPdf = "onType",
            semanticTokens = "disable",
          },
        },
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, {
        typst = { "typstyle" },
      })
    end,
  },
}
