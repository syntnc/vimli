---
name: vimli Add Plugin
description: Add, remove, or lazy-load a plugin in the vimli Neovim config: vim.pack.add placement, event-deferred loaders, PackChanged build hooks, shared Config opts
---

# Add a plugin (vimli)

Context: vimli is a Neovim 0.12 config using built-in `vim.pack` (no lazy.nvim, no mason). Project root is the session working directory; all paths below are relative to it.

1. Create `plugin/<category>/<name>.lua`. Categories double as subdirs: `lsp/`, `search/`, `ui/`, `lang/`, plus topical files (`git.lua`, `tools.lua`, `editing.lua`, `formatting.lua`, `session.lua`, `snacks.lua`, `treesitter.lua`, `colors.lua`). Neovim sources them alphabetically at startup.
2. Register with a full URL through the helper: `vim.pack.add({ { src = plug("user/repo") } })`. One `add` per plugin; shared libs (plenary) are the exception.
3. Put opts in `lua/config/<name>.lua` (opts tables only, no setup calls); call `setup()` in the plugin file.
4. Defer with `require("core.lazyload").on_event(<events>, function() ... end)` using the earliest event that still precedes first use (`BufReadPre` for LSP/treesitter, `BufReadPost` for buffer UI, `InsertEnter`/`CmdlineEnter` for completion, `LspAttach` for LSP consumers). `on_event` delegates to `mini.misc.safely` (eager dep added in `init.lua` via `lua/core/hooks.lua`); loader failures report at WARN level with upstream tracebacks. Only what must draw at startup stays eager (colorscheme, statusline, session restore, dashboard). Buffer-independent keys for deferred plugins use stub mappings that load-then-act (see `plugin/tools.lua`).
5. Build steps (blink fuzzy lib, treesitter parsers) go in a `PackChanged` autocmd keyed on `ev.data.spec.name`, created before the first `vim.pack.add` — hooks live in `lua/core/hooks.lua` (required from `init.lua`), never in a deferred file. Never block the startup path with waits.
6. Cross-plugin opts: contribute at load time with `_G.Config.add({...})` (see `plugin/lang/python.lua`), consume deferred inside the `on_event` loader via `merge(opts, Config.<ns> or {})`.
7. Keep every `vim.g` switch branch working (`lua/core/globals.lua`: `picker`, `outliner`, `dashboard`, `icons_enabled`), including inactive ones.

Done when: `NVIM_APPNAME=vimli nvim --headless +qa` exits 0 with no output.
