return {
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
    make_git_keymap("n", "hs", gitsigns.stage_hunk, { desc = "[s]tage hunk toggle" })

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
    make_git_keymap("n", "tD", gitsigns.preview_hunk_inline, { desc = "[T]oggle [D]eleted" })
  end,
}
