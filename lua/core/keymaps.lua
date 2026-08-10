local map = vim.keymap.set

-- Press jk to Esc
map({ "i", "x" }, "jk", "<Esc>")

-- Move to the beginning and end of line
map("n", "<leader>h", "^")
map("n", "<leader>l", "$")

-- Indent code blocks
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Keep search result at the center
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Join without moving cursor using temporary mark
map("n", "J", "mzJ`z<cmd>delm z<CR>")
map("n", "gJ", "mzgJ`z<cmd>delm z<CR>")

-- Clear temporary mark on undo
map("n", "u", "u<cmd>delm z<CR>")

-- Scroll half-page while keeping cursor at the center
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Split navigation
map("n", "<C-j>", "<C-W><C-J>")
map("n", "<C-k>", "<C-W><C-K>")
map("n", "<C-l>", "<C-W><C-L>")
map("n", "<C-h>", "<C-W><C-H>")

-- Tabs
map("n", "<leader>tn", ":tabnew<CR>")
map("n", "<leader>to", ":tabonly<CR>")
map("n", "<leader>tc", ":tabclose<CR>")

-- Remove highlights after search
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Move code blocks
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Buffer navigation
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>;", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Insert newline
map("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = "Add Newline Above" })
map("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = "Add Newline Below" })

-- Commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Quickfix
map("n", "<leader>M", "<cmd>messages<cr>", { desc = "[M]essages" })
map("n", "<leader>Q", function()
  require("utils.toggles").qflist()
end)
-- -- map("n", "<leader>cq", quickfix.add_list)
-- -- map("n", "<leader>cQ", quickfix.open_list)
map("n", "[q", "<cmd>try | cprev | catch | silent! clast | catch | endtry<cr>zv")
map("n", "]q", "<cmd>try | cnext | catch | silent! cfirst | catch | endtry<cr>zv")
map("n", "[Q", "<cmd>silent! colder<cr>")
map("n", "]Q", "<cmd>silent! cnewer<cr>")
