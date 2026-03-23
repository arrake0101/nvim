return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dj", false },
      { "<leader>dk", false },
      {
        "<leader>de",
        function()
          require("dap").down()
        end,
        desc = "Down",
      },
      {
        "<leader>du",
        function()
          require("dap").up()
        end,
        desc = "Up",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    opts = function(_, opts)
      opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
        expand = { "<CR>", "i" },
        open = "i",
        edit = "I",
      })
    end,
    keys = {
      { "<leader>de", false, mode = { "n", "v" } },
      { "<leader>du", false },
      {
        "<leader>dE",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
      {
        "<leader>dU",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI",
      },
    },
  },
}
