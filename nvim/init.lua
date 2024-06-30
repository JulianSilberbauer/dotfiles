require("config.lazy")

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.keymap.set("n", "<leader>ft", "<cmd>NvimTreeToggle<cr>")
