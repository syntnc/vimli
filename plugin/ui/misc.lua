require("core.lazyload").on_event("BufReadPost", function()
  -- add plugin
  vim.pack.add({
    { src = plug("nvim-lua/plenary.nvim") },
    { src = plug("tummetott/reticle.nvim") },
    { src = plug("folke/todo-comments.nvim") },
    { src = plug("rachartier/tiny-cmdline.nvim") },
    { src = plug("nvim-mini/mini.clue") },
    { src = plug("nvim-mini/mini.hipatterns") },
    { src = plug("kevinhwang91/nvim-bqf") },
    { src = plug("kevinhwang91/nvim-hlslens") },
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
  require("tiny-cmdline").setup()
  require("mini.clue").setup(require("config.mini-clue"))
  require("mini.hipatterns").setup()
  require("bqf").setup()
  require("hlslens").setup()

  vim.keymap.set("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR>zzzv<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true, desc = "Next match + lens" })
  vim.keymap.set("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR>zzzv<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true, desc = "Prev match + lens" })
  vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true, desc = "Search word + lens" })
  vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true, desc = "Search word back + lens" })
end)
