-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 这是根据你 Vim 配置转换的 LazyVim keymap 配置
-- 请放在 lua/lazyvim/config/keymaps.lua
-- 按需调整 Snacks/LazyVim 相关部分以兼容你的实际插件环境

local map = vim.keymap.set

-- 设置 leader 键为空格
vim.g.mapleader = " "
-- 在 lua/config/keymaps.lua 中添加：
-- 放在一起设置更舒服
vim.keymap.set("n", "gb", "<C-o>", { desc = "nav: [b]ack" })
vim.keymap.set("n", "gf", "<C-i>", { desc = "nav: [f]orward" })

-- 分屏操作
--map("n", "si", ":set splitright<CR>:vsplit<CR>", { desc = "split: [i] right" })
--map("n", "sn", ":set nosplitright<CR>:vsplit<CR>", { desc = "split: [n] left" })
--map("n", "su", ":set nosplitbelow<CR>:split<CR>", { desc = "split: [u] top" })
--map("n", "se", ":set splitbelow<CR>:split<CR>", { desc = "split: [e] bottom" })

-- 分屏后拖动
--map("n", "<Up>", ":res +5<CR>", { desc = "win: [<Up>] resize +5" })
--map("n", "<Down>", ":res -5<CR>", { desc = "win: [<Down>] resize -5" })
--map("n", "<Left>", ":vertical resize-5<CR>", { desc = "win: [<Left>] vertical resize -5" })
--map("n", "<Right>", ":vertical resize+5<CR>", { desc = "win: [<Right>] vertical resize +5" })

-- 水平/垂直分屏转换
map("n", "sv", "<C-w>t<C-w>H", { desc = "split: [v]ertical layout" })
map("n", "sh", "<C-w>t<C-w>K", { desc = "split: [h]orizontal layout" })

map("n", "<leader><CR>", ":nohlsearch<CR>", { desc = "search: [<CR>] clear highlight" })

-- 搜索跳转
map("n", "=", "nzz", { desc = "search: [=] next and center" })
map("n", "-", "Nzz", { desc = "search: [-] prev and center" })

-- 空格加回车输出 nohlsearch
map("n", "<leader><CR>", ":nohlsearch<CR>", { desc = "search: [<CR>] clear highlight" })

-- 普通/视觉/操作模式都映射
map({ "n", "v", "o" }, "n", "h", { desc = "motion: [n] left" })
map({ "n", "v", "o" }, "u", "k", { desc = "motion: [u] up" })
map({ "n", "v", "o" }, "e", "j", { desc = "motion: [e] down" })
map({ "n", "v", "o" }, "i", "l", { desc = "motion: [i] right" })
map({ "n", "v", "o" }, "U", "5k", { desc = "motion: [U] 5 lines up" })
map({ "n", "v", "o" }, "E", "5j", { desc = "motion: [E] 5 lines down" })

map({ "n", "v", "o" }, "W", "5w", { desc = "motion: [W] 5 words forward" })
map({ "n", "v", "o" }, "B", "5b", { desc = "motion: [B] 5 words backward" })
map({ "n", "v", "o" }, "h", "e", { desc = "motion: [h] end of word" })

--  行内移动
map({ "n", "v", "o" }, "N", "^", { desc = "motion: [N] line start" })
map({ "n", "v", "o" }, "I", "g_", { desc = "motion: [I] line end" })
map({ "n", "v", "o" }, "H", "0", { desc = "motion: [H] line start (0)" })
map({ "n", "v", "o" }, "M", "$", { desc = "motion: [M] line end ($)" })

-- 窗口管理
map("n", "<leader>wu", "<C-w>k", { desc = "win: [u] move up" })
map("n", "<leader>we", "<C-w>j", { desc = "win: [e] move down" })
map("n", "<leader>wn", "<C-w>h", { desc = "win: [n] move left" })
map("n", "<leader>wi", "<C-w>l", { desc = "win: [i] move right" })

-- 更快速的窗口切换 (Ctrl + 方向)
map("n", "<C-n>", "<C-w>h", { desc = "win: [n] move left" })
map("n", "<C-u>", "<C-w>k", { desc = "win: [u] move up" })
map("n", "<C-e>", "<C-w>j", { desc = "win: [e] move down" })
map("n", "<C-i>", "<C-w>l", { desc = "win: [i] move right" })

-- 视图滚动
--map("n", "<C-U>", "5<C-y>", { desc = "scroll: [U] 5 lines up" })
--map("n", "<C-E>", "5<C-e>", { desc = "scroll: [E] 5 lines down" })
--map("i", "<C-U>", "<Esc>5<C-y>a", { desc = "scroll: [U] insert up 5" })
--map("i", "<C-E>", "<Esc>5<C-e>a", { desc = "scroll: [E] insert down 5" })

-- 自动补全选择
--map("i", "<C-i>", "<C-p>", { desc = "edit: [i] completion select" })

-- 插入模式
map("n", "k", "i", { desc = "edit: [k] insert mode" })
map("n", "K", "I", { desc = "edit: [K] line start insert" })

-- 撤销
map("n", "l", "u", { desc = "edit: [l] undo" })
map("i", "<C-z>", "<C-u>", { desc = "edit: [z] undo in insert" })

-- 没有映射
--map("n", "s", "<nop>", { desc = "misc: [s] disabled" })

-- 保存/退出/重新加载
--map("n", "S", ":w<cr>", { desc = "file: [S] save" })
map("n", "Q", ":q<cr>", { desc = "file: [Q] quit" })

-- 列命令映射
map("n", ";", ":", { desc = "cmd: [;] enter command mode" })
map("n", "q;", "q:", { desc = "cmd: [;] command history" })

