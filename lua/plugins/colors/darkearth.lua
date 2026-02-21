return {
  "ptdewey/darkearth-nvim",
  name = "darkearth",
  lazy = false,
  priority = 1000,
  cond = function()
    return os.getenv("THEME") == "darkearth"
  end,
  config = function()
    local set_hl = function(hl_group, opts)
      return vim.api.nvim_set_hl(0, hl_group, opts)
    end
    set_hl("WinBar", { bg = "bg" })
    set_hl("WinBarNC", { bg = "bg" })
    vim.cmd.colorscheme("darkearth")
  end,
}
