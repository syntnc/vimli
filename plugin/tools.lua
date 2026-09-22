local loaded = false
local function ensure_tools()
  if loaded then return end
  loaded = true
  vim.pack.add({
    { src = plug("jtprogru/pack-ui.nvim") },
    { src = plug("barrettruth/canola.nvim") },
    {
      src = plug("aserowy/tmux.nvim"),
      cond = vim.env.TMUX ~= nil
    },
    { src = plug("serhez/bento.nvim") },
  })

  require("pack_ui").setup(require("config.pack-ui"))
  require("oil").setup(require("config.oil"))
  if vim.env.TMUX ~= nil then
    require("tmux").setup()
  end
  require("bento").setup(require("config.bento"))

  local api = require("bento.api")
  api.register_expand_key("\\")
  api.register_last_buffer_key("\\")
  api.register_collapse_key("<Esc>")
  api.register_prev_page_key("[")
  api.register_next_page_key("]")
  local actions = {
    { name = "open",   key = "<CR>", hl = "DiagnosticVirtualTextHint" },
    { name = "delete", key = "<BS>", hl = "DiagnosticVirtualTextError" },
    { name = "vsplit", key = "|",    hl = "DiagnosticVirtualTextInfo" },
    { name = "split",  key = "_",    hl = "DiagnosticVirtualTextInfo" },
    { name = "lock",   key = "*",    hl = "DiagnosticVirtualTextWarn" },
  }
  for _, spec in ipairs(actions) do
    api.register_action(spec.name, { key = spec.key, action = api.actions[spec.name], hl = spec.hl })
  end
  api.set_default_action("open")
end

-- keymaps
vim.keymap.set("n", "-", function()
  ensure_tools()
  vim.cmd("Oil --float")
end, { desc = "Oil file manager" })

require("core.lazyload").on_event("BufReadPost", ensure_tools)
