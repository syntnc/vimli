return {
  --- @usage 'auto'|'main'|'moon'|'dawn'
  variant = "auto",
  --- @usage 'main'|'moon'|'dawn'
  dark_variant = "main",
  bold_vert_split = false,
  dim_nc_background = false,

  styles = {
    bold = true,
    italic = true,
    transparency = true,
  },

  --- @usage string hex value or named color from rosepinetheme.com/palette
  groups = {
    panel = "surface",
    panel_nc = "base",
    border = "highlight_med",
    comment = "muted",
    link = "iris",
    punctuation = "subtle",

    headings = {
      h1 = "iris",
      h2 = "foam",
      h3 = "rose",
      h4 = "gold",
      h5 = "pine",
      h6 = "foam",
    },
    -- or set all headings at once
    -- headings = 'subtle'
  },

  -- Change specific vim highlight groups
  -- https://github.com/rose-pine/neovim/wiki/Recipes
  highlight_groups = {
    -- Blend colours against the "base" background
    CursorLine = { bg = "foam", blend = 10 },

    -- Winbar active and inactive colors
    WinBar = { fg = "rose", bg = "base" },
    WinBarNC = { fg = "muted", bg = "base" },

    -- Borderless telescope + better looks with bold fonts
    TelescopeBorder = { fg = "overlay", bg = "overlay" },
    TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
    TelescopeNormal = { fg = "subtle", bg = "overlay" },
    TelescopePreviewTitle = { fg = "base", bg = "iris" },
    TelescopePromptBorder = { fg = "surface", bg = "surface" },
    TelescopePromptNormal = { fg = "text", bg = "surface" },
    TelescopePromptTitle = { fg = "base", bg = "pine" },
    TelescopeSelection = { fg = "text", bg = "overlay", bold = true },
    TelescopeSelectionCaret = { fg = "love", bg = "overlay" },
    TelescopeTitle = { fg = "base", bg = "love" },
  },
}
