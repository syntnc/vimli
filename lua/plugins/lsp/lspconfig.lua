local icons = require("utils.icons")
local lsp_utils = require("utils.lsp")

return {
  {
    -- LSP Configuration & Plugins
    -- See `:help lsp-vs-treesitter`
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      "mason.nvim", -- NOTE: Must be loaded before dependants
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },
      { "Saghen/blink.cmp" },
      {
        "folke/lazydev.nvim",
        dependencies = { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            { path = "snacks.nvim", words = { "Snacks" } },
          },
        },
      },
      -- breadcrumbs
      "SmiteshP/nvim-navic",
    },
    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
    opts = {
      codelens = { enabled = true },
      ---@type vim.diagnostic.Opts
      diagnostics = {
        virtual_text = false,
        float = { source = true, severity_sort = true, border = "solid" },
      },
      -- Enable builtin LSP inlay hints
      inlay_hints = { enabled = false },
      -- List of language servers to enable
      servers = {},
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          -- keymaps
          lsp_utils.setup_keymaps(event.buf)

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client then
            if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
              lsp_utils.setup_highlights(event.buf)
            end
            -- breadcrumbs
            if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentSymbol, event.buf) then
              require("nvim-navic").attach(client, event.buf)
            end
            -- inlay hints
            if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
              local toggles = require("utils.toggles")
              vim.keymap.set("n", "<leader>uh", function()
                toggles.inlay_hints()
              end, { desc = "Toggle Inlay [H]ints" })
              vim.lsp.inlay_hint.enable(opts.inlay_hints.enabled)
            end
            -- codelens
            if opts.codelens.enabled == true then
              if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, event.buf) then
                lsp_utils.setup_codelens(event.buf)
              end
            end
          end

          -- diagnostics
          vim.diagnostic.config(vim.deepcopy(opts.diagnostics))
          for type, icon in pairs(icons.diagnostics) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
          end
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

      local ensure_installed = vim.tbl_keys(opts.servers or {})
      -- mason-tool-installer can further extend Mason to install additional tools
      -- Language specific tools are provided from lua/plugins/lang/*.lua
      -- Add more tools below if needed:
      -- vim.list_extend(ensure_installed, {})
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      require("mason-lspconfig").setup({
        ensure_installed = {}, -- explicitly set to an empty table (already populated via mason-tool-installer)
        automatic_enable = true, -- automatically run vim.lsp.enable() for all servers that are installed via Mason
      })
    end,
  },

  -- Set up installer
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    opts = {
      ensure_installed = {},
      ui = { icons = icons.mason },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
