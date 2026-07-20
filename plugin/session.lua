vim.pack.add({ { src = plug("folke/persistence.nvim") } })

require("persistence").setup({ options = vim.opt.sessionoptions:get() })

vim.keymap.set("n", "<leader>sf", function() require("persistence").select() end, { desc = "" })
vim.keymap.set("n", "<leader>ss", function() require("persistence").load() end, { desc = "" })
vim.keymap.set("n", "<leader>sl", function() require("persistence").load({ last = true }) end, { desc = "" })
vim.keymap.set("n", "<leader>sd", function() require("persistence").stop() end, { desc = "" })
