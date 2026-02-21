local M = {}

M.setup_keymaps = function(bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
  end
  local diagnostic_goto = function(next, severity)
    severity = severity and vim.diagnostic.severity[severity] or nil
    local direction = next and 1 or -1
    return function()
      vim.diagnostic.jump({ count = direction, severity = severity })
    end
  end

  -- stylua: ignore start
  map("]d", diagnostic_goto(true), "Next Diagnostic")
  map("[d", diagnostic_goto(false), "Prev Diagnostic")
  map("]e", diagnostic_goto(true, "ERROR"), "Next Error")
  map("[e", diagnostic_goto(false, "ERROR"), "Prev Error")
  map("]w", diagnostic_goto(true, "WARN"), "Next Warning")
  map("[w", diagnostic_goto(false, "WARN"), "Prev Warning")
  map("<leader>cd", function()
    vim.diagnostic.open_float()
  end, "[C]ode [D]iagnostics")
  --  To jump back, press <C-t>.
  if vim.g.picker == "telescope" then
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "[C]ode [S]ymbols search")
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  elseif vim.g.picker == "snacks" then
    map("gd", function() Snacks.picker.lsp_definitions() end, "[G]oto [D]efinition")
    map("gr", function() Snacks.picker.lsp_references() end, "[G]oto [R]eferences")
    map("gI", function() Snacks.picker.lsp_implementations() end, "[G]oto [I]mplementation")
    map("<leader>D", function() Snacks.picker.lsp_type_definitions() end, "Type [D]efinition")
    map("<leader>cs", function() Snacks.picker.lsp_symbols() end, "[C]ode [S]ymbols search")
    map("<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, "[W]orkspace [S]ymbols")
  end
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  -- stylua: ignore start
end

M.setup_highlights = function(bufnr)
  -- highlights on CursorHold (depends on vim.opt.updatetime)
  local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    buffer = bufnr,
    group = highlight_augroup,
    callback = vim.lsp.buf.document_highlight,
  })

  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    buffer = bufnr,
    group = highlight_augroup,
    callback = vim.lsp.buf.clear_references,
  })

  vim.api.nvim_create_autocmd("LspDetach", {
    group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
    callback = function(lsp_event)
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = lsp_event.buf })
    end,
  })
end

M.setup_codelens = function(bufnr)
  vim.lsp.codelens.refresh()
  vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
end

return M
