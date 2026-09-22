-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key
vim.g.mapleader = " "

-- Enable icons
vim.g.icons_enabled = true

vim.g.dashboard = "snacks"
vim.g.outliner = "namu"
vim.g.picker = "snacks"

_G.plug = function(repo, source)
  source = source or "github"
  return "https://" .. source .. ".com/" .. repo
end

-- enable opts passing
_G.Config = {
  conform = {},
}

function _G.Config.add(spec)
  local merge = require("core.merge")
  merge(_G.Config, spec)
end
