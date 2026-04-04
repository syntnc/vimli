-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set leader key
vim.g.mapleader = " "

-- Enable icons
vim.g.icons_enabled = true

vim.g.picker = "snacks"

_G.plug = function(repo)
  return string.format("https://github.com/%s", repo)
end
