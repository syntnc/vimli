local icons = require("utils.icons")

--- @type snacks.Config
return {
  bigfile = {
    enabled = true,
    notify = true,
    size = 100 * 1024, -- 50 KB
  },
  bufdelete = { enabled = true },
  dashboard = {
    enabled = vim.g.dashboard == "snacks",
    -- Layout ported from nvim-pure. The `{ section = "startup" }` entry
    -- there does `require("lazy.stats")`; vimli uses vim.pack instead,
    -- so the footer is a vim.pack-aware function (same shape/position).
    preset = {
      header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣶⣶⠶⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢔⣢⣿⣷⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣼⣾⣿⣿⣿⣿⣿⣿⣉⣿⣿⠇⠀⣀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⡄⠾⠉⠉⢯⣿⣿⣦⣾⣥⣾⣿⣿⣷⣾⣿⣿⠇⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠈⠻⠿⣯⣿⣿⣿⣿⣿⣿⣿⣉⡀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣿⡿⢿⣿⢿⣿⣿⡀⠀⢀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣴⣶⣿⠿⠛⠋⠁⢰⣾⣿⠛⣻⣿⣷⣾⣿⣿⣷⡾⠟
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡤⣶⣿⠿⠟⠋⠉⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⣿⣿⣿⣿⠟⠋⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣿⡿⠿⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⡿⠿⠛⠉⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣾⣿⠿⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠚⠛⠛⠛⠋⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣾⣿⠿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡴⣖⣻⡿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣠⠤⠲⣏⡩⠶⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⣀⠤⢲⣫⡡⠷⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢸⣹⠣⠐⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠰⣾⣷⠀⠀⠀⠀⠀ ⠀⢠⣶⣿⡆ ⠀⣾⣶⡄⠀⠀⠀⠀⠀⣶⣿⠆  ⠀⣶⣿⡇⠀⠀⠀⠀ ⠀⢠⣶⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⣿⣧⡀⠀⠀⠀ ⠀⠈⣿⣿⠀ ⠀⠀⣿⡿⣷⡄⠀⢠⠾⣿⠁⠀  ⠀⠈⣿⠻⣦⡀⠀⠀ ⠀⠈⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⡇⠙⠻⣶⣤⣀ ⠀⠀⢿⣇⠀ ⠀⠀⢻⡇⠈⢻⣾⣅⠀⣿⠀⠀  ⠀⢀⣿⠀⠈⢻⣶⡤ ⠀⠀⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠘⣿⠃ ⠀⠀⢸⣿⠀ ⠀⠀⢸⣇⡰⠋⠈⠻⣿⣿⠀⠀  ⠀⢀⣿⠀⠀⠀⠉⠀ ⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⣿⡀ ⠀⠀⢸⣿⠀ ⠀⠀⢸⡟⠀⠀⠀⠀⠈⣿⠀⠀  ⠀⠘⣯⠀⠀⠀⠀⠀ ⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⢀⣿⡇ ⠀⠀⣼⣿⠀ ⠀⠀⣼⡇⠀⠀⠀⠀⠀⣿⡄⠀  ⠀⠀⣿⠀⠀⠀⠀⠀ ⠀⠀⣼⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠰⠿⠟⠀⠀⠘⣿⡗ ⠀⠰⠿⠟  ⠀⢲⡟⠁⠀⠀⠀⠀⠸⠟⠃⠀  ⠰⢾⢿⡷⠀⠀⠀⠀ ⠀⠴⠿⠟ ⠀⠀⠀⠀⠀⠀⠀⠀
]],
    },
    sections = {
      { section = "header" },
      {
        pane = 2,
        {
          icon = "",
          title = "Keymaps",
          section = "keys",
          indent = 2,
          padding = 1,
        },
        {
          icon = "",
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
        },
        {
          icon = "",
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },
        function()
          local plugins = vim.pack.get()
          local loaded = 0
          for _, p in ipairs(plugins) do
            if p.active then
              loaded = loaded + 1
            end
          end
          local start = vim.g.starttime or vim.uv.hrtime()
          local ms = math.floor((vim.uv.hrtime() - start) / 1e4 + 0.5) / 100
          return {
            align = "center",
            text = {
              { "⚡ Neovim loaded ", hl = "footer" },
              { loaded .. "/" .. #plugins, hl = "special" },
              { " plugins in ", hl = "footer" },
              { ms .. "ms", hl = "special" },
            },
          }
        end,
      },
    },
  },
  git = { enabled = true },
  gitbrowse = { enabled = true },
  indent = {
    enabled = true,
    priority = 1,
    char = "│",
    only_scope = false,
    only_current = false,
    hl = {
      "SnacksIndent1",
      "SnacksIndent2",
      "SnacksIndent3",
      "SnacksIndent4",
      "SnacksIndent5",
      "SnacksIndent6",
      "SnacksIndent7",
      "SnacksIndent8",
    },
  },
  input = {
    enabled = true,
    icon = icons.ui.edit,
    icon_hl = "SnacksInputIcon",
    icon_pos = "left",
    prompt_pos = "title",
    win = { style = "input" },
    expand = true,
  },
  lazygit = { enabled = true },
  notifier = {
    enabled = true,
    timeout = 2000,
    width = { min = 40, max = 0.4 },
    height = { min = 1, max = 0.6 },
    margin = { top = 0, right = 1, bottom = 0 },
    padding = true,
    sort = { "level", "added" },
    level = vim.log.levels.TRACE,
    icons = {
      debug = icons.ui.bug,
      error = icons.diagnostics.Error,
      info = icons.diagnostics.Info,
      trace = icons.ui.bookmark,
      warn = icons.diagnostics.Warn,
    },
    style = "compact",
    top_down = true,
    date_format = "%R",
    more_format = "... %d lines",
    refresh = 50,
  },
  notify = { enabled = true },
  picker = { enabled = vim.g.picker == "snacks" },
  profiler = { enabled = true },
  quickfile = { enabled = true },
  rename = { enabled = true },
  scroll = { enabled = false },
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" },
    right = { "fold", "git" },
    folds = {
      open = false,
      git_hl = false,
    },
    git = {
      patterns = { "GitSign", "MiniDiffSign" },
    },
    refresh = 50,
  },
}
