return {
  -- Auto-close brackets and quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Surround text objects: ys, cs, ds
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- PEP 8 continuation-line indentation (better than treesitter's for Python)
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
  },

  -- Generate docstrings (Google style, the JAX/ML convention)
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = {
      { "<leader>nf", "<cmd>Neogen func<CR>", desc = "Function docstring" },
      { "<leader>nc", "<cmd>Neogen class<CR>", desc = "Class docstring" },
    },
    opts = {
      snippet_engine = "nvim", -- built-in vim.snippet; blink.cmp handles jumps
      languages = {
        python = {
          template = { annotation_convention = "google_docstrings" },
        },
      },
    },
  },
}
