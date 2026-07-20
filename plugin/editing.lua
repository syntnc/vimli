require("core.lazyload").on_vim_enter(function()
  -- add plugin
  vim.pack.add({
    { src = plug("altermo/ultimate-autopair.nvim") },
  })

  -- configure plugin
  require("ultimate-autopair").setup()
end)
