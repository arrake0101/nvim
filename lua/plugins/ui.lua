local motions = require("config.colemak").motions

return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.preset = "classic"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.highlights = opts.highlights or {}
      opts.highlights.buffer_selected = { italic = false, bold = false }
    end,
  },
  {
    "lazy.nvim",
    init = function()
      local view = require("lazy.view.config")
      view.keys.hover = "K"
      view.keys.diff = "d"
      view.keys.close = "q"
      view.keys.details = motions.right
      view.commands.home.key = motions.left
    end,
  },
}
