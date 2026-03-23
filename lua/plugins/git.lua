return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.signs = vim.tbl_deep_extend("force", opts.signs or {}, {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      })
      opts.signs_staged = vim.tbl_deep_extend("force", opts.signs_staged or {}, {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      })
    end,
  },
}
