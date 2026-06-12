return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup({
        defaults = {
          path_display = { "truncate" },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")
      local map = vim.keymap.set
      map("n", "<leader>sf", builtin.find_files, { desc = "Search files" })
      map("n", "<leader>sg", builtin.live_grep, { desc = "Search by grep" })
      map("n", "<leader>sw", builtin.grep_string, { desc = "Search current word" })
      map("n", "<leader>sd", builtin.diagnostics, { desc = "Search diagnostics" })
      map("n", "<leader>sh", builtin.help_tags, { desc = "Search help" })
      map("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
      map("n", "<leader>sr", builtin.resume, { desc = "Search resume" })
      map("n", "<leader>ss", builtin.builtin, { desc = "Search telescope pickers" })
      map("n", "<leader>s.", builtin.oldfiles, { desc = "Search recent files" })
      map("n", "<leader><leader>", builtin.buffers, { desc = "Find open buffers" })
      map("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "Fuzzy search current buffer" })
    end,
  },
}
