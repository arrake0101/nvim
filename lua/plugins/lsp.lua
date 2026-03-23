return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("colemak_lsp_keys", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          pcall(vim.keymap.del, "n", "K", { buffer = bufnr })
          vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, {
            buffer = bufnr,
            desc = "Hover",
          })
        end,
      })
    end,
  },
}
