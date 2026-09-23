local icons = require("utils.icons")
local lsp_utils = require("utils.lsp")

require("core.lazyload").on_event({ "BufReadPre", "BufNewFile" }, function()
  vim.pack.add({
    { src = plug("neovim/nvim-lspconfig") },
    { src = plug("b0o/schemastore.nvim") },
    { src = plug("artemave/workspace-diagnostics.nvim") },
    { src = plug("rachartier/tiny-inline-diagnostic.nvim") }, -- better inline diagnostics
    { src = plug("rachartier/tiny-code-action.nvim") },       -- better code actions
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

  local did_global_setup = false

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
      local buf = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)

      -- Global (once): plugin setup, diagnostic style + signs.
      if not did_global_setup then
        did_global_setup = true
        lsp_utils.setup_plugins()

        vim.diagnostic.config({
          virtual_text = false,
          float = { source = true, severity_sort = true, border = "solid" },
        })
        for type, icon in pairs(icons.diagnostics) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end
      end

      -- Per-buffer keymaps
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
      end
    end,
  })

  -- Session restores can leave a loaded file buffer with no client and no
  -- error; re-run activation for exactly those buffers once restore ends.
  vim.api.nvim_create_autocmd("SessionLoadPost", {
    group = vim.api.nvim_create_augroup("lsp-session-restore", { clear = true }),
    callback = function()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if
          vim.api.nvim_buf_is_valid(buf)
          and vim.api.nvim_buf_is_loaded(buf)
          and (vim.bo[buf].buftype == "" or vim.bo[buf].buftype == "help")
          and vim.bo[buf].filetype ~= ""
          and #vim.lsp.get_clients({ bufnr = buf }) == 0
        then
          vim.api.nvim_exec_autocmds("FileType", {
            buffer = buf,
            group = "nvim.lsp.enable",
            modeline = false,
          })
        end
      end
    end,
  })
end)
