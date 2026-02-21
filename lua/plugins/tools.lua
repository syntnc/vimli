return {

  -- Quick navigation among files
  {
    "otavioschwanck/arrow.nvim",
    dependencies = { "nvim-mini/mini.icons", enabled = vim.g.icons_enabled },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show_icons = vim.g.icons_enabled,
      leader_key = "~",
      -- buffer_leader_key = 'm',
    },
  },

  -- Buffer management
  {
    "serhez/bento.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ui = {
        main_keymap = ";",
        mode = "floating",
        floating = {
          position = "bottom-right",
        },
      },
    },
  },

  {
    "aserowy/tmux.nvim",
    cond = vim.env.TMUX ~= nil,
    event = "VeryLazy",
    config = function()
      require("tmux").setup()
    end,
  },

  -- File management
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    -- Optional dependencies
    dependencies = { "nvim-mini/mini.icons", enabled = vim.g.icons_enabled },
    opts = {
      columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
        ["<M-h>"] = "actions.select_split",
      },
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      { "-", "<cmd>Oil --float<CR>", silent = true, desc = "Open folder in Oil" },
    },
  },

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>sf", function() require("persistence").select() end, desc = "Find Session" },
      { "<leader>ss", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>sd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
