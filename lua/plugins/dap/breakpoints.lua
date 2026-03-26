-- Breakpoint-only behavior lives in this file.
-- We keep it separate from core.lua so "running the debugger" and
-- "managing breakpoints" stay easy to read and change independently.

local function breakpoint_api()
  return require("persistent-breakpoints.api")
end

local function open_breakpoint_picker()
  local dap_breakpoints = require("dap.breakpoints")
  local items = dap_breakpoints.to_qf_list(dap_breakpoints.get())

  if vim.tbl_isempty(items) then
    vim.notify("No breakpoints set.", vim.log.levels.INFO, { title = "DAP" })
    return
  end

  -- Snacks already knows how to display the quickfix list nicely.
  -- Reusing it keeps this picker small and avoids maintaining a custom source.
  vim.fn.setqflist({}, " ", {
    title = "DAP Breakpoints",
    items = items,
  })

  local ok, snacks = pcall(require, "snacks")
  if ok and snacks.picker and snacks.picker.qflist then
    snacks.picker.qflist({ title = "DAP Breakpoints" })
    return
  end

  -- Fallback if Snacks is unavailable for any reason.
  vim.cmd.copen()
end

return {
  {
    "Weissle/persistent-breakpoints.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    opts = {
      -- Breakpoints should reappear as soon as an existing file is opened again.
      load_breakpoints_event = { "BufReadPost" },
    },
    config = function(_, opts)
      require("persistent-breakpoints").setup(opts)
    end,
    keys = {
      {
        "<leader>dB",
        function()
          breakpoint_api().set_conditional_breakpoint()
        end,
        desc = "Breakpoint Condition",
      },
      {
        "<leader>db",
        function()
          breakpoint_api().toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dm",
        function()
          breakpoint_api().set_log_point()
        end,
        desc = "Log Point",
      },
      {
        "<leader>dq",
        function()
          open_breakpoint_picker()
        end,
        desc = "Breakpoints Picker",
      },
      {
        "<leader>dX",
        function()
          breakpoint_api().clear_all_breakpoints()
        end,
        desc = "Clear Breakpoints",
      },
    },
  },
}
