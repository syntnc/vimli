require("core.lazyload").on_vim_enter(function()
   -- add plugin
   vim.pack.add({
     { src = plug("folke/flash.nvim") },
   })

  -- configure plugin
  require("flash").setup({
    yank = {
      register = "+",
    }
  })

  -- keymaps
  vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end)
  -- vim.keymap.set({ "S",     function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  -- vim.keymap.set({ "r",     function() require("flash").remote() end, desc = "Remote Flash" },
  -- vim.keymap.set({ "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  -- vim.keymap.set({ "<c-s>", function() require("flash").toggle() end, desc = "Toggle Flash Search" },
end)

