require("core.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = plug("MagicDuck/grug-far.nvim") },
  })

  require("grug-far").setup({
    headerMaxWidth = 80,
    showCompactInputs = true,
    showInputsTopPadding = false,
    showInputsBottomPadding = false,
  })

  vim.keymap.set({ "n", "v" }, "<leader>fr", function()
    local grug = require("grug-far")
    local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
    grug.open({
      transient = true,
      prefills = {
        filesfilter = ext and ext ~= "" and "*." .. ext or nil,
      },
    })
  end)
end)
