vim.pack.add({ { src = plug("lewis6991/gitsigns.nvim") } })
require("core.lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = plug("nvim-lua/plenary.nvim") },
    { src = plug("sindrets/diffview.nvim") },
    { src = plug("kdheepak/lazygit.nvim") },
    -- NOTE: the following needs telescope
    -- { src = plug("ThePrimeagen/git-worktree.nvim") },
  })

  require("diffview").setup(require("config.diffview"))
  require("gitsigns").setup(require("config.gitsigns"))

  -- stylua: ignore start
  vim.keymap.set("n", "<leader>gl", "<cmd>LazyGit<CR>", { desc = "[L]azyGit" })
  vim.keymap.set("n", "<leader>gv", "<cmd>DiffviewOpen -- %<cr><bar><cmd>DiffviewToggleFiles<CR>", { desc = "[V]iew diff" })
  vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "[H]istory" })
  -- stylua: ignore end
end)
