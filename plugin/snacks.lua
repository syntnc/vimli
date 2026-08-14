vim.pack.add({
  { src = plug("folke/snacks.nvim") },
})

require("snacks").setup(require("config.snacks"))
local map = vim.keymap.set

if vim.g.picker == "snacks" then
  local picker = require("snacks").picker
  --- stylua: ignore start
  map("n", "<leader>fb", function() picker.buffers() end, { desc = "Buffers" })
  map("n", "<leader>fc", function() picker.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Config File" })
  map("n", "<leader>fd", function() picker.diagnostics_buffer() end, { desc = "Diagnostics in Buffer" })
  map("n", "<leader>fD", function() picker.diagnostics() end, { desc = "Diagnostics" })
  map("n", "<leader>ff", function() picker.files() end, { desc = "Files" })
  map("n", "<leader>fg", function() picker.git_files() end, { desc = "Git Files" })
  map("n", "<leader>fh", function() picker.help() end, { desc = "Help Tags" })
  map("n", "<leader>fi", function() picker.icons() end, { desc = "Icons" })
  map("n", "<leader>fk", function() picker.keymaps() end, { desc = "Keymaps" })
  map("n", "<leader>fn", function() picker.notifications() end, { desc = "Notifications" })
  map("n", "<leader>fp", function() picker.projects() end, { desc = "Projects" })
  map("n", "<leader>fr", function() picker.recent() end, { desc = "Recent" })
  map({ "n", "x" }, "<leader>fvw", function() picker.grep_word() end, { desc = "Visual selection or word" })
  map("n", "<leader>fw", function() picker.grep() end, { desc = "Grep" })
  map("n", "<leader>f?", function() picker.pickers() end, { desc = "All Pickers" })
  --- stylua: ignore end
end

map("n", "<leader>gl", function() require("snacks").lazygit() end, { desc = "[L]azyGit" })
