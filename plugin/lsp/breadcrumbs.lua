require("core.lazyload").on_event("LspAttach", function()
  vim.pack.add({
    { src = plug("SmiteshP/nvim-navic") },
  })

  local navic = require("nvim-navic")
  navic.setup({
    highlight = true,
    separator = " / ",
    depth_limit = 3,
    depth_limit_indicator = "..",
    lsp = { auto_attach = true },
  })
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.server_capabilities.documentSymbolProvider then
      for _, buf in ipairs(vim.tbl_keys(client.attached_buffers)) do
        if vim.api.nvim_buf_is_valid(buf) then
          pcall(navic.attach, client, buf)
        end
      end
    end
  end
end)
