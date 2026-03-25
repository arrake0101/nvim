return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = function(_, opts)
      opts = opts or {}

      opts.code = vim.tbl_deep_extend("force", opts.code or {}, {
        sign = true,
        width = "full",
        right_pad = 0,
      })

      opts.heading = vim.tbl_deep_extend("force", opts.heading or {}, {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      })

      opts.checkbox = vim.tbl_deep_extend("force", opts.checkbox or {}, {
        enabled = true,
      })
    end,
  },
}
