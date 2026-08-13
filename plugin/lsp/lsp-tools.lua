require("core.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = plug("r4ppz/lspeek.nvim") },     -- peek definitions
    { src = plug("bassamsdata/namu.nvim") }, -- outline
  })

  require("lspeek").setup(require("config.lspeek"))
  require("namu").setup()

  -- keymaps
  vim.keymap.set("n", "gpd", function()
    require("lspeek").peek_type_definition()
  end, { desc = "Peek Type Definition (lspeek)" })
  vim.keymap.set("n", "gpD", function()
    require("lspeek").peek_definition()
  end, { desc = "Peek Definition (lspeek)" })
end)
