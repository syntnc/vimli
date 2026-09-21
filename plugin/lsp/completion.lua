-- Build hook must exist before the first vim.pack.add (lockfile bootstrap).
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "blink.cmp" and (ev.data.kind == "install" or ev.data.kind == "update") then
      if not ev.data.active then
        vim.cmd.packadd("blink.cmp")
      end
      require("blink.cmp").build():pwait()
    end
  end,
})

require("core.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = plug("Saghen/blink.lib") },
    { src = plug("Saghen/blink.cmp") },
    { src = plug("xzbdmw/colorful-menu.nvim") },
    { src = plug("mikavilpas/blink-ripgrep.nvim") },
  })

  require("blink.cmp").setup(require("config.blink"))
  require("colorful-menu").setup()
end)
