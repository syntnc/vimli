local M = {}

M.setup_plugins = function()
  require("tiny-code-action").setup({
    picker = vim.g.picker,
    format_title = function(action, _)
      if action.kind then
        return string.format("%s (%s)", action.title, action.kind)
      end
      return action.title
    end,
  })
  require("tiny-inline-diagnostic").setup({ override_open_float = true })
end

M.setup_keymaps = function(bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set({ "n", "x" }, keys, func, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      desc = "LSP: " .. desc
    })
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
  if vim.g.outliner == "namu" then
    map("<leader>cs", "<Cmd>Namu symbols<CR>", "[C]ode [S]ymbols search")
    map("<leader>ws", "<Cmd>Namu workspace<CR>", "[W]orkspace [S]ymbols")
  end
  if vim.g.picker == "telescope" then
    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    if vim.g.outliner ~= "namu" then
      map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "[C]ode [S]ymbols search")
      map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    end
  elseif vim.g.picker == "snacks" then
    local picker = require("snacks").picker
    map("gd", function() picker.lsp_definitions() end, "[G]oto [D]efinition")
    map("gr", function() picker.lsp_references() end, "[G]oto [R]eferences")
    map("gI", function() picker.lsp_implementations() end, "[G]oto [I]mplementation")
    map("<leader>D", function() picker.lsp_type_definitions() end, "Type [D]efinition")
    if vim.g.outliner ~= "namu" then
      map("<leader>cs", function() picker.lsp_symbols() end, "[C]ode [S]ymbols search")
      map("<leader>ws", function() picker.lsp_workspace_symbols() end, "[W]orkspace [S]ymbols")
    end
  end
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

  -- Code Actions
  map("<leader>ca", function() require("tiny-code-action").code_action({}) end, "[C]ode [A]ction")

  -- Inline diagnostics
  map("<leader>de", "<cmd>TinyInlineDiag enable<cr>", "Enable diagnostics")
  map("<leader>dd", "<cmd>TinyInlineDiag disable<cr>", "Disable diagnostics")
  map("<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", "Toggle diagnostics")
  map("<leader>dc", "<cmd>TinyInlineDiag toggle_cursor_only<cr>", "Toggle cursor-only diagnostics")
  map("<leader>dr", "<cmd>TinyInlineDiag reset<cr>", "Reset diagnostic options")
end

M.setup_highlights = function(client, bufnr)
  -- highlights on CursorHold (depends on vim.opt.updatetime)
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr) then
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
end

M.setup_codelens = function(client, bufnr)
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens, bufnr) then
    vim.lsp.codelens.enable(true, { bufnr = bufnr })
  end
end

return M
