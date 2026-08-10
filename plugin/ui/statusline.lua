-- Hide the native statusline on the starter/dashboard page until lualine loads.
vim.g.lualine_laststatus = vim.o.laststatus
if vim.fn.argc(-1) > 0 then
  vim.o.statusline = " "
else
  vim.o.laststatus = 0
end

vim.pack.add({
  { src = plug("nvim-lualine/lualine.nvim") },
  { src = plug("meuter/lualine-so-fancy.nvim") },
})

require("lualine").setup(require("config.lualine"))
-- require("lualine").setup()
