-- Autocommands

local function augroup(name)
  return vim.api.nvim_create_augroup("config_" .. name, { clear = true })
end

-- Flash the yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Jump back to the last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_position"),
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Equalize splits when the iTerm window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. tab)
  end,
})

-- Close utility windows with q
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "help", "qf", "checkhealth", "lspinfo", "man", "dap-float" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Prose: wrap and spell-check in writing filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("prose"),
  pattern = { "markdown", "tex", "bib", "gitcommit", "rst" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Terminal buffers: no line numbers, start in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup("term"),
  callback = function(event)
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd.startinsert()
    -- lazygit uses Esc as back/cancel: bypass the global <Esc><Esc> map's
    -- timeout so single Esc reaches it instantly (exit with <C-\><C-n>)
    if vim.api.nvim_buf_get_name(event.buf):match("lazygit") then
      vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = event.buf, nowait = true })
    end
  end,
})

-- tectonic refuses to run when the output dir is missing, and texlab builds
-- on save: make sure build/ exists next to any tex file we open
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("tex_build_dir"),
  pattern = "tex",
  callback = function(event)
    local name = vim.api.nvim_buf_get_name(event.buf)
    if name == "" then
      return
    end
    local dir = vim.fs.joinpath(vim.fs.dirname(name), "build")
    if not vim.uv.fs_stat(dir) then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
