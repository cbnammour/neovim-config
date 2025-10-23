vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Format code with LSP
vim.keymap.set("n", "<leader>fmt", function()
    vim.lsp.buf.format({ timeout_ms = 2000 })
end, { desc = "Format code" })
