
-- ============================================================================
-- NVIM INIT.LUA - OPTIMIZED FOR PYTHON/JAX DEV, USABILITY, AND SPEED
-- Last updated: 2025-11-01
-- ============================================================================

-- 1. GENERAL OPTIONS --------------------------------------------------------

vim.opt.number = true                 -- Absolute line numbers
vim.opt.relativenumber = true         -- Relative line numbers
vim.opt.tabstop = 4                   -- Spaces per tab
vim.opt.shiftwidth = 4                -- Spaces per indentation
vim.opt.expandtab = true              -- Convert tabs to spaces
vim.opt.smartindent = true            -- Smart auto-indenting
vim.opt.ignorecase = true             -- Ignore case in searches...
vim.opt.smartcase = true              -- ...unless uppercase in search
vim.opt.hlsearch = true               -- Highlight matches
vim.opt.incsearch = true              -- Show match as you type
vim.opt.termguicolors = true          -- 24-bit RGB colors
vim.opt.cursorline = true             -- Highlight current line
vim.opt.wrap = false                  -- No line wrap
vim.opt.scrolloff = 8                 -- 8 lines above/below cursor
vim.opt.signcolumn = "yes"            -- Always show sign column
vim.opt.swapfile = false              -- No swap file
vim.opt.backup = false                -- No backup file
vim.opt.undofile = true               -- Persistent undo

-- Undo directory (cross-platform)
local undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undodir = undodir
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

vim.opt.splitright = true             -- Vertical splits to right
vim.opt.splitbelow = true             -- Horizontal splits below
vim.opt.updatetime = 300              -- Faster updates (ms)
vim.opt.timeoutlen = 500              -- Timeout for mappings (ms)
vim.opt.clipboard = "unnamedplus"     -- System clipboard
vim.opt.mouse = "a"                   -- Mouse enabled
vim.opt.showmode = false              -- Hide mode in cmd line
vim.opt.shortmess:append("c")         -- Suppress ins-completion messages
vim.opt.lazyredraw = true             -- Fast macro execution

-- 2. KEYMAPS ---------------------------------------------------------------

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { silent = true }

-- Clear search highlights
map("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize splits with arrow keys
map("n", "<C-Up>", ":resize +2<CR>", opts)
map("n", "<C-Down>", ":resize -2<CR>", opts)
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Indent in visual mode, keep selection
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines up/down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Paste without yanking over selected text
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- File commands
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Toggle file explorer (Netrw, built-in)
map("n", "<leader>e", ":Lexplore<CR>", { desc = "Toggle file explorer" })

-- 3. AUTOCOMMANDS -----------------------------------------------------------

-- Highlight on yank
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
        local pos = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", pos)
    end,
})

-- Python-specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
        vim.opt_local.textwidth = 88  -- PEP 8 / Black defaults
    end,
})

-- 4. NETRW FILE EXPLORER ----------------------------------------------------

vim.g.netrw_banner = 0                -- Hide netrw banner
vim.g.netrw_liststyle = 3             -- Tree style
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

-- 5. COLORSCHEME ------------------------------------------------------------

vim.cmd.colorscheme("habamax")
-- Alternatives: "slate", "torte", "pablo", "desert"

-- ============================================================================
-- END OF INIT.LUA
-- ============================================================================
