# `lua/plugins/lsp.lua`

## 作用

这个文件当前只做一件事：在 LSP attach 后补充或修正缓冲区局部键位。

## 为什么这样写

- LSP 键位天生是 buffer-local 语义，更适合在 `LspAttach` 后设置。
- 这样可以避免在没有 LSP 的 buffer 里出现无效映射。

## 当前策略

### 删除 `K`

你显式删除了 buffer-local 的 `K`。

原因：

- 你的全局键位里 `K` 已经被重映射成“行首插入”。
- 如果保留 LSP 默认 hover，就会和你的主编辑动作冲突。

### 改成 `<leader>ch`

把 hover 放到 `<leader>ch`。

原因：

- 这是明确的“code / hover”语义。
- 既保留了 LSP 能力，又不抢普通模式高频编辑键。

## 这份文件的信号

它说明你对 LSP 的态度是保守覆盖：

- 不重写整套 LSP 架构
- 只修正最影响手感的冲突点

