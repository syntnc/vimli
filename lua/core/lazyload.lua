local M = {}

local override_queue = {}

local function drain_override()
  if not override_queue then return end
  for _, entry in ipairs(override_queue) do
    vim.schedule(function()
      local ok, err = pcall(entry.fn)
      if not ok then
        vim.notify((".nvim.lua override error:\n%s"):format(err), vim.log.levels.ERROR)
      end
    end)
  end
  override_queue = nil
end

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = drain_override,
})

function M.on_override(fn)
  if override_queue then
    table.insert(override_queue, { fn = fn })
  else
    vim.schedule(fn)
  end
end

---@param events string|string[] autocmd event(s), e.g. "BufReadPost"
---@param fn fun() loader: `vim.pack.add()` + `setup()` + keymaps
---@param pattern? string|string[] autocmd pattern, e.g. `"python"`
function M.on_event(events, fn, pattern)
  local ev = type(events) == "table" and table.concat(events, ",") or events
  if pattern ~= nil then
    local pat = type(pattern) == "table" and table.concat(pattern, ",") or pattern
    ev = ev .. "~" .. pat
  end
  require("mini.misc").safely("event:" .. ev, fn)
end

return M

