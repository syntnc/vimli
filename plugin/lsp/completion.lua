require("core.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = plug("Saghen/blink.lib") },
    { src = plug("Saghen/blink.cmp") },
    { src = plug("xzbdmw/colorful-menu.nvim") },
    { src = plug("mikavilpas/blink-ripgrep.nvim") },
  })

  local cmp = require("blink.cmp")
  cmp.build():pwait()
  cmp.setup(require("config.blink"))
  require("colorful-menu").setup()
end)
