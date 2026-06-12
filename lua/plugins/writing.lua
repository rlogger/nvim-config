return {
  -- LaTeX. Compile with <localleader>ll (single-shot via tectonic), view
  -- with <localleader>lv, errors land in quickfix.
  {
    "lervag/vimtex",
    -- vimtex lazy-loads itself; ft = "tex" breaks its detection and
    -- inverse-search entry points (per its README)
    lazy = false,
    init = function()
      -- tectonic has no continuous-build mode; \ll compiles once
      vim.g.vimtex_compiler_method = "tectonic"
      vim.g.vimtex_compiler_tectonic = {
        out_dir = "build",
        options = { "--keep-logs", "--synctex" },
      }
      -- No Skim installed: open the PDF in Preview (no SyncTeX).
      -- For forward/inverse search: brew install --cask skim, then set
      -- vim.g.vimtex_view_method = "skim" and vimtex_view_skim_sync = 1.
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "open"
      vim.g.vimtex_view_general_options = "-a Preview @pdf"
    end,
  },

  -- Render markdown (headings, code blocks, tables) in normal mode;
  -- raw text comes back in insert mode
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- no latex treesitter parser installed (see treesitter.lua)
      latex = { enabled = false },
    },
  },
}
