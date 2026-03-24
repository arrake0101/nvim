# `lua/plugins/git.lua`

## 作用

这个文件只定制 `gitsigns.nvim` 的符号样式。

## 为什么这样写

- 你没有重写 hunk 操作逻辑，只改了视觉层。
- 这说明当前阶段你认为 Git 的默认功能够用，真正需要统一的是视觉噪音和符号密度。

## 当前设计

- `add` / `change` / `changedelete` / `untracked` 统一用细竖线 `▎`
- `delete` / `topdelete` 用 ``

## 为什么这么配

- 细竖线占用空间小，适合频繁出现在 signcolumn。
- 删除用一个更明显的形状，有助于在视觉上快速区分“改动”与“删除”。
- staged 和 unstaged 采用一致风格，说明你的目标是“信息结构一致”，而不是让两个状态完全不同色相/符号体系。

