local motions = require("config.colemak").motions

return {
  {
    "folke/trouble.nvim",
    opts = function(_, opts)
      opts.modes = vim.tbl_deep_extend("force", opts.modes or {}, {
        lsp = {
          win = { position = "right" },
        },
      })
      opts.keys = vim.tbl_deep_extend("force", opts.keys or {}, {
        [motions.up] = "prev",
        [motions.down] = "next",
        [motions.left] = "close",
        [motions.right] = "jump",
        I = "inspect",
      })
    end,
  },
}
