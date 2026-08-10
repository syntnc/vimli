local icons = require("utils.icons").statusline
local M = {}

M.components = {
  lsp_info = {
    function()
      local msg = "No Active LSP"
      local buf_ft = vim.bo.filetype
      local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
      if next(clients) == nil then
        return msg
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return msg
    end,
    icon = icons.lsp_info,
  },
  tab_indicator = {
    function()
      local tabline = {}
      local cur_tab = vim.api.nvim_get_current_tabpage()
      for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
        local tab_number = vim.api.nvim_tabpage_get_number(tab_id)
        if tab_id == cur_tab then
          table.insert(tabline, string.format("[%s]", tab_number))
        else
          table.insert(tabline, tab_number)
        end
      end
      return table.concat(tabline, " ")
    end,
    icon = icons.tab_indicator,
    color = "MoreMsg",
    cond = function()
      local tab_pages = vim.api.nvim_list_tabpages()
      return #tab_pages ~= 1
    end,
  },
}

return M
