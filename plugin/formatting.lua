require("core.lazyload").on_vim_enter(function()
  -- add plugin
  vim.pack.add({
    { src = plug("stevearc/conform.nvim") },
  })

  -- configure plugin
  local merge = require("core.merge")
  local opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = {}
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {},
  }
  merge(opts, _G.Config.conform or {})
  require("conform").setup(opts)

  -- keymaps
  vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({ async = true, lsp_fallback = true })
  end)
end)

