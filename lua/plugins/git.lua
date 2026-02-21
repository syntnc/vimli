return {
  -- Diffview
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen -- %<cr><bar><cmd>DiffviewToggleFiles<CR>", desc = "[V]iew diff" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "[H]istory" },
    },
    config = function()
      require("diffview").setup({
        enhanced_diff_hl = true,
        key_bindings = {
          file_panel = { q = "<Cmd>DiffviewClose<CR>" },
          file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
          view = { q = "<Cmd>DiffviewClose<CR>" },
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = true,
          },
          merge_tool = {
            layout = "diff3_mixed",
            winbar_info = true,
          },
        },
      })
    end,
  },

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gl", "<cmd>LazyGit<cr>", desc = "[L]azyGit" },
    },
  },

  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    lazy = true,
  },

  -- Gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "▎" },
      },
      signcolumn = true,
      preview_config = {
        border = "none",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function make_git_keymap(mode, l, r, opts)
          local prefix = { map = "<leader>g" }
          opts = opts or { desc = "" }
          opts.buffer = bufnr
          return vim.keymap.set(mode, prefix.map .. l, r, opts)
        end

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Jump to next git [c]hange" })

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Jump to previous git [c]hange" })

        -- Actions

        -- Hunk mappings
        make_git_keymap("v", "hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "[s]tage git hunk" })
        make_git_keymap("v", "hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "[r]eset git hunk" })
        make_git_keymap("n", "hp", gitsigns.preview_hunk, { desc = "[p]review hunk" })
        make_git_keymap("n", "hr", gitsigns.reset_hunk, { desc = "[r]eset hunk" })
        make_git_keymap("n", "hs", gitsigns.stage_hunk, { desc = "[s]tage hunk" })
        make_git_keymap("n", "hu", gitsigns.undo_stage_hunk, { desc = "[u]ndo stage hunk" })

        -- Buffer mappings
        make_git_keymap("n", "S", gitsigns.stage_buffer, { desc = "[S]tage buffer" })
        make_git_keymap("n", "R", gitsigns.reset_buffer, { desc = "[R]eset buffer" })
        make_git_keymap("n", "b", gitsigns.blame_line, { desc = "[b]lame line" })
        make_git_keymap("n", "d", gitsigns.diffthis, { desc = "[d]iff against index" })
        make_git_keymap("n", "D", function()
          gitsigns.diffthis("@")
        end, { desc = "[D]iff against last commit" })

        -- Toggles
        make_git_keymap("n", "ts", gitsigns.toggle_signs, { desc = "[T]oggle [s]igns" })
        make_git_keymap("n", "tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle [b]lame line" })
        make_git_keymap("n", "tD", gitsigns.toggle_deleted, { desc = "[T]oggle [D]eleted" })
      end,
    },
  },
}
