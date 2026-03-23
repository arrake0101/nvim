local map = vim.keymap.set

require("config.colemak").setup()

map("n", "gb", "<C-o>", { desc = "Jump Back" })
map("n", "gf", "<C-i>", { desc = "Jump Forward" })

map("n", "sv", "<C-w>t<C-w>H", { desc = "Vertical Split Layout" })
map("n", "sh", "<C-w>t<C-w>K", { desc = "Horizontal Split Layout" })

map("n", "<leader><CR>", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlight" })
map("n", "=", "nzz", { desc = "Next Search Result" })
map("n", "-", "Nzz", { desc = "Prev Search Result" })

map("n", "k", "i", { desc = "Insert Mode" })
map("n", "K", "I", { desc = "Insert at Line Start" })
map("n", "l", "u", { desc = "Undo" })
map("i", "<C-z>", "<C-u>", { desc = "Undo in Insert Mode" })

map("n", "Q", "<cmd>q<CR>", { desc = "Quit" })
map("n", ";", ":", { desc = "Command Mode" })
map("n", "q;", "q:", { desc = "Command History" })
