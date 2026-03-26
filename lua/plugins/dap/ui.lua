-- UI-only configuration stays in this file so adapter files can focus on debugger setup.
local motions = require("config.colemak").motions

return {
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {},
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>de", false },
      { "<leader>du", false },
      {
        "<leader>d" .. string.upper(motions.down),
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "x" },
      },
      {
        "<leader>d" .. string.upper(motions.up),
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
    },
    opts = function(_, opts)
      opts = opts or {}

      -- These mappings only change the DAP UI windows.
      -- They keep the navigation semantics aligned with your Colemak movement layer.
      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
        expand = { motions.right, "<CR>", "<2-LeftMouse>" },
        open = motions.right,
        edit = string.upper(motions.right),
        repl = "r",
        remove = "d",
        toggle = "t",
      })

      return opts
    end,
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup(opts)

      -- Open the UI when a session starts, and close it again when the session ends.
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close({})
      end
    end,
  },
}
