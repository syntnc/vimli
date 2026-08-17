local icons = require("utils.icons")
local lsp_utils = require("utils.lsp")

require("core.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = plug("neovim/nvim-lspconfig") },
    { src = plug("artemave/workspace-diagnostics.nvim") },
    { src = plug("folke/lazydev.nvim") },
  })

  require("lazydev").setup({
    library = {
      vim.fn.stdpath("data") .. "/site/pack/core/opt/blink.cmp/lua",
      vim.fn.stdpath("data") .. "/site/pack/core/opt/blink.lib/lua",
    },
  })

  local disabled_servers = {}

  local servers = vim.tbl_filter(
    function(s)
      return not vim.tbl_contains(disabled_servers, s)
    end,
    vim.tbl_map(function(f)
      return vim.fn.fnamemodify(f, ":t:r")
    end, vim.fn.glob(vim.fn.stdpath("config") .. "/lua/lsp/*.lua", false, true))
  )

  vim.lsp.enable(servers)

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      local buf = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- keymaps
      lsp_utils.setup_keymaps(buf)

      if client then
        -- Highlights
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          lsp_utils.setup_highlights(client, buf)
        end

        -- Workspace diagnostics
        if client:supports_method("workspace/diagnostic", buf) then
          vim.lsp.buf.workspace_diagnostics({ client_id = client.id })
        else
          require("workspace-diagnostics").populate_workspace_diagnostics(client, buf)
        end

        -- Inline completion
        if client:supports_method("textDocument/inlineCompletion", buf) then
          vim.lsp.inline_completion.enable(true)
        end

        -- Linked editing (e.g., paired HTML tags)
        if client:supports_method("textDocument/linkedEditingRange", buf) then
          vim.lsp.linked_editing_range.enable(true, { bufnr = buf })
        end

        -- Inline color swatches
        if client:supports_method("textDocument/documentColor", buf) then
          vim.lsp.document_color.enable(true, { bufnr = buf })
        end

        -- Diagnostics
        local diagnostics_opts = {
          virtual_text = false,
          float = { source = true, severity_sort = true, border = "solid" },
        }
        vim.diagnostic.config(vim.deepcopy(diagnostics_opts))
        for type, icon in pairs(icons.diagnostics) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
      end
    end,
  })
end)
