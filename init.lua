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

-- enable opts passing
_G.Config = {
  conform = {},
}

function _G.Config.add(spec)
  local merge = require("core.merge")
  merge(_G.Config, spec)
end
