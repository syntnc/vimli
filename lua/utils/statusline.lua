local M = {}

M.components = {
  -- harpoon = {
  --   function()
  --     local harpoon = require("harpoon.mark")
  --     local total_marks = harpoon.get_marks()
  --     if total_marks == 0 then
  --       return ""
  --     end
  --     local current_mark = "-"
  --     local mark_idx = harpoon.get_marks()
  --     if mark_idx ~= nil then
  --       current_mark = tostring(mark_idx)
  --     end
  --     return string.format("[%d/%s]", current_mark, total_marks)
  --   end,
  --   icon = "󰛢 ",
  -- },
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
    icon = " ",
    color = { bg = "base" },
  },
  tab_indicator = {
    function()
      local tabline = {}
      local cur_tab = vim.api.nvim_get_current_tabpage()
      for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
        if tab_id == cur_tab then
          table.insert(tabline, string.format("[%s]", tab_id))
        else
          table.insert(tabline, tab_id)
        end
      end
      return table.concat(tabline, " ")
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
