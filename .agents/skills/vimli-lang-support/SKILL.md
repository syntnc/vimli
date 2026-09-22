---
name: vimli Language Support
description: Add per-language support in the vimli Neovim config: plugin/lang files with FileType-gated loading, shared formatter opts, LSP server files, ftplugin tweaks
---

# Language support (vimli)

Context: vimli is a Neovim 0.12 config using built-in `vim.pack` (no lazy.nvim, no mason). Project root is the session working directory; all paths below are relative to it.

One file per language: `plugin/lang/<lang>.lua`. It must stay cheap at startup (a `Config.add` plus one loader registration) so the dashboard never pays for languages not in use.

1. Shared opts: contribute at file top level with `_G.Config.add({...})`, e.g. `conform.formatters_by_ft.<ft>`. Lists merge by append; consumption happens in the consumer's own deferred loader.
2. Language-specific plugins: gate the whole group on filetype with the `pattern` argument — `on_event("FileType", function() ... end, "<ft>")` (maps to safely's `~` syntax; pairs with a single event only). `vim.pack.add`, `setup()`, and global keymaps go inside, opts in `lua/config/<name>.lua`. The group loads on the first buffer of that filetype and never otherwise.
3. LSP is a separate track: servers live in `lua/lsp/<server>.lua` (return a `vim.lsp.config` table, auto-enabled by filename scan) and attach regardless of lang gating. Don't duplicate server config in the lang file.
4. Parsers are automatic: `tree-sitter-manager` runs with `auto_install = true`; exclude a parser via `noauto_install` in `plugin/treesitter.lua` instead of adding install logic.
5. Buffer-local settings go in `after/ftplugin/<lang>.lua` (`opt_local` only, plus maps to builtin functionality). Ordering vs the once-loader on the same `FileType` event isn't guaranteed, so never `require()` the gated plugin at ftplugin source time — buffer maps that need it must require inside the mapping body (press-time), or live as global maps in the loader.

Sketch (`plugin/lang/go.lua` shape):

```lua
_G.Config.add({ conform = { formatters_by_ft = { go = { "gofumpt" } } } })

require("core.lazyload").on_event("FileType", function()
  vim.pack.add({ { src = plug("user/go-helper.nvim") } })
  require("go-helper").setup(require("config.go-helper"))
  vim.keymap.set("n", "<leader>rt", "<cmd>GoTest<cr>", { desc = "Go test" })
end, "go")
```

Done when: `NVIM_APPNAME=vimli nvim --headless +qa` exits 0 with no output.
