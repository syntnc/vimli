return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      headerMaxWidth = 80,
      showCompactInputs = true,
      showInputsTopPadding = false,
      showInputsBottomPadding = false,
    },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>fr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesfilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "[F]ind and [R]eplace",
      },
    },
  },
}
