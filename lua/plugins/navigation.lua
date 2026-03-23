local Colemak = require("config.colemak")
local motions = Colemak.motions

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.win = opts.picker.win or {}

      local win = opts.picker.win

      win.input = win.input or {}
      win.input.keys = vim.tbl_deep_extend("force", win.input.keys or {}, {
        [motions.up] = { "list_up", mode = "n" },
        [motions.down] = { "list_down", mode = "n" },
        [motions.left] = { "cancel", mode = "n" },
        [motions.right] = { "confirm", mode = "n" },
        ["<C-u>"] = { "list_up", mode = { "i", "n" } },
        ["<C-e>"] = { "list_down", mode = { "i", "n" } },
        ["<C-n>"] = { "focus_list", mode = { "i", "n" } },
      })

      win.list = win.list or {}
      win.list.keys = Colemak.apply_list_keys(win.list.keys, {
        focus = "focus_input",
        ctrl_up = { "list_scroll_up", mode = { "i", "n" } },
        ctrl_down = { "list_scroll_down", mode = { "i", "n" } },
      })

      win.preview = win.preview or {}
      win.preview.keys = vim.tbl_deep_extend("force", win.preview.keys or {}, {
        [motions.up] = "preview_scroll_up",
        [motions.down] = "preview_scroll_down",
        [motions.left] = "cancel",
        [motions.right] = "focus_input",
      })

      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = opts.picker.sources.explorer or {}
      opts.picker.sources.explorer.win = opts.picker.sources.explorer.win or {}
      opts.picker.sources.explorer.win.list = opts.picker.sources.explorer.win.list or {}
      opts.picker.sources.explorer.win.list.keys = Colemak.apply_list_keys(
        opts.picker.sources.explorer.win.list.keys,
        {
          left = "explorer_close",
          right = "confirm",
          focus = "focus_input",
        }
      )
      opts.picker.sources.explorer.win.list.keys["U"] = "explorer_update"
    end,
  },
  {
    "echasnovski/mini.files",
    opts = function(_, opts)
      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
        go_in = motions.right,
        go_in_plus = "<CR>",
        go_out = motions.left,
        go_out_plus = string.upper(motions.left),
      })
    end,
  },
}
