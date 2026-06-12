return {
  {
    "saghen/blink.cmp",
    -- cmdline completion is on by default, so load for both events
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets", "folke/lazydev.nvim" },
    -- Release pin downloads the prebuilt fuzzy-matcher binary (no Rust
    -- toolchain) and keeps the upcoming 2.0 rewrite out until deliberate
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- default preset: <C-y> accept, <C-n>/<C-p> select, <C-space> menu/docs,
      -- <C-e> hide, <C-b>/<C-f> scroll docs, <C-k> signature toggle.
      -- Tab/S-Tab below restore cycle-through-candidates (with snippet jumps).
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 250 },
      },

      signature = { enabled = true },

      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
