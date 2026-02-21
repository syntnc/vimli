local icons = require("utils.icons")

---@module "Snacks"
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    animate = {
      enabled = true,
      duration = 20,
      easing = "linear",
      fps = 60,
    },
    bigfile = {
      enabled = true,
      notify = true,
      size = 100 * 1024, -- 50 KB
    },
    bufdelete = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
 ███████╗██╗███╗   ███╗██████╗ ██╗     ███████╗██╗   ██╗██╗███╗   ███╗
 ██╔════╝██║████╗ ████║██╔══██╗██║     ██╔════╝██║   ██║██║████╗ ████║
 ███████╗██║██╔████╔██║██████╔╝██║     █████╗  ██║   ██║██║██╔████╔██║
 ╚════██║██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
 ███████║██║██║ ╚═╝ ██║██║     ███████╗███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚══════╝╚═╝╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        { section = "header" },
        {
          icon = icons.ui.keyboard,
          title = "Keymaps",
          section = "keys",
          indent = 2,
          padding = 1,
        },
        {
          icon = icons.ui.file,
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
        },
        {
          icon = icons.ui.open_folder,
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },
        { section = "startup" },
      },
    },
    debug = { enabled = true },
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
    terminal = { enabled = false },
    toggle = { enabled = false },
    words = { enabled = false },
  },
}