-- 兼容性相关命令（如 filetype, autochdir, bufread 自动跳转等）需在 init.lua 或 setup 里实现

-- 其余 LazyVim 原有映射和 Snacks 相关按需保留或注释
--
-- 你的配置已映射，欢迎进一步调整和补充！
--
--
--
--
--
-- :TODO
--
-- "akinsho/bufferline.nvim",
map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "buffer: [p]in toggle" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "buffer: [P]urge non-pinned" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "buffer: [r]ight close" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "buffer: [l]eft close" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "buffer: [h] prev" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "buffer: [l] next" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "buffer: [b] prev" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "buffer: [b] next" })
map("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "buffer: [B] move prev" })
map("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "buffer: [B] move next" })
map("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { desc = "buffer: [j] pick" })
--
--
-- "folke/noice.nvim",
-- sty
map("n", "<leader>sn", "", { desc = "noice: [n] prefix" })
map("c", "<S-Enter>", function()
  require("noice").redirect(vim.fn.getcmdline())
end, { desc = "noice: [<S-Enter>] redirect cmdline" })
map("n", "<leader>snl", function()
  require("noice").cmd("last")
end, { desc = "noice: [l] last message" })
map("n", "<leader>snh", function()
  require("noice").cmd("history")
end, { desc = "noice: [h] history" })
map("n", "<leader>sna", function()
  require("noice").cmd("all")
end, { desc = "noice: [a] all" })
map("n", "<leader>snd", function()
  require("noice").cmd("dismiss")
end, { desc = "noice: [d] dismiss all" })
map("n", "<leader>snt", function()
  require("noice").cmd("pick")
end, { desc = "noice: [t] picker" })
map({ "i", "n", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then
    return "<c-f>"
  end
end, { silent = true, expr = true, desc = "noice: [f] scroll forward" })
map({ "i", "n", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then
    return "<c-b>"
  end
end, { silent = true, expr = true, desc = "noice: [b] scroll backward" })

map("n", "<leader>n", function()
  if Snacks.config.picker and Snacks.config.picker.enabled then
    Snacks.picker.notifications()
  else
    Snacks.notifier.show_history()
  end
end, { desc = "snacks: [n] notifications" })
map("n", "<leader>un", function()
  Snacks.notifier.hide()
end, { desc = "snacks: [n] dismiss notifications" })
--
--
-- dashboard
--    "nvim-treesitter/nvim-treesitter-textobjects",
--    util.lua

-- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
-- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
-- { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },

-- "folke/persistence.nvim",
-- { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
-- { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
-- { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
-- { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
local ViewConfig = require("lazy.view.config")
ViewConfig.keys = {
  hover = "K",
  diff = "d",
  close = "Q",
  details = "<cr>",
  profile_sort = "<C-s>",
  profile_filter = "<C-f>",
  abort = "<C-c>",
  next = "]]",
  prev = "[[",
}
ViewConfig.commands = {
  home = {
    button = true,
    desc = "Go back to plugin list",
    id = 1,
    key = "n",
  },
  install = {
    button = true,
    desc = "Install missing plugins",
    desc_plugin = "Install a plugin",
    id = 2,
    key = "K",
    key_plugin = "k",
    plugins = true,
  },
  update = {
    button = true,
    desc = "Update plugins. This will also update the lockfile",
    desc_plugin = "Update a plugin. This will also update the lockfile",
    id = 3,
    key = "L",
    key_plugin = "l",
    plugins = true,
  },
  sync = {
    button = true,
    desc = "Run install, clean and update",
    desc_plugin = "Run install, clean and update",
    id = 4,
    key = "S",
    plugins = true,
  },
  clean = {
    button = true,
    desc = "Clean plugins that are no longer needed",
    desc_plugin = "Delete a plugin. WARNING: this will delete the plugin even if it should be installed!",
    id = 5,
    key = "X",
    key_plugin = "x",
    plugins = true,
  },
  check = {
    button = true,
    desc = "Check for updates and show the log (git fetch)",
    desc_plugin = "Check for updates and show the log (git fetch)",
    id = 6,
    key = "C",
    key_plugin = "c",
    plugins = true,
  },
  log = {
    button = true,
    desc = "Show recent updates",
    desc_plugin = "Show recent updates",
    id = 7,
    key = "G",
    key_plugin = "gl",
    plugins = true,
  },
  restore = {
    button = true,
    desc = "Updates all plugins to the state in the lockfile. For a single plugin: restore it to the state in the lockfile or to a given commit under the cursor",
    desc_plugin = "Restore a plugin to the state in the lockfile or to a given commit under the cursor",
    id = 8,
    key = "R",
    key_plugin = "r",
    plugins = true,
  },
  profile = {
    button = true,
    desc = "Show detailed profiling",
    id = 9,
    key = "P",
    toggle = true,
  },
  debug = {
    button = true,
    desc = "Show debug information",
    id = 10,
    key = "D",
    toggle = true,
  },
  help = {
    button = true,
    desc = "Toggle this help page",
    id = 11,
    key = "?",
    toggle = true,
  },
  clear = {
    desc = "Clear finished tasks",
    id = 12,
  },
  load = {
    desc = "Load a plugin that has not been loaded yet. Similar to `:packadd`. Like `:Lazy load foo.nvim`. Use `:Lazy! load` to skip `cond` checks.",
    id = 13,
    plugins = true,
    plugins_required = true,
  },
  health = {
    desc = "Run `:checkhealth lazy`",
    id = 14,
  },
  build = {
    desc = "Rebuild a plugin",
    id = 15,
    plugins = true,
    plugins_required = true,
    key_plugin = "gb",
  },
  reload = {
    desc = "Reload a plugin (experimental!!)",
    plugins = true,
    plugins_required = true,
    id = 16,
  },
}
