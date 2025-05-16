local opt = vim.opt

-- Appearance
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.laststatus = 3
opt.showmode = false
opt.showtabline = 0

-- Editor behavior
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.splitright = true
opt.splitbelow = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.updatetime = 500

-- Line behavior
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.expandtab = true
opt.smarttab = true
opt.wrap = false

-- Whitespace appearance
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Search
opt.hlsearch = false
opt.incsearch = true

if vim.fn.executable("rg") == 1 then
	vim.o.grepprg = 'rg --vimgrep --files --hidden --follow --glob "!{.git, node_modules}"'
elseif vim.fn.executable("ag") then
	vim.o.grepprg = 'ag --nogroup --nocolor --hidden --ignore .git -g ""'
end
opt.grepformat = vim.opt.grepformat ^ { "%f:%l:%c:%m" }
