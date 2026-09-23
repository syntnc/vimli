local library = {
  vim.env.VIMRUNTIME,
  "${3rd}/luv/library",
}

local opt_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt"
if vim.fn.isdirectory(opt_dir) == 1 then
  for name, kind in vim.fs.dir(opt_dir) do
    if kind == "directory" then
      table.insert(library, opt_dir .. "/" .. name .. "/lua")
    end
  end
end

return {
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = library,
      },
    },
  },
}
