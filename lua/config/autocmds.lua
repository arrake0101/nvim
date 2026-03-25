-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function set_cursor_highlight()
  local palette = vim.o.background == "light" and { bg = "#223249", fg = "#fff7e6" }
    or { bg = "#dca561", fg = "#1f1f28" }

  for _, group in ipairs({ "Cursor", "lCursor", "TermCursor" }) do
    vim.api.nvim_set_hl(0, group, {
      bg = palette.bg,
      fg = palette.fg,
    })
  end
end

local cursor_group = vim.api.nvim_create_augroup("adaptive_cursor_highlight", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
  group = cursor_group,
  callback = set_cursor_highlight,
})

vim.api.nvim_create_autocmd("OptionSet", {
  group = cursor_group,
  pattern = "background",
  callback = set_cursor_highlight,
})
