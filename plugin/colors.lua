vim.pack.add({
  { src = plug("rose-pine/neovim"), name = "rose-pine" },
  { src = plug("Aejkatappaja/cendre"), name = "cendre" },
})

require("rose-pine").setup(require("config.rose-pine"))
require("cendre").setup({
  background = "medium", -- "hard" | "medium" | "soft"
  italic_virtual_text = false,
  transparent = true,
})

vim.cmd.colorscheme("cendre")
