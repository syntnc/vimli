require("core.lazyload").on_event({ "InsertEnter", "CmdlineEnter" }, function()
  vim.pack.add({
    { src = plug("Saghen/blink.lib") },
    { src = plug("Saghen/blink.cmp") },
    { src = plug("xzbdmw/colorful-menu.nvim") },
    { src = plug("mikavilpas/blink-ripgrep.nvim") },
  })

  require("blink.cmp").setup(require("config.blink"))
  require("colorful-menu").setup({})
end)
