return {

  {
    "kylechui/nvim-surround",
    version = "*",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "altermo/ultimate-autopair.nvim",
    branch = "v0.6",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {},
  },

  {
    "abecodes/tabout.nvim",
    event = "InsertCharPre",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "Saghen/blink.cmp",
    },
    opts = {
      tabkey = "<Tab>",
      backwards_tabkey = "<S-Tab>",
      act_as_tab = true,
      act_as_shift_tab = false,
      default_tab = "<c-t>",
      default_shift_tab = "<c-d>",
      enable_backwards = true,
      completion = false,
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
      },
      --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
      ignore_beginning = true,
      exclude = {},
    },
    config = function(_, opts)
      require("tabout").setup(opts)
    end,
  },

  {
    "nvim-mini/mini.ai",
    event = { "BufNewFile", "BufReadPost" },
    opts = function()
      local spec = require("mini.ai").gen_spec
      return {
        custom_textobjects = {
          -- Treesitter textobjects
          ["o"] = spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          ["f"] = spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          ["c"] = spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          ["C"] = spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }), -- comment
          ["i"] = spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }), -- conditional
          ["l"] = spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }), -- loop
          ["m"] = spec.treesitter({ a = "@call.outer", i = "@call.inner" }), -- method call
          ["="] = spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
          -- Misc. textobjects
          ["t"] = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          ["d"] = { "%f[%d]%d+" }, -- digits
          ["e"] = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          ["u"] = spec.function_call(), -- u for "Usage"
          ["U"] = spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
        mappings = {
          -- Main textobject prefixes
          around = "a",
          inside = "i",
          -- Next/last variants
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",
          -- Move cursor to corresponding edge of `a` textobject
          goto_left = "g[",
          goto_right = "g]",
        },
        -- How to search for object
        -- 'cover', 'cover_or_next', 'cover_or_prev','cover_or_nearest', 'next', 'previous', 'nearest'.
        search_method = "cover_or_next",
        n_lines = 500,
        silent = false,
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)
    end,
  },

  -- {
  --   "nvim-mini/mini.bracketed",
  --   event = { "BufReadPost", "BufNewFile" },
  -- },
}
