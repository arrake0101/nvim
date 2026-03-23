win = {
  -- input window
  input = {
    keys = {
      -- to close the picker on ESC instead of going to normal mode,
      -- add the following keymap to your config
      -- ["<Esc>"] = { "close", mode = { "n", "i" } },
      ["/"] = "toggle_focus",
      ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
      ["<C-Up>"] = { "history_back", mode = { "i", "n" } },
      ["<C-c>"] = { "cancel", mode = "i" },
      ["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
      ["<CR>"] = { "confirm", mode = { "n", "i" } },
      ["<Down>"] = { "list_down", mode = { "i", "n" } },
      ["<Esc>"] = "cancel",
      ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
      ["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
      ["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
      ["<Up>"] = { "list_up", mode = { "i", "n" } },
      ["<a-d>"] = { "inspect", mode = { "n", "i" } },
      ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
      ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
      ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
      ["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
      ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
      ["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
      ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
      ["<c-a>"] = { "select_all", mode = { "n", "i" } },
      ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
      ["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
      ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
      ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
      ["<c-j>"] = { "list_down", mode = { "i", "n" } },
      ["<c-k>"] = { "list_up", mode = { "i", "n" } },
      ["<c-n>"] = { "list_down", mode = { "i", "n" } },
      ["<c-p>"] = { "list_up", mode = { "i", "n" } },
      ["<c-q>"] = { "qflist", mode = { "i", "n" } },
      ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
      ["<c-t>"] = { "tab", mode = { "n", "i" } },
      ["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
      ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
      ["<c-r>#"] = { "insert_alt", mode = "i" },
      ["<c-r>%"] = { "insert_filename", mode = "i" },
      ["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
      ["<c-r><c-f>"] = { "insert_file", mode = "i" },
      ["<c-r><c-l>"] = { "insert_line", mode = "i" },
      ["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
      ["<c-r><c-w>"] = { "insert_cword", mode = "i" },
      ["<c-w>H"] = "layout_left",
      ["<c-w>J"] = "layout_bottom",
      ["<c-w>K"] = "layout_top",
      ["<c-w>L"] = "layout_right",
      ["?"] = "toggle_help_input",
      ["G"] = "list_bottom",
      ["gg"] = "list_top",
      ["j"] = "list_down",
      ["k"] = "list_up",
      ["q"] = "cancel",
    },
    b = {
      minipairs_disable = true,
    },
  },
  -- result list window
  list = {
    keys = {
      ["/"] = "toggle_focus",
      ["<2-LeftMouse>"] = "confirm",
      ["<CR>"] = "confirm",
      ["<Down>"] = "list_down",
      ["<Esc>"] = "cancel",
      ["<S-CR>"] = { { "pick_win", "jump" } },
      ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
      ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
      ["<Up>"] = "list_up",
      ["<a-d>"] = "inspect",
      ["<a-f>"] = "toggle_follow",
      ["<a-h>"] = "toggle_hidden",
      ["<a-i>"] = "toggle_ignored",
      ["<a-m>"] = "toggle_maximize",
      ["<a-p>"] = "toggle_preview",
      ["<a-w>"] = "cycle_win",
      ["<c-a>"] = "select_all",
      ["<c-b>"] = "preview_scroll_up",
      ["<c-d>"] = "list_scroll_down",
      ["<c-f>"] = "preview_scroll_down",
      ["<c-j>"] = "list_down",
      ["<c-k>"] = "list_up",
      ["<c-n>"] = "list_down",
      ["<c-p>"] = "list_up",
      ["<c-q>"] = "qflist",
      ["<c-g>"] = "print_path",
      ["<c-s>"] = "edit_split",
      ["<c-t>"] = "tab",
      ["<c-u>"] = "list_scroll_up",
      ["<c-v>"] = "edit_vsplit",
      ["<c-w>H"] = "layout_left",
      ["<c-w>J"] = "layout_bottom",
      ["<c-w>K"] = "layout_top",
      ["<c-w>L"] = "layout_right",
      ["?"] = "toggle_help_list",
      ["G"] = "list_bottom",
      ["gg"] = "list_top",
      ["i"] = "focus_input",
      ["j"] = "list_down",
      ["k"] = "list_up",
      ["q"] = "cancel",
      ["zb"] = "list_scroll_bottom",
      ["zt"] = "list_scroll_top",
      ["zz"] = "list_scroll_center",
    },
    wo = {
      conceallevel = 2,
      concealcursor = "nvc",
    },
  },
  -- preview window
  preview = {
    keys = {
      ["<Esc>"] = "cancel",
      ["q"] = "cancel",
      ["i"] = "focus_input",
      ["<a-w>"] = "cycle_win",
    },
  },
}
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      actions = {
        open_right = function(picker, item)
          local Actions = require("snacks.picker.actions")
          local prev_right, prev_below = vim.o.splitright, vim.o.splitbelow
          vim.o.splitright = true
          vim.o.splitbelow = prev_below
          local ok, err = pcall(Actions.jump, picker, item, { cmd = "vsplit" })
          vim.o.splitright = prev_right
          vim.o.splitbelow = prev_below
          if not ok then
            error(err)
          end
        end,
        open_left = function(picker, item)
          local Actions = require("snacks.picker.actions")
          local prev_right, prev_below = vim.o.splitright, vim.o.splitbelow
          vim.o.splitright = false
          vim.o.splitbelow = prev_below
          local ok, err = pcall(Actions.jump, picker, item, { cmd = "vsplit" })
          vim.o.splitright = prev_right
          vim.o.splitbelow = prev_below
          if not ok then
            error(err)
          end
        end,
        open_up = function(picker, item)
          local Actions = require("snacks.picker.actions")
          local prev_right, prev_below = vim.o.splitright, vim.o.splitbelow
          vim.o.splitright = prev_right
          vim.o.splitbelow = false
          local ok, err = pcall(Actions.jump, picker, item, { cmd = "split" })
          vim.o.splitright = prev_right
          vim.o.splitbelow = prev_below
          if not ok then
            error(err)
          end
        end,
        open_down = function(picker, item)
          local Actions = require("snacks.picker.actions")
          local prev_right, prev_below = vim.o.splitright, vim.o.splitbelow
          vim.o.splitright = prev_right
          vim.o.splitbelow = true
          local ok, err = pcall(Actions.jump, picker, item, { cmd = "split" })
          vim.o.splitright = prev_right
          vim.o.splitbelow = prev_below
          if not ok then
            error(err)
          end
        end,
        select_item = function(picker)
          picker.list:select()
        end,
        insert_input = function()
          vim.cmd("startinsert")
        end,
      },
      win = {
        input = {
          keys = {
            ["<C-e>"] = { "list_down", mode = { "i", "n" } },
            ["<C-u>"] = { "list_up", mode = { "i", "n" } },
            ["<C-n>"] = { "focus_list", mode = { "i", "n" } }, -- back to list
            ["<C-p>"] = { "focus_preview", mode = { "i", "n" } },
            ["u"] = false,
            ["e"] = false,
            ["n"] = false,
            ["h"] = { "focus_list", mode = "n" },
            -- ["n"] = false,
            ["i"] = false,
            ["p"] = { "focus_preview", mode = "n" },
            ["k"] = "insert_input",
            ["<A-w>"] = false,
          },
        },
        list = {
          keys = {
            ["e"] = "list_down",
            ["u"] = "list_up",
            ["n"] = "cancel", -- like 'h' (left/cancel)
            ["i"] = "focus_preview",
            ["k"] = "focus_input", -- like 'i' (enter input)
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
          },
        },
        preview = {
          keys = {
            ["u"] = false,
            ["e"] = false,
            ["i"] = false,
            ["n"] = false,
            ["h"] = "focus_list",
            ["k"] = "focus_input",
            ["U"] = "preview_scroll_up",
            ["E"] = "preview_scroll_down",
            ["W"] = "cycle_win",
            ["<A-w>"] = false,
          },
        },
      },
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["e"] = "list_down",
                ["u"] = "list_up",
                ["n"] = "explorer_close", -- left/close
                ["i"] = "confirm", -- right/open
                ["k"] = "focus_input", -- matching insert mode habit
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
              },
            },
          },
        },
      },
    },
  },
}
