return {

  -- Outline picker
  {
    "bassamsdata/namu.nvim",
    opts = {
      global = {},
      namu_symbols = { options = {} },
    },
    keys = {
      { "<leader>uo", "<cmd>Namu symbols<CR>", desc = "Toggle [O]utline Picker" },
      { "<leader>uw", "<cmd>Namu workspace<CR>", desc = "Toggle [W]orkspace outline" },
    },
  },

  -- Set file explorer tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-mini/mini.icons", enabled = vim.g.icons_enabled },
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ["\\"] = "close_window",
          },
        },
      },
    },
  },

  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  -- Better handling of cursorline and cursorcolumn
  {
    "tummetott/reticle.nvim",
    event = { "BufReadPre", "VeryLazy" },
    config = function()
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
    end,
  },

  -- Better colors in menus
  {
    "xzbdmw/colorful-menu.nvim",
    event = { "MenuPopup" },
    config = function()
      require("colorful-menu").setup({
        fallback_highlight = "@variable",
        max_width = 60,
      })
    end,
  },

  -- Highlight color codes
  {
    "nvim-mini/mini.hipatterns",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Better quickfix UI
  {
    "kevinhwang91/nvim-bqf",
    event = { "QuickFixCmdPost" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
  },

  -- -- Highlight characters for jumping within a line
  -- {
  --   "jinh0/eyeliner.nvim",
  --   event = { "BufReadPost", "BufNewFile" },
  --   opts = {
  --     highlight_on_key = true,
  --     -- dim all other characters if set to true
  --     dim = true,
  --     -- set the maximum number of characters eyeliner.nvim will check from
  --     -- your current cursor position
  --     max_length = 9999,
  --     disabled_filetypes = {},
  --     disabled_buftypes = {},
  --     default_keymaps = true,
  --   },
  --   config = function(_, opts)
  --     require("eyeliner").setup(opts)
  --   end,
  -- },
}
