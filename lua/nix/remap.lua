vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Format code with LSP
vim.keymap.set("n", "<leader>fmt", function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
end, { desc = "Format code" })


-- remap jj to escape insert modern
vim.keymap.set("i", "jj", "<Esc>")
-- set a tiemout for escape sequences and enable timeout
vim.o.timeout = true
vim.o.timeoutlen = 500

-- remove arrow keymaps
vim.keymap.set("n", "<Up>", "<cmd>echo 'Use k to move up'<cr>")
vim.keymap.set("n", "<Down>", "<cmd>echo 'Use j to move down'<cr>")
vim.keymap.set("n", "<Left>", "<cmd>echo 'Use h to move left'<cr>")
vim.keymap.set("n", "<Right>", "<cmd>echo 'Use l to move right'<cr>")
vim.keymap.set("i", "<Up>", "<cmd>echo 'Use k to move up'<cr>")
vim.keymap.set("i", "<Down>", "<cmd>echo 'Use j to move down'<cr>")
vim.keymap.set("i", "<Left>", "<cmd>echo 'Use h to move left'<cr>")
vim.keymap.set("i", "<Right>", "<cmd>echo 'Use l to move right'<cr>")
vim.keymap.set("v", "<Up>", "<cmd>echo 'Use k to move up'<cr>")
vim.keymap.set("v", "<Down>", "<cmd>echo 'Use j to move down'<cr>")
vim.keymap.set("v", "<Left>", "<cmd>echo 'Use h to move left'<cr>")
vim.keymap.set("v", "<Right>", "<cmd>echo 'Use l to move right'<cr>")
