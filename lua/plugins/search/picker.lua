return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  cond = function()
    return vim.g.picker == "snacks"
  end,
  -- stylua: ignore
  keys = {
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config File" },
    { "<leader>fd", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics in Buffer" },
    { "<leader>fD", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Git Files" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Tags" },
    { "<leader>fi", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fvw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>fw", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>f?", function() Snacks.picker.pickers() end, desc = "All Pickers" },
  },
  opts = {
    picker = {
      enabled = function()
        return vim.g.picker == "snacks"
      end,
    },
  },
}
