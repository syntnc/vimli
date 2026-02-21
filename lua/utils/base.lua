local M = {}

---@param tbl table
---@param f function
---@param keep_keys boolean
---@return table
function M.filter(tbl, f, keep_keys)
  if not tbl or tbl == {} then
    return {}
  end
  local t = {}
  local insert = function(key, value)
    if keep_keys then
      t[key] = value
    else
      table.insert(t, value)
    end
  end
  for key, value in pairs(tbl) do
    if f(key, value) then
      insert(key, value)
    end
  end
  return t
end

---@param name string
---@return table
function M.opts(name)
  local plugin = require("lazy.core.config").plugins[name]
  if not plugin then
    return {}
  end
  return require("lazy.core.plugin").values(plugin, "opts", false)
end

return M
