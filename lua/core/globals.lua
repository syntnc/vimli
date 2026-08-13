-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key
vim.g.mapleader = " "

-- Enable icons
vim.g.icons_enabled = true

vim.g.outliner = "namu"
vim.g.picker = "snacks"

_G.plug = function(repo, source)
  source = source or "github"
  return "https://" .. source .. ".com/" .. repo
end
