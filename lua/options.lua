-- Editor options

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.scrolloff = 10
opt.showmode = false -- lualine shows the mode
opt.termguicolors = true
opt.title = true -- file name in the iTerm tab/window title
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.splitright = true
opt.splitbelow = true
vim.o.winborder = "rounded" -- default border for all floating windows (0.11+)

-- Editing
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true
opt.breakindent = true
opt.undofile = true
opt.confirm = true -- prompt instead of erroring on :q with unsaved changes

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split" -- live preview for :s

-- System
opt.mouse = "a"
opt.clipboard = "unnamedplus" -- system clipboard (pbcopy/pbpaste)
opt.updatetime = 250
opt.timeoutlen = 300

-- Remote-plugin providers we don't use: skipping them speeds up startup
-- and keeps :checkhealth quiet. Python tooling (LSP, DAP) does not need this.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Diagnostics
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  virtual_text = { source = "if_many", spacing = 2 },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
})
