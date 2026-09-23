require("core.lazyload").on_event({ "BufReadPre", "BufNewFile", "SessionLoadPre" }, function()
  vim.pack.add({
    { src = plug("romus204/tree-sitter-manager.nvim") },
    { src = plug("Wansmer/treesj") },
    { src = plug("ckolkey/ts-node-action") },
    { src = plug("windwp/nvim-ts-autotag") },
    { src = plug("nvim-mini/mini.ai") },
  })

  require("tree-sitter-manager").setup({
    auto_install = true,
    noauto_install = {},
  })
  require("treesj").setup({ use_default_keymaps = false })
  require("ts-node-action").setup()
  require("nvim-ts-autotag").setup(require("config.autotag"))
  require("mini.ai").setup()

  vim.keymap.set("n", "<leader>rj", "<cmd>TSJJoin<CR>", { desc = "[J]oin Node" })
  vim.keymap.set("n", "<leader>rs", "<cmd>TSJSplit<CR>", { desc = "[S]plit Node" })
  vim.keymap.set("n", "<leader>ln", function() require("ts-node-action").node_action() end, { desc = "[N]ode Action" })
end)
