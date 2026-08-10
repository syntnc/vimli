require("core.lazyload").on_vim_enter(function()
  -- stylua: ignore start
  vim.pack.add({
    { src = plug("barrettruth/canola.nvim") },
    {
      src = plug("aserowy/tmux.nvim"),
      cond = vim.env.TMUX ~= nil
    },
    { src = plug("serhez/bento.nvim") },
  })
  -- stylua: ignore end

  require("oil").setup(require("config.oil"))
  require("tmux").setup()
  require("bento").setup(require("config.bento"))

  -- keymaps
  vim.keymap.set("n", "-", "<cmd>Oil --float<CR>")
end)
