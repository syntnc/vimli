require("core.lazyload").on_event("LspAttach", function()
  vim.pack.add({
    { src = plug("r4ppz/lspeek.nvim") },     -- peek definitions
    { src = plug("bassamsdata/namu.nvim") }, -- outline
  })

  require("lspeek").setup(require("config.lspeek"))
  require("namu").setup()

  -- keymaps
  vim.keymap.set("n", "<leader>uo", "<cmd>Namu symbols<CR>", { desc = "Toggle [O]utline Picker" })
  vim.keymap.set("n", "<leader>uw", "<cmd>Namu workspace<CR>", { desc = "Toggle [W]orkspace outline" })
  vim.keymap.set("n", "gpd", function()
    require("lspeek").peek_type_definition()
  end, { desc = "Peek Type Definition (lspeek)" })
  vim.keymap.set("n", "gpD", function()
    require("lspeek").peek_definition()
  end, { desc = "Peek Definition (lspeek)" })
end)
