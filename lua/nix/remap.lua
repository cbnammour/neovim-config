vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Format code with LSP
vim.keymap.set("n", "<leader>fmt", function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
end, { desc = "Format code" })


-- remap jj to escape insert modern
vim.keymap.set("i", "jj", "<Esc>")
-- set a tiemout for escape sequences and enable timeout
vim.o.timeout = true
vim.o.timeoutlen = 300
