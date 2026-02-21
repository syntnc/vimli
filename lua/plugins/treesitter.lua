return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
    },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      ensure_installed = { "json", "lua", "rust", "vimdoc" },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
      autotag = { enable = true },
      endwise = { enable = true },
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      matchup = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter" },
    lazy = true,
    enabled = true,
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can uouterse the capture groups defined in textobjects.scm
            ["l="] = { query = "@assignment.lhs", desc = "Select left part of an assignment" },
            ["r="] = { query = "@assignment.rhs", desc = "Select right part of an assignment" },
          },
        },
        swap = {
          enable = true,
          swap_next = { ["<leader>na"] = "@parameter.inner", ["<leader>nm"] = "@function.outer" },
          swap_previous = { ["<leader>pa"] = "@parameter.inner", ["<leader>pm"] = "@function.outer" },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = { query = "@call.outer", desc = "Next function call start" },
            ["]m"] = { query = "@function.outer", desc = "Next function definition start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
          },
          goto_next_end = {
            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            ["]M"] = { query = "@function.outer", desc = "Next function definition end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@call.outer", desc = "Previous function call start" },
            ["[m"] = { query = "@function.outer", desc = "Previous function definition start" },
            ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Previous conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@call.outer", desc = "Previous function call end" },
            ["[M"] = { query = "@function.outer", desc = "Previous function definition end" },
            ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Previous conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter" },
    enabled = true,
    opts = {},
    keys = {
      {
        "<leader>ln",
        function()
          require("ts-node-action").node_action()
        end,
        desc = "[N]ode Action",
      },
    },
  },

  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    keys = {
      { "<leader>lj", "<cmd>TSJToggle<CR>", desc = "[J]oin/Split" },
    },
    dependencies = { "nvim-treesitter" },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
      })
    end,
  },
}
