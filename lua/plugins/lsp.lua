return {
  -- lua_ls support for the nvim lua API in this config (replaces neodev)
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- LSP progress messages in the corner
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },

  {
    -- Data-only on nvim 0.11: ships the lsp/*.lua server definitions that
    -- vim.lsp.config() merges. Never require("lspconfig") directly.
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      -- Buffer-local keymaps once a server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("config_lsp_attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", require("telescope.builtin").lsp_definitions, "Goto definition")
          map("gr", require("telescope.builtin").lsp_references, "Goto references")
          map("gI", require("telescope.builtin").lsp_implementations, "Goto implementation")
          map("gD", vim.lsp.buf.declaration, "Goto declaration")
          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type definition")
          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
          -- under <leader>s so it doesn't prefix-shadow <leader>w (save)
          map("<leader>sW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          -- vimtex owns K in tex buffers (package docs); hover moves to gK there
          if vim.bo[event.buf].filetype == "tex" then
            map("gK", vim.lsp.buf.hover, "Hover documentation")
          else
            map("K", vim.lsp.buf.hover, "Hover documentation")
          end

          -- Highlight other references of the symbol under the cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight") then
            local group = vim.api.nvim_create_augroup("config_lsp_highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Tear down the highlight autocmds only when the detaching client is
      -- the one that provided them (e.g. ruff detaching must not kill
      -- pyright's highlights)
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("config_lsp_detach", { clear = true }),
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight") then
            vim.lsp.util.buf_clear_references(ev.buf)
            pcall(vim.api.nvim_clear_autocmds, { group = "config_lsp_highlight", buffer = ev.buf })
          end
        end,
      })

      -- Python: pyright for types/navigation, ruff for lint/imports.
      -- blink.cmp registers its completion capabilities globally on 0.11;
      -- no manual capabilities wiring needed.
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = { typeCheckingMode = "basic" },
          },
        },
        -- pyright does not find uv's .venv on its own; point it at the
        -- project interpreter when one exists
        before_init = function(_, config)
          local py = vim.fs.joinpath(config.root_dir or vim.fn.getcwd(), ".venv", "bin", "python")
          if vim.uv.fs_stat(py) then
            -- mutate in place: the client already holds a reference to this
            -- table, so reassigning config.settings would be a silent no-op
            config.settings.python = vim.tbl_deep_extend("force", config.settings.python or {}, {
              pythonPath = py,
            })
          end
        end,
      })

      -- ruff: defaults are fine (settings would go under init_options.settings).
      -- pyright owns K: drop ruff's hover
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("config_ruff_hover", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
          },
        },
      })

      -- LaTeX: texlab builds with tectonic (no latexmk on this machine)
      vim.lsp.config("texlab", {
        settings = {
          texlab = {
            build = {
              executable = "tectonic",
              -- same build/ output dir as vimtex, so \lv always views the
              -- PDF these on-save builds produce
              args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates", "--outdir", "build" },
              onSave = true,
              auxDirectory = "build",
              logDirectory = "build",
              pdfDirectory = "build",
            },
          },
        },
      })

      -- mason-lspconfig v2 auto-runs vim.lsp.enable() for every mason-installed
      -- server (automatic_enable defaults to true)
      require("mason-lspconfig").setup({
        ensure_installed = { "pyright", "ruff", "lua_ls", "texlab" },
      })

      -- Non-LSP tools
      require("mason-tool-installer").setup({
        ensure_installed = { "stylua" },
      })
    end,
  },
}
