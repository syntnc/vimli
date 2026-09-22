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

vim.pack.add({ { src = plug("nvim-mini/mini.misc") } })
