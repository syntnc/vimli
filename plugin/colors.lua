vim.pack.add({
  { src = plug("rose-pine/neovim"), name = "rose-pine" },
})

require("rose-pine").setup(require("config.rose-pine"))

vim.cmd.colorscheme("rose-pine")
