local Colemak = require("config.colemak")
local motions = Colemak.motions

return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = opts.picker or {}
      opts.picker.win = opts.picker.win or {}
      opts.picker.actions = opts.picker.actions or {}

      local win = opts.picker.win
      local function split_open(cmd, splitright, splitbelow)
        return function(picker, item)
          local Actions = require("snacks.picker.actions")
          local prev_right, prev_below = vim.o.splitright, vim.o.splitbelow
          vim.o.splitright = splitright
          vim.o.splitbelow = splitbelow
          local ok, err = pcall(Actions.jump, picker, item, { cmd = cmd })
          vim.o.splitright = prev_right
          vim.o.splitbelow = prev_below
          if not ok then
            error(err)
          end
        end
      end
      opts.picker.actions.open_right = split_open("vsplit", true, vim.o.splitbelow)
      opts.picker.actions.open_left = split_open("vsplit", false, vim.o.splitbelow)
      opts.picker.actions.open_up = split_open("split", vim.o.splitright, false)
      opts.picker.actions.open_down = split_open("split", vim.o.splitright, true)
      opts.picker.actions.select_item = function(picker)
        picker.list:select()
      end
      opts.picker.actions.insert_input = function()
        vim.cmd("startinsert")
      end
      local list_extras = {
        ["p"] = "focus_preview",
        ["W"] = "cycle_win",
        ["t"] = "tab",
        ["P"] = "toggle_preview",
        ["Q"] = "qflist",
        ["."] = "toggle_hidden",
        [","] = "toggle_ignored",
        ["<Space>"] = "select_item",
        ["si"] = "open_right",
        ["sn"] = "open_left",
        ["su"] = "open_up",
        ["se"] = "open_down",
        ["<A-w>"] = false,
      }

      win.input = win.input or {}
      win.input.keys = vim.tbl_deep_extend("force", win.input.keys or {}, {
        [motions.up] = false,
        [motions.down] = false,
        [motions.left] = false,
        [motions.right] = false,
        ["<C-u>"] = { "list_up", mode = { "i", "n" } },
        ["<C-e>"] = { "list_down", mode = { "i", "n" } },
        ["<C-n>"] = { "focus_list", mode = { "i", "n" } },
        ["<C-p>"] = { "focus_preview", mode = { "i", "n" } },
        ["l"] = { "focus_list", mode = "n" },
        ["p"] = { "focus_preview", mode = "n" },
        ["k"] = "insert_input",
        ["<A-w>"] = false,
      })

      win.list = win.list or {}
      win.list.keys = vim.tbl_deep_extend(
        "force",
        Colemak.apply_list_keys(win.list.keys, {
          right = "focus_preview",
          focus = false,
          ctrl_up = { "list_scroll_up", mode = { "i", "n" } },
          ctrl_down = { "list_scroll_down", mode = { "i", "n" } },
        }),
        vim.tbl_extend("force", {}, list_extras, {
          ["k"] = "focus_input",
        })
      )

      win.preview = win.preview or {}
      win.preview.keys = vim.tbl_deep_extend("force", win.preview.keys or {}, {
        [motions.up] = false,
        [motions.down] = false,
        [motions.left] = "focus_list",
        [motions.right] = "focus_input",
        ["U"] = "preview_scroll_up",
        ["E"] = "preview_scroll_down",
        ["W"] = "cycle_win",
        ["<A-w>"] = false,
      })

      opts.picker.sources = opts.picker.sources or {}
      opts.picker.sources.explorer = opts.picker.sources.explorer or {}
      opts.picker.sources.explorer.win = opts.picker.sources.explorer.win or {}
      opts.picker.sources.explorer.win.list = opts.picker.sources.explorer.win.list or {}
      opts.picker.sources.explorer.win.list.keys = vim.tbl_deep_extend(
        "force",
        Colemak.apply_list_keys(opts.picker.sources.explorer.win.list.keys, {
          left = "explorer_close",
          right = "confirm",
          focus = false,
        }),
        vim.tbl_extend("force", {}, list_extras, {
          ["k"] = "focus_input",
        })
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
