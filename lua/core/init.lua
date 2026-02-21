-- Load settings
require("core.globals")
require("core.options")

-- Load mappings and autocmds
require("core.autocmds")
require("core.keymaps")

vim.env.NEOVIM_NODE_VERSION = "v18.16.0"

if vim.fn.has("unix") and vim.env.NEOVIM_NODE_VERSION then
  local node_dir = vim.env.HOME .. "/.nvm/versions/node/" .. vim.env.NEOVIM_NODE_VERSION .. "/bin/"
  if vim.fn.isdirectory(node_dir) then
    vim.env.PATH = node_dir .. ":" .. vim.env.PATH
  end
end
