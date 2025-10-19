-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- 这是根据你 Vim 配置转换的 LazyVim keymap 配置
-- 请放在 lua/lazyvim/config/keymaps.lua
-- 按需调整 Snacks/LazyVim 相关部分以兼容你的实际插件环境

local map = vim.keymap.set

-- 设置 leader 键为空格
vim.g.mapleader = " "

-- 分屏操作
map("n", "si", ":set splitright<CR>:vsplit<CR>", { desc = "右分屏" })
map("n", "sn", ":set nosplitright<CR>:vsplit<CR>", { desc = "左分屏" })
map("n", "su", ":set nosplitbelow<CR>:split<CR>", { desc = "上分屏" })
map("n", "se", ":set splitbelow<CR>:split<CR>", { desc = "下分屏" })

-- 分屏后拖动
--map("n", "<Up>", ":res +5<CR>", { desc = "增加高度" })
--map("n", "<Down>", ":res -5<CR>", { desc = "减少高度" })
--map("n", "<Left>", ":vertical resize-5<CR>", { desc = "减少宽度" })
--map("n", "<Right>", ":vertical resize+5<CR>", { desc = "增加宽度" })

-- 水平/垂直分屏转换
map("n", "sv", "<C-w>t<C-w>H", { desc = "水平分屏换垂直" })
map("n", "sh", "<C-w>t<C-w>K", { desc = "垂直分屏换水平" })

map("n", "<leader><CR>", ":nohlsearch<CR>", { desc = "清除高亮" })

-- 搜索跳转
map("n", "=", "nzz", { desc = "下一条搜索并居中" })
map("n", "-", "Nzz", { desc = "上一条搜索并居中" })

-- 空格加回车输出 nohlsearch
map("n", "<leader><CR>", ":nohlsearch<CR>", { desc = "清除高亮" })

-- 普通/视觉/操作模式都映射
map({ "n", "v", "o" }, "n", "h", { desc = "左移光标" })
map({ "n", "v", "o" }, "u", "k", { desc = "上移光标" })
map({ "n", "v", "o" }, "e", "j", { desc = "下移光标" })
map({ "n", "v", "o" }, "i", "l", { desc = "右移光标" })
map({ "n", "v", "o" }, "U", "5k", { desc = "上移5行" })
map({ "n", "v", "o" }, "E", "5j", { desc = "下移5行" })

map({ "n", "v", "o" }, "W", "5w", { desc = "前进5个单词" })
map({ "n", "v", "o" }, "B", "5b", { desc = "后退5个单词" })
map({ "n", "v", "o" }, "h", "e", { desc = "到单词结尾" })

--  行内移动
map({ "n", "v", "o" }, "N", "^", { desc = "到行首" })
map({ "n", "v", "o" }, "I", "g_", { desc = "到行尾" })
map({ "n", "v", "o" }, "H", "0", { desc = "到行尾" })
map({ "n", "v", "o" }, "M", "$", { desc = "到行尾" })

-- 窗口管理
map("n", "<leader>wu", "<C-w>k", { desc = "窗口上移" })
map("n", "<leader>we", "<C-w>j", { desc = "窗口下移" })
map("n", "<leader>wn", "<C-w>h", { desc = "窗口左移" })
map("n", "<leader>wi", "<C-w>l", { desc = "窗口右移" })

-- 视图滚动
--map("n", "<C-U>", "5<C-y>", { desc = "向上滚动5行" })
--map("n", "<C-E>", "5<C-e>", { desc = "向下滚动5行" })
--map("i", "<C-U>", "<Esc>5<C-y>a", { desc = "插入模式向上滚动5行" })
--map("i", "<C-E>", "<Esc>5<C-e>a", { desc = "插入模式向下滚动5行" })

-- 自动补全选择
--map("i", "<C-i>", "<C-p>", { desc = "补全选择" })

-- 插入模式
map("n", "k", "i", { desc = "进入插入模式" })
map("n", "K", "I", { desc = "进入行首插入模式" })

-- 撤销
map("n", "l", "u", { desc = "撤销" })
map("i", "<C-z>", "<C-u>", { desc = "插入模式撤销" })

-- 没有映射
map("n", "s", "<nop>", { desc = "禁用 s 键" })

-- 保存/退出/重新加载
map("n", "S", ":w<cr>", { desc = "保存文件" })
map("n", "Q", ":q<cr>", { desc = "退出文件" })

-- 列命令映射
map("n", ";", ":", { desc = "命令行模式" })
map("n", "q;", "q:", { desc = "命令行模式（记录）" })

-- 兼容性相关命令（如 filetype, autochdir, bufread 自动跳转等）需在 init.lua 或 setup 里实现

-- 其余 LazyVim 原有映射和 Snacks 相关按需保留或注释

-- 你的配置已映射，欢迎进一步调整和补充！
