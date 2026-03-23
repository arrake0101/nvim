vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- bootstrap lazy.nvim, LazyVim and your plugins

if _G.init_debug then
  local osv_path = vim.fn.stdpath("data") .. "/lazy/one-small-step-for-vimkind"

  if vim.loop.fs_stat(osv_path) then
    vim.opt.rtp:prepend(osv_path)
    require("osv").launch({ port = 8086, blocking = true })
  else
    print("Error: OSV plugin not found at " .. osv_path)
  end
end

require("config.lazy")
