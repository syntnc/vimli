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

vim.api.nvim_set_hl(0, "WinBarActiveFilename", { fg = "#89b4fa", bold = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("winbar-hl", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "WinBarActiveFilename", { fg = "#89b4fa", bold = true })
  end,
})

require("lualine").setup(require("config.lualine"))
-- require("lualine").setup()
