# Deferred loading

Why vimli defers everything it can: loading all plugins up front (total
ordering) costs ~44ms of loader bodies before first use, versus ~20ms to
a painted dashboard when deferred. Measured per-group costs (headless):

| trigger | groups | ~ms |
|---|---|---|
| `BufReadPre` / `BufNewFile` | treesitter ×5, LSP ×6 | 22 |
| `BufReadPost` | git, ui helpers ×8, conform, flash, grug-far, tools, editing | 15 |
| `InsertEnter` / `CmdlineEnter` | blink ×4 | 5 |
| `LspAttach` | navic, lspeek, namu | 2 |

Eager startup keeps only what the first paint needs: colorscheme,
statusline, icons, session restore, dashboard.

## Mechanism

`core.lazyload.on_event(events, fn[, pattern])` registers a once-loader
that runs inline in the autocmd callback (never via `vim.schedule`, so
event ordering holds). It delegates to `mini.misc.safely`, which owns
exactly-once (delete-before-run), `nested`, a shared augroup, and
registration-site tracebacks; loader failures notify at WARN level.
`pattern` maps to safely's `~` syntax and pairs with a single event
(`on_event("FileType", fn, "go")`).

`mini.misc` itself is added in `lua/core/hooks.lua`, required from
`init.lua`: every `plugin/` loader registers through it, so it must be
active before any `plugin/` file is sourced.

## Ordering contracts

- `BufReadPre` runs before `FileType`/LSP-start for the same buffer, so
  `vim.lsp.enable()` and the `LspAttach` handler are always registered
  in time.
- Same-event autocmds run in creation order: `lsp-tools.lua` (startup)
  precedes lspconfig's handler (registered at `BufReadPre`), so namu's
  `:Namu` commands exist before keymaps use them.
- `after/ftplugin/<lang>.lua` vs the once-loader on the same `FileType`
  event is unordered: never `require()` a gated plugin at ftplugin
  source time; buffer maps needing it require inside the mapping body.
- Overrides (`on_override`, drained once at `VimEnter`) run before
  event-deferred loaders by design; an override touching a deferred
  plugin must ensure it is loaded first. `on_override` deliberately
  does not use `safely('later')`, which can drain before `VimEnter`.

## Install hooks

The lockfile bootstrap installs all missing plugins at the very first
`vim.pack.add`, so `PackChanged` hooks must already exist. They live in
`lua/core/hooks.lua` (blink fuzzy-lib build), never in a deferred file.

## Cross-plugin opts

Registration is immediate, consumption deferred: `plugin/` files
contribute via `_G.Config.add({...})` at source time (lists merge by
append) and consumers read `Config.<ns>` inside their loaders, so
alphabetical load order never matters. Shared libs (`plenary`) may be
added from several files; repeat adds are no-ops once active
(`plugin/git.lua` lists plenary because its `BufReadPost` callback runs
first and diffview requires it at setup).

## Dashboard interactions

- `plugin/ui/statusline.lua` hides the native statusline
  (`laststatus = 0`) on empty startup; `lua/config/lualine.lua`
  restores it at setup.
- lualine renders navic only when `package.loaded["nvim-navic"]` is
  set, so navic may load lazily on `LspAttach`.
- Dashboard footer calls `vim.pack.get(nil, { info = false })`.
  The default `info = true` runs per-plugin git inspection (~75ms for
  ~44 plugins) on every draw; the footer only needs active/total.
- Buffer-independent keys for deferred groups use stub mappings that
  load-then-act (`-` for oil, so it works from the dashboard).
- `git-worktree.nvim` is absent because it needs telescope, which is
  not installed (snacks is the picker).
- `mini.icons` mocks the `nvim-web-devicons` API because lualine's
  `filetype` component only knows that interface; without the mock the
  filetype renders as a bare string.
