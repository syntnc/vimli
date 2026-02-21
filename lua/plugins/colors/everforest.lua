return {
  "sainnhe/everforest",
  name = "everforest",
  lazy = false,
  priority = 1000,
  cond = function()
    return os.getenv("THEME") == "everforest"
  end,
  config = function()
    vim.g.everforest_better_performance = 1
    vim.g.everforest_enable_italic = 1

    -- Change specific vim highlight groups
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("custom_highlights_everforest", {}),
      pattern = "everforest",
      callback = function()
        local config = vim.fn["everforest#get_configuration"]()
        local palette = vim.fn["everforest#get_palette"](config.background, config.colors_override)
        local set_hl = vim.fn["everforest#highlight"]

        -- Special emphasis on current line number
        set_hl("CursorLineNr", palette.yellow, palette.none)

        -- Winbar active and inactive colors
        set_hl("WinBar", palette.red, palette.none)
        set_hl("WinBarNC", palette.grey0, palette.none)

        -- Autocomplete
        set_hl("BlinkCmpMenu", palette.fg, palette.bg1)
        set_hl("BlinkCmpScrollBarGutter", palette.fg, palette.bg1)

        -- LSP
        set_hl("LspSignatureActiveParameter", palette.green, palette.bg0, "bold")
      end,
    })

    vim.cmd.colorscheme("everforest")
  end,
}
