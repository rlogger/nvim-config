# nvim config

Neovim 0.11+, lazy.nvim, native LSP (`vim.lsp.config`/`vim.lsp.enable`).

## Layout

```
init.lua                 entry point: core modules + lazy.nvim bootstrap
lua/
  options.lua            editor options, diagnostics UI
  keymaps.lua            global keymaps
  autocmds.lua           yank highlight, prose mode, terminal, qf behavior
  plugins/
    colorscheme.lua      tokyonight
    treesitter.lua       syntax, indent, incremental selection
    lsp.lua              mason + pyright/ruff/lua_ls/texlab
    completion.lua       blink.cmp
    formatting.lua       conform (ruff, stylua), format on save
    telescope.lua        fuzzy finding
    neotree.lua          file explorer
    git.lua              gitsigns + lazygit
    dap.lua              nvim-dap + dap-ui + dap-python (via uv)
    writing.lua          vimtex (tectonic) + render-markdown
    ui.lua               lualine, bufferline, indent guides, which-key
    editing.lua          autopairs, surround, pep8 indent, neogen
```

## Requirements

- Neovim >= 0.11
- `git`, `ripgrep`, `fd`, `make` + a C compiler, `node` (for pyright)
- `uv` (debugpy runs through `uv run --with debugpy`, nothing to install)
- `tectonic` for LaTeX (`brew install tectonic`)
- A Nerd Font (MesloLGS NF works)

LSP servers (pyright, ruff, lua_ls, texlab) and stylua install automatically through Mason on first launch.

## iTerm2 setup

Works out of the box on iTerm2 >= 3.5; for reference:

- **Font**: Profiles > Text > MesloLGS NF (or any Nerd Font). Keep "Italic text" checked so comments render in italics.
- **Undercurl**: automatic — nvim 0.11 detects support at startup. The old terminfo hacks are only needed inside tmux.
- **Colors**: nvim uses truecolor regardless, but for a matching shell import `extras/iterm/tokyonight_night.itermcolors` from the [tokyonight repo](https://github.com/folke/tokyonight.nvim) via Profiles > Colors > Color Presets > Import. Set "Minimum contrast" to off so the palette isn't distorted.
- The iTerm tab title follows the current file (`title` option).

## Python

- **pyright** for types and navigation, **ruff** for linting. If the project root has a uv-created `.venv`, pyright is pointed at it automatically.
- Format on save: `ruff_organize_imports` + `ruff_format` (replaces isort + black).
- Debugging needs no setup: the debugpy adapter runs through `uv run --with debugpy`, and the debugged program picks up `$VIRTUAL_ENV` or the project `.venv`.

## LaTeX

- vimtex compiles with tectonic. Tectonic has no watch mode, so `<localleader>ll` is a single-shot compile; texlab also rebuilds on save. Both write to `build/` next to the source (created automatically), so the PDF that `<localleader>lv` opens is always the latest build.
- `K` looks up package docs (vimtex); `gK` is texlab hover.
- `<localleader>lv` opens the PDF in Preview. Preview can't do SyncTeX — for forward/inverse search: `brew install --cask skim`, then in `lua/plugins/writing.lua` set `vimtex_view_method = "skim"` and `vimtex_view_skim_sync = 1`.
- Localleader is Space, so `\ll` above means `<Space>ll`.
