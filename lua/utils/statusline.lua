local M = {}

M.components = {
  lsp_info = {
    function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return "No Active LSP"
      end
      return table.concat(
        vim
          .iter(clients)
          :map(function(client)
            return client.name
          end)
          :totable(),
        ", "
      )
    end,
    icon = " ",
    color = { bg = "base" },
  },
  tab_indicator = {
    function()
      local cur = vim.api.nvim_get_current_tabpage()
      return table.concat(
        vim
          .iter(vim.api.nvim_list_tabpages())
          :map(function(id)
            return id == cur and string.format("[%s]", id) or tostring(id)
          end)
          :totable(),
        " "
      )
    end,
    icon = " ",
    color = "MoreMsg",
    cond = function()
      local tab_pages = vim.api.nvim_list_tabpages()
      return #tab_pages ~= 1
    end,
  },
}

return M
