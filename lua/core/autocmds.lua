-- What saves you when you are bad at typing
vim.cmd([[
cnoreabbrev <expr> W     ((getcmdtype()  is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> W!    ((getcmdtype()  is# ':' && getcmdline() is# 'W!')?('w!'):('W!'))
cnoreabbrev <expr> Wa    ((getcmdtype()  is# ':' && getcmdline() is# 'Wa')?('wa'):('Wa'))
cnoreabbrev <expr> Q     ((getcmdtype()  is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
cnoreabbrev <expr> Q!    ((getcmdtype()  is# ':' && getcmdline() is# 'Q!')?('q!'):('Q!'))
cnoreabbrev <expr> Qa    ((getcmdtype()  is# ':' && getcmdline() is# 'Qa')?('qa'):('Qa'))
cnoreabbrev <expr> WQ    ((getcmdtype()  is# ':' && getcmdline() is# 'WQ')?('wq'):('WQ'))
cnoreabbrev <expr> Wq    ((getcmdtype()  is# ':' && getcmdline() is# 'Wq')?('wq'):('Wq'))
cnoreabbrev <expr> wQ    ((getcmdtype()  is# ':' && getcmdline() is# 'wQ')?('wq'):('wQ'))
cnoreabbrev <expr> w;    ((getcmdtype()  is# ':' && getcmdline() is# 'w;')?('w'):('w;'))
cnoreabbrev <expr> ;w    ((getcmdtype()  is# ':' && getcmdline() is# ';w')?('w'):(';w'))
]])

local function augroup(name)
  return vim.api.nvim_create_augroup("autocommand_" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  group = augroup("highlighted_yank"),
  pattern = "*",
  desc = "Highlight text that is being yanked",
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
    vim.fn.setreg("+", vim.fn.getreg("*"))
  end,
})

autocmd("VimResized", {
  group = augroup("resize_splits"),
  desc = "Resize splits if window got resized",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

autocmd("FileType", {
  group = augroup("close_with_q"),
  desc = "Close some filetypes with <q>",
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "oil",
    "PlenaryTestPopup",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd("FileType", {
  group = augroup("wrap_spell"),
  desc = "Set wrap and check for spell in text filetypes",
  pattern = { "*.txt", "*.tex", "*.typ", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- requires "famiu/bufdelete.nvim" and "goolord/alpha.nvim"
-- autocmd("User", {
--   desc = "Show Alpha dashboard when there is no buffer left",
--   pattern = "BDeletePost*",
--   group = augroup("alpha_on_empty"),
--   callback = function(event)
--     local fallback_name = vim.api.nvim_buf_get_name(event.buf)
--     local fallback_ft = vim.api.nvim_get_option_value(event.buf, { "filetype" })
--     local fallback_on_empty = fallback_name == "" and fallback_ft == ""
--     if fallback_on_empty then
--       vim.api.nvim_command("Alpha")
--       vim.api.nvim_command(event.buf .. "Bwipeout")
--     end
--   end,
-- })
