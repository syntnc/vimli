require("core.lazyload").on_event("LspAttach", function()
  vim.pack.add({
    { src = plug("SmiteshP/nvim-navic") },
  })

  local navic = require("nvim-navic")
  navic.setup({
    highlight = true,
    separator = " / ",
    depth_limit = 3,
    depth_limit_indicator = "..",
  })
end)
