vim.pack.add({
  { src = plug("nvim-mini/mini.icons") },
})

require("mini.icons").setup()

-- Bridge mini.icons into the nvim-web-devicons interface. lualine's `filetype`
-- component (and several other plugins) only know about nvim-web-devicons,
-- so without this the filetype shows as a bare string instead of an icon.
require("mini.icons").mock_nvim_web_devicons()
