# nvim config

Neovim 0.11+, lazy.nvim, native LSP (`vim.lsp.config`/`vim.lsp.enable`).

See [QUICKSTART.md](QUICKSTART.md) for layout, requirements, setup, and Python/LaTeX details.

## Key bindings

Leader is `<Space>`.

### General

| Key | Action |
|-----|--------|
| `<Esc>` | Clear search highlight |
| `<C-h/j/k/l>` | Navigate windows |
| `<S-h>` / `<S-l>` | Previous / next buffer |
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `J` / `K` (visual) | Move selection down / up |
| `<C-d>` / `<C-u>` | Scroll (centered) |
| `<Esc><Esc>` (terminal) | Exit terminal mode |

### Files and search

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer |
| `<leader>sf` | Find files |
| `<leader>sg` | Live grep |
| `<leader>sw` | Grep word under cursor |
| `<leader>sd` | Search diagnostics |
| `<leader>sh` / `<leader>sk` | Search help / keymaps |
| `<leader>sr` | Resume last search |
| `<leader>ss` | Telescope pickers |
| `<leader>st` | Search TODO comments |
| `<leader>s.` | Recent files |
| `<leader><leader>` | Open buffers |
| `<leader>/` | Fuzzy search current buffer |

### LSP

| Key | Action |
|-----|--------|
| `gd` / `gr` / `gI` | Definition / references / implementation |
| `gD` | Declaration |
| `K` | Hover docs (`gK` in tex buffers; vimtex owns `K` there) |
| `<leader>rn` | Rename |
| `<leader>ca` | Code action |
| `<leader>D` | Type definition |
| `<leader>ds` / `<leader>sW` | Document / workspace symbols |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>cd` | Line diagnostics float |
| `<leader>cl` | Diagnostics to loclist |
| `<leader>f` | Format buffer (also on save) |

### Completion (blink.cmp)

| Key | Action |
|-----|--------|
| `<C-y>` | Accept |
| `<C-n>` / `<C-p>` or `<Tab>` / `<S-Tab>` | Next / previous item |
| `<C-space>` | Open menu / toggle docs |
| `<C-e>` | Dismiss |
| `<C-k>` | Toggle signature help |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | LazyGit |
| `]c` / `[c` | Next / previous hunk |
| `<leader>hs` | Stage hunk (again to unstage) |
| `<leader>hr` | Reset hunk |
| `<leader>hS` / `<leader>hR` | Stage / reset buffer |
| `<leader>hp` / `<leader>hi` | Preview hunk (float / inline) |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff against index |
| `<leader>tb` | Toggle line blame |
| `ih` | Hunk text object |

### Debug (Python via debugpy)

| Key | Action |
|-----|--------|
| `<F5>` | Start / continue |
| `<F1>` / `<F2>` / `<F3>` | Step into / over / out |
| `<F7>` | Toggle debug UI |
| `<leader>b` / `<leader>B` | Toggle / conditional breakpoint |
| `<leader>de` | Eval under cursor |
| `<leader>dm` | Debug nearest test (pytest) |
| `<leader>dr` / `<leader>dq` | Toggle REPL / terminate |

### Editing

| Key | Action |
|-----|--------|
| `gcc` / `gc` (visual) | Toggle comment (built-in) |
| `ys` / `cs` / `ds` | Add / change / delete surround |
| `<C-space>` / `<bs>` | Grow / shrink treesitter selection |
| `<leader>nf` / `<leader>nc` | Function / class docstring (Google style) |

### LaTeX (vimtex, localleader = Space)

| Key | Action |
|-----|--------|
| `<localleader>ll` | Compile (single-shot, tectonic) |
| `<localleader>lv` | View PDF |
| `<localleader>le` | Show errors |
| `<localleader>lt` | Table of contents |
| `<localleader>lc` | Clean aux files |

## Troubleshooting

- `:checkhealth` — overall sanity check
- `:Lazy` — plugin state; `:Lazy sync` to force install/update
- `:Mason` — LSP server installs
- `:ConformInfo` — what formatter ran (and why not)
- `:LspInfo` — attached servers for the current buffer
- nvim-treesitter is pinned to the frozen `master` branch — the `main`
  rewrite needs nvim 0.12. Revisit after upgrading.
