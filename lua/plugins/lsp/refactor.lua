return {
  {
    "smjonas/inc-rename.nvim",
    event = "InsertEnter",
    dependencies = {
      "stevearc/dressing.nvim",
    },
    opts = {
      input_buffer_type = "dressing",
    },
    config = function(_, opts)
      require("inc_rename").setup(opts)
      vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "Re[n]ame using LSP" })
    end,
  },
}
