return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- The repo's default branch is the `main` rewrite, which requires nvim 0.12
    -- nightly. `master` is frozen but supported on 0.11.
    branch = "master",
    lazy = false, -- treesitter does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "python",
          "lua",
          "bash",
          "json",
          "yaml",
          "toml",
          "markdown",
          "markdown_inline",
          "bibtex",
          "regex",
          "vim",
          "vimdoc",
          "nix",
        },
        auto_install = true,
        -- The latex parser must be generated with tree-sitter-cli <= 0.25,
        -- which Homebrew no longer ships; vimtex's own syntax engine is the
        -- recommended highlighter for tex buffers anyway.
        ignore_install = { "latex" },
        highlight = {
          enable = true,
          disable = { "latex" },
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          -- vim-python-pep8-indent handles Python continuation lines better
          disable = { "python" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
}
