require("core")

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    target = "msg",
    targets = {},
    cmd = { height = 0.5 },
    dialog = { height = 0.5 },
    msg = { height = 0.5, timeout = 4500 },
    pager = { height = 1 },
  },
})
