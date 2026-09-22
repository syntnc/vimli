# vimli

This config runs under the `NVIM_APPNAME=vimli` alias, so its data lives in `vimli/` standard paths (e.g. `~/.local/share/vimli/`), not `nvim/`.

Neovim 0.12 config. It uses built-in `vim.pack`, not lazy.nvim or mason.

## Layout

- `init.lua`: `vim.loader.enable()` stays line 1. Then core, ui2. No plugin-specific code.
- `lua/core/`: `globals.lua` (feature switches, `Config` registry), `options.lua`, `keymaps.lua`, `autocmds.lua`, `lazyload.lua` (`on_event` loaders, `on_override` queue), `merge.lua`, `hooks.lua` (install hooks, foundation packs; required from `core/init.lua` before the first `vim.pack.add`).
- `plugin/`: the active config. Neovim sources it alphabetically at startup. Subdirs are categories: `lsp/`, `search/`, `ui/`, `lang/`, plus topical files (`git.lua`, `tools.lua`, `editing.lua`, `formatting.lua`, `session.lua`, `snacks.lua`, `treesitter.lua`, `colors.lua`).
- `lua/config/<name>.lua`: opts tables only, one per plugin. No setup calls.
- `lua/lsp/<server>.lua`: returns a `vim.lsp.config` table. Files are auto-enabled by filename scan in `plugin/lsp/lspconfig.lua`.
- `lua/utils/`: shared helpers (LSP keymaps, icons, statusline parts).
- `after/ftplugin/`: per-filetype tweaks.
- `lua/plugins/`, `lua/plugbak/`: gitignored leftovers. Ignore them.
- `nvim-pack-lock.json`: written by `vim.pack`. Never hand-edit.

## Comments

- No descriptive comments in code. Rationale, trigger choices, and ordering contracts live in `docs/loading.md`; point at it instead of restating.
- Code keeps only comments that guard an on-the-spot invariant docs can't (formatter directives, type annotations).

## Switches

`lua/core/globals.lua` holds `vim.g.picker`, `vim.g.outliner`, `vim.g.dashboard`, `vim.g.icons_enabled`. Code must keep every branch working, including inactive ones (e.g. the telescope branch stays though only snacks is installed).

## Guides

Procedural guides live in project skills under `.agents/skills/` (agent-portable, auto-loaded on match, single source of truth — not repeated here): `vimli-add-plugin` (adding/removing/lazy-loading plugins: placement, deferred loaders, build hooks, shared opts), `vimli-lang-support` (per-language filetype-gated config, LSP servers, ftplugin tweaks).

## LSP

- New server: drop `lua/lsp/<server>.lua`. Nothing else to wire.
- `LspAttach` in `plugin/lsp/lspconfig.lua`: global setup (tiny plugins, diagnostic style, signs) runs once behind the `did_global_setup` guard. Per-buffer keymaps, highlights, and capability-gated enables stay per-attach.

## Gotchas

- `barrettruth/canola.nvim` is an oil.nvim fork. Require it as `oil`.
- Bento v2: `setup()` registers no keys or actions. Everything goes through `require("bento.api")` (`plugin/tools.lua` has the pattern).
- Visual-mode `S` belongs to MiniSurround. Flash treesitter lives on `gs` in all modes. Do not move surround maps.
- Snacks dashboard needs `dashboard.enabled` in `lua/config/snacks.lua`; the empty-buffer fallback is the `dashboard_on_empty` autocmd.

## Verify

`nvim --headless +qa` must exit 0 with no output.
