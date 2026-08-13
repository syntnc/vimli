require("core.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = plug("Saghen/blink.lib") },
    { src = plug("Saghen/blink.cmp") },
    { src = plug("xzbdmw/colorful-menu.nvim") },
  })

  local cmp = require("blink.cmp")
  cmp.build():pwait()
  cmp.setup(require("config.blink"))
  require("colorful-menu").setup()
end)
