# my personal neovim configuration file (nix shell support)

## Key Bindings

### General

| Key | Action |
|-----|--------|
| `<Space>` | Leader key |
| `<Esc>` | Clear search highlight |
| `<C-h/j/k/l>` | Navigate between windows |
| `<S-h>` / `<S-l>` | Previous/Next buffer |
| `<leader>w` | Save file |
| `<leader>q` | Quit |

### File Navigation

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle file explorer (Neo-tree) |
| `<leader>sf` | Search/Find files |
| `<leader>sg` | Live grep (search in files) |
| `<leader>sw` | Search current word |
| `<leader>sb` | Search buffers |
| `<leader>sh` | Search help |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader><leader>` | Find existing buffers |

### LSP (Language Server)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gD` | Go to declaration |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols |
| `<leader>ws` | Workspace symbols |
| `[d` / `]d` | Previous/Next diagnostic |
| `<leader>e` | Open diagnostic float |
| `<leader>dl` | Open diagnostics list |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame line |
| `<leader>hd` | Diff this |
| `[c` / `]c` | Previous/Next git hunk |

### Debugging (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Start/Continue debugging |
| `<F1>` | Step into |
| `<F2>` | Step over |
| `<F3>` | Step out |
| `<F7>` | Toggle debug UI |
| `<leader>b` | Toggle breakpoint |
| `<leader>B` | Set conditional breakpoint |

### Code Editing

| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment selection |
| `<C-n>` | Next completion item |
| `<C-p>` | Previous completion item |
| `<C-y>` | Confirm completion |
| `<Tab>` | Next completion/snippet |
| `<S-Tab>` | Previous completion/snippet |
| `<leader>nf` | Generate function docstring |
| `<leader>nc` | Generate class docstring |

### Visual Mode

| Key | Action |
|-----|--------|
| `J` | Move line down |
| `K` | Move line up |

### Scrolling

| Key | Action |
|-----|--------|
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `n` / `N` | Next/Previous search (centered) |

### Getting Started

1. Open a Python project:
```bash
cd ~/my-python-project
nix-shell
nvim .
```

2. Open file explorer: `<leader>e`

3. Find files: `<leader>sf`

### Code Navigation

- Jump to definition: `gd`
- Find references: `gr`
- View documentation: `K`
- See all symbols: `<leader>ds`

### Code Editing

- Auto-completion works automatically as you type
- Format code: Happens automatically on save
- Rename variable: `<leader>rn`
- Quick fix: `<leader>ca`

### Debugging

1. Set breakpoints: `<leader>b`
2. Start debugging: `<F5`
3. Step through code: `<F1>`, `<F2>`, `<F3>`
4. View variables and stack in debug UI

### Git Workflow

1. Open LazyGit: `<leader>gg`
2. Stage hunks: `<leader>hs`
3. View git blame: `<leader>hb`
4. Navigate changes: `[c` and `]c`

## Customization

### Changing the Colorscheme

Edit the colorscheme section in `init.lua`:

```lua
{
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("tokyonight-night")
    -- Options: tokyonight-night, tokyonight-storm, tokyonight-day, tokyonight-moon
  end,
},
```

Other popular colorschemes:
- `catppuccin/nvim` - Catppuccin theme
- `rebelot/kanagawa.nvim` - Kanagawa theme
- `EdenEast/nightfox.nvim` - Nightfox theme

### Adding More LSP Servers

Add to the `servers` table in the LSP configuration:

```lua
local servers = {
  pyright = { ... },
  ruff_lsp = { ... },
  lua_ls = { ... },
  -- Add more servers here
  jsonls = {},  -- JSON
  yamlls = {},  -- YAML
}
```

### Changing Formatters

Edit the `conform.nvim` configuration:

```lua
formatters_by_ft = {
  python = { "isort", "black" },
  lua = { "stylua" },
  -- Add more formatters
}
```

## Troubleshooting

### Plugins Not Installing

If plugins don't install automatically:

1. Open Neovim
2. Run `:Lazy sync`
3. Wait for all plugins to install
4. Restart Neovim

### LSP Not Working

1. Check LSP status: `:LspInfo`
2. Ensure Mason installed servers: `:Mason`
3. Install manually if needed: `:MasonInstall pyright ruff-lsp`

### Treesitter Errors

If you see treesitter parsing errors:

1. Update parsers: `:TSUpdate`
2. Check installed parsers: `:TSInstallInfo`
3. Install specific parser: `:TSInstall python`

### LazyGit Not Found

Install lazygit system-wide or add to `shell.nix`:

```nix
buildInputs = [
  python3
  neovim
  lazygit  # Add this
];
```

## Requirements

- Neovim >= 0.9.0
- Git
- Python 3
- Node.js (for some LSP servers)
- ripgrep (for Telescope live grep)
- fd (optional, for better file finding)
- lazygit (optional, for git UI)

## Misc: 
- `:Tutor` - Built-in Neovim tutorial
- `:help` - Access help documentation
- `:checkhealth` - Verify Neovim setup
- `:Lazy` - Plugin manager UI
- `:Mason` - LSP server manager UI

