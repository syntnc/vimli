local icons = require("utils.icons")

local M = {}

M.disabled_filetypes = {
  statusline = {
    "grug-far",
    "lazy",
    "snacks_dashboard",
    "snacks_terminal",
    "TelescopePrompt",
    "vimpack",
  },
  winbar = {
    "",
    "grug-far",
    "snacks_dashboard",
    "snacks_terminal",
    "terminal",
    "toggleterm",
  },
}

M.diag_symbols = {
  error = icons.diagnostics.Error,
  warn = icons.diagnostics.Warn,
  info = icons.diagnostics.Info,
  hint = icons.diagnostics.Hint,
}

M.tab_indicator = {
  function()
    local tabline = {}
    local cur_tab = vim.api.nvim_get_current_tabpage()
    for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
      local tab_number = vim.api.nvim_tabpage_get_number(tab_id)
      if tab_id == cur_tab then
        table.insert(tabline, string.format("[%s]", tab_number))
      else
        table.insert(tabline, tab_number)
      end
    end
    return table.concat(tabline, " ")
  end,
  icon = icons.statusline.tab_indicator,
  color = "MoreMsg",
  cond = function()
    local tab_pages = vim.api.nvim_list_tabpages()
    return #tab_pages ~= 1
  end,
}

M.show_encoding = function()
  return vim.bo.fileencoding ~= "utf-8"
end

M.show_fileformat = function()
  return vim.bo.fileformat ~= "unix"
end

local active_basename_hl = "WinBarActiveFilename"

M.winbar_filename_text = function()
  local buf = vim.api.nvim_get_current_buf()
  local marker = ""
  if vim.bo[buf].readonly then
    marker = " 󰌾"
  end
  if vim.bo[buf].modified then
    marker = marker .. " ●"
  end
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return "[No Name]" .. marker
  end
  local restore = require("lualine.highlight").format_highlight("c", true)
  local blue = "%#" .. active_basename_hl .. "#"
  local rel = vim.fn.fnamemodify(name, ":~:.")
  local dir, file = rel:match("^(.*/)([^/]+)$")
  if not file then
    return blue .. rel .. restore .. marker
  end
  return dir .. blue .. file .. restore .. marker
end

M.navic_available = function()
  return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
end

M.navic_missing = function()
  return not M.navic_available()
end

M.navic_location = {
  function()
    return require("nvim-navic").get_location()
  end,
  cond = function()
    return M.navic_available()
  end,
}

M.winbar_lsp = function()
  return {
    function()
      local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
      return table.concat(
        vim
          .iter(clients)
          :map(function(client)
            return client.name
          end)
          :totable(),
        ", "
      )
    end,
    icon = icons.statusline.lsp_info,
    cond = function()
      return #vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() }) > 0
    end,
  }
end

M.winbar_left = function(filename)
  return {
    filename,
    { "fancy_diff" },
  }
end

M.winbar_right = function()
  return {
    M.winbar_lsp(),
    { "filetype" },
    { "diagnostics", symbols = M.diag_symbols },
  }
end

M.winbar_cfg = function(left, right)
  local function fix(components)
    for _, component in ipairs(components) do
      if type(component) == "table" then
        local user_cond = component.cond
        component.cond = function()
          if vim.tbl_contains(M.disabled_filetypes.winbar, vim.bo.filetype) then
            return false
          end
          if user_cond then
            return user_cond()
          end
          return true
        end
        component.color = component.color or {}
        component.color.bg = component.color.bg or "NONE"
      end
    end
    return components
  end
  -- stylua: ignore
  return {
    lualine_a = {},
    lualine_b = {},
    lualine_c = fix(left),
    lualine_x = fix(right),
    lualine_y = {},
    lualine_z = {},
  }
end

return M
