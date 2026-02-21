local M = {}

local base = require("utils.base")

-- get winnrs for qflists visible in current tab
local function get_visible_qflists()
  return base.filter(vim.api.nvim_tabpage_list_wins(0), function(_, winnr)
    return vim.fn.getwininfo(winnr)[1].quickfix == 1
  end)
end

-- quickfix: toggle qflist
function M.qflist()
  -- open if no windows with type quickfix in current tabpage
  print("Processing command")
  if vim.tbl_isempty(get_visible_qflists()) then
    vim.cmd([[ horizontal copen ]])
  else
    vim.cmd([[ cclose ]])
  end
end

-- LSP: inlay hints
---@param buf? number
---@param value? boolean
function M.inlay_hints(buf, value)
  local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if type(ih) == "function" then
    ih(buf, value)
  elseif type(ih) == "table" and ih.enable then
    if value == nil then
      value = not ih.is_enabled({ bufnr = buf or 0 })
    end
    ih.enable(value, { bufnr = buf })
  end
end

return M
