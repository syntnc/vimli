require("core.lazyload").on_vim_enter(function()
   -- add plugin
   vim.pack.add({
     { src = plug("nvim-lua/plenary.nvim") },
     { src = plug("tummetott/reticle.nvim") },
     { src = plug("folke/todo-comments.nvim") },
     { src = plug("nvim-mini/mini.hipatterns") },
     { src = plug("kevinhwang91/nvim-bqf") },
   })

  -- configure plugin
  require("reticle").setup({
    ignore = {
      cursorline = {
        "FTerm",
        "NvimSeparator",
        "NvimTree",
        "TelescopePrompt",
        "Trouble",
        "noice",
        "snacks_dashboard",
      },
    },
  })

  require("todo-comments").setup({ signs = false })
  require("mini.hipatterns").setup()
  require("bqf").setup()

end)
