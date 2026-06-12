return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer", silent = true },
    },
    -- netrw is disabled and neo-tree is otherwise lazy: load it up front
    -- when nvim is launched on a directory (nvim .) so the hijack works
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.uv.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
        filtered_items = {
          hide_dotfiles = false,
          never_show = { ".DS_Store", "__pycache__", ".ruff_cache", ".pytest_cache" },
        },
        window = {
          mappings = {
            ["<leader>e"] = "close_window",
          },
        },
      },
    },
  },
}
