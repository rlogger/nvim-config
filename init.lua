-- ============================================================================
-- BASIC SETTINGS
-- ============================================================================

-- Line numbers
vim.opt.number = true              -- Show absolute line numbers
vim.opt.relativenumber = true      -- Show relative line numbers (useful for motions)

-- Indentation
vim.opt.tabstop = 4                -- Number of spaces a tab counts for
vim.opt.shiftwidth = 4             -- Number of spaces for auto-indent
vim.opt.expandtab = true           -- Convert tabs to spaces
vim.opt.smartindent = true         -- Smart auto-indenting on new lines

-- Search settings
vim.opt.ignorecase = true          -- Ignore case when searching
vim.opt.smartcase = true           -- Override ignorecase if search has uppercase
vim.opt.hlsearch = true            -- Highlight search results
vim.opt.incsearch = true           -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true       -- Enable 24-bit RGB colors
vim.opt.cursorline = true          -- Highlight the current line
vim.opt.wrap = false               -- Don't wrap long lines
vim.opt.scrolloff = 8              -- Keep 8 lines visible above/below cursor
vim.opt.signcolumn = "yes"         -- Always show sign column (for git, diagnostics)

-- File handling
vim.opt.swapfile = false           -- Disable swap files
vim.opt.backup = false             -- Disable backup files
vim.opt.undofile = true            -- Enable persistent undo
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Undo directory

-- Splitting
vim.opt.splitright = true          -- Vertical splits go to the right
vim.opt.splitbelow = true          -- Horizontal splits go below

-- Performance
vim.opt.updatetime = 300           -- Faster completion (default is 4000ms)
vim.opt.timeoutlen = 500           -- Time to wait for mapped sequence

-- Clipboard (works with macOS)
vim.opt.clipboard = "unnamedplus"  -- Use system clipboard

-- Mouse support
vim.opt.mouse = "a"                -- Enable mouse in all modes

-- ============================================================================
-- KEY MAPPINGS
-- ============================================================================

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlighting with <Esc>
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows with arrow keys
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Stay in visual mode when indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Better paste (doesn't overwrite register)
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- File operations
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

-- Create undo directory if it doesn't exist
local undodir = os.getenv("HOME") .. "/.vim/undodir"
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

-- Highlight on yank (when copying text)
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
    end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("trim_whitespace", { clear = true }),
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Python-specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
        vim.opt_local.textwidth = 88  -- PEP 8 recommended (Black formatter default)
    end,
})

-- ============================================================================
-- NETRW (Built-in File Explorer)
-- ============================================================================

vim.g.netrw_banner = 0             -- Hide banner
vim.g.netrw_liststyle = 3          -- Tree view
vim.g.netrw_browse_split = 4       -- Open in previous window
vim.g.netrw_altv = 1               -- Split to the right
vim.g.netrw_winsize = 25           -- 25% width

-- Toggle file explorer
vim.keymap.set("n", "<leader>e", ":Lexplore<CR>", { desc = "Toggle file explorer" })

-- ============================================================================
-- COLORSCHEME
-- ============================================================================

-- Set colorscheme (using built-in schemes)
vim.cmd.colorscheme("habamax")     -- Good default dark theme
-- Alternatives: "slate", "torte", "pablo", "desert"
