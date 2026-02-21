return {
  "folke/trouble.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle focus=true<cr>",
      desc = "Diagnostics",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
      desc = "LSP Definitions / references / ...",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List",
    },
  },
  -- config = function()
  --   require("trouble").setup()
  --   local map = function(lhs, rhs, opts)
  --     opts.desc = "Trouble: " .. (opts.desc or "")
  --     vim.keymap.set("n", "<leader>x" .. lhs, rhs, opts)
  --   end
  --   -- stylua: ignore start
  --   map("t", function() require("trouble").toggle() end, { desc = "Toggle" })
  --   map("q", function() require("trouble").toggle("quickfix") end, { desc = "QuickFix" })
  --   map("n", function() require("trouble").next({ skip_groups = true, jump = true }) end, { desc = "Next" })
  --   map("p", function() require("trouble").previous({ skip_groups = true, jump = true }) end, { desc = "Previous" })
  --   -- stylua: ignore end
  -- end,
}
